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
import CoreLocation

class MapViewModel {
    var currentLocation: NMGLatLng = NMGLatLng(lat: 37.5665, lng: 126.9780)
    var currentAddress: String = "서울특별시 중구"

    struct Input {
        let fetchLeadsTrigger: Observable<NMGLatLng>
    }

    struct Output {
        let details: Driver<LeadRecommendationResponse>
        let isLoading: Driver<Bool>
        let error: Driver<String>
    }

    private let isLoading = BehaviorRelay<Bool>(value: false)
    private let errorTracker = PublishSubject<String>()

    func transform(input: Input) -> Output {
        let details = input.fetchLeadsTrigger
            .flatMapLatest { [weak self] location -> Observable<LeadRecommendationResponse> in
                guard let self = self else { return Observable.empty() }
                self.isLoading.accept(true)
            
                return Observable<LeadRecommendationResponse>.create { observer in
                    let locationCoordinate = CLLocation(latitude: location.lat, longitude: location.lng)
                    let geocoder = CLGeocoder()
                    
                    geocoder.reverseGeocodeLocation(locationCoordinate) { placemarks, error in
                        let address: String
                        if let placemark = placemarks?.first {
                            let city = placemark.administrativeArea ?? ""
                            let district = placemark.locality ?? placemark.subLocality ?? ""
                            address = "\(city) \(district)"
                        } else {
                            address = "주소 정보 없음"
                        }
                        
                        NetworkManager.shared.requestLeadRecommendation(
                            latitude: location.lat,
                            longitude: location.lng,
                            location: address
                        ) { result in
                            self.isLoading.accept(false)
                            switch result {
                            case .success(let data):
                                observer.onNext(data)
                                observer.onCompleted()
                            case .failure(let error):
                                self.errorTracker.onNext(error.localizedDescription)
                                observer.onError(error)
                            }
                        }
                    }
                    
                    return Disposables.create()
                }
            }
            .asDriver(onErrorDriveWith: .empty())

        return Output(
            details: details,
            isLoading: isLoading.asDriver(),
            error: errorTracker.asDriver(onErrorJustReturn: "알 수 없는 오류 발생")
        )
    }
}
