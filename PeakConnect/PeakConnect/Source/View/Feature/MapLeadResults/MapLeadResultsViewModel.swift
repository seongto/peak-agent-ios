//
//  MapLeadResultsViewModel.swift
//  PeakConnect
//
//  Created by 강민성 on 5/26/25.
//

import RxSwift
import RxCocoa

class MapLeadResultsViewModel {

    struct Input {
        let fetchTrigger: Observable<Void>
    }

    struct Output {
        let details: Driver<LeadRecommendationResponse>
        let isLoading: Driver<Bool>
        let error: Driver<String>
    }

    private let disposeBag = DisposeBag()
    private let detailsRelay = PublishRelay<LeadRecommendationResponse>()
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let errorRelay = PublishRelay<String>()

    func transform(input: Input) -> Output {
        input.fetchTrigger
            .do(onNext: { [weak self] _ in
                self?.isLoadingRelay.accept(true)
            })
            .flatMapLatest { [weak self] _ -> Observable<LeadRecommendationResponse> in
                guard let self = self else {
                    return Observable.empty()
                }
                return Observable.create { observer in
                    //let center = mapView.cameraPosition.target
                    NetworkManager.shared.requestLeadRecommendation(
                        latitude: 37.5665,
                        longitude: 126.9780,
                        location: "서울특별시 중구"
                    ) { result in
                        self.isLoadingRelay.accept(false)
                        switch result {
                        case .success(let data):
                            observer.onNext(data)
                            observer.onCompleted()
                        case .failure(let error):
                            self.errorRelay.accept(error.localizedDescription)
                            observer.onError(error)
                        }
                    }
                    return Disposables.create()
                }
            }
            .subscribe(onNext: { [weak self] detail in
                self?.detailsRelay.accept(detail)
            })
            .disposed(by: disposeBag)

        return Output(
            details: detailsRelay.asDriver(onErrorDriveWith: .empty()),
            isLoading: isLoadingRelay.asDriver(),
            error: errorRelay.asDriver(onErrorJustReturn: "알 수 없는 오류 발생")
        )
    }
}
