//
//  MapViewModel.swift
//  PeakConnect
//
//  Created by 강민성 on 5/22/25.
//

import Foundation
import NMapsMap
import RxSwift
import RxCocoa

class MapViewModel {
    var currentLocation: NMGLatLng = NMGLatLng(lat: 37.5665, lng: 126.9780)
    var currentAddress: String = "서울특별시 중구"

    struct Input {
        let fetchLeadsTrigger: Observable<Void>
    }

    struct Output {
        let leads: Driver<[Lead]>
        let leadCoordinates: Driver<[NMGLatLng]>
        let isLoading: Driver<Bool>
        let error: Driver<String>
    }

    private let isLoading = BehaviorRelay<Bool>(value: false)
    private let errorTracker = PublishSubject<String>()

    func transform(input: Input) -> Output {
        let leads = input.fetchLeadsTrigger
            .flatMapLatest { [weak self] _ -> Observable<[Lead]> in
                guard let self = self else { return Observable.just([]) }
                self.isLoading.accept(true)
                return Observable.create { observer in
                    NetworkManager.shared.requestLeadRecommendation(
                        latitude: self.currentLocation.lat,
                        longitude: self.currentLocation.lng,
                        location: self.currentAddress
                    ) { result in
                        self.isLoading.accept(false)
                        switch result {
                        case .success(let data):
                            print("✅ API 응답 leads: \(data.leads)")
                            observer.onNext(data.leads)
                        case .failure(let error):
                            self.errorTracker.onNext(error.localizedDescription)
                            observer.onNext([])
                        }
                    }
                    return Disposables.create()
                }
            }
            .asDriver(onErrorJustReturn: [])

        let leadCoordinates = leads
            .map { $0.map { NMGLatLng(lat: $0.latitude, lng: $0.longitude) } }

        return Output(
            leads: leads,
            leadCoordinates: leadCoordinates,
            isLoading: isLoading.asDriver(),
            error: errorTracker.asDriver(onErrorJustReturn: "알 수 없는 오류 발생")
        )
    }
}
