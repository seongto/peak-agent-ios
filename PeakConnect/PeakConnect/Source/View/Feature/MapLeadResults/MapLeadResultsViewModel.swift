//
//  MapLeadResultsViewModel.swift
//  PeakConnect
//
//  Created by 강민성 on 5/26/25.
//

import Foundation
import RxSwift
import RxCocoa

class MapLeadResultsViewModel {

    struct Input {
        let fetchTrigger: Observable<Void>
    }

    struct Output {
        let leadIds: Driver<[Int]>
        let isLoading: Driver<Bool>
        let error: Driver<String>
    }

    private let disposeBag = DisposeBag()
    private let leadsRelay = PublishRelay<[Int]>()
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let errorRelay = PublishRelay<String>()

    func transform(input: Input) -> Output {
        input.fetchTrigger
            .do(onNext: { [weak self] _ in
                self?.isLoadingRelay.accept(true)
            })
            .flatMapLatest { _ -> Observable<[Int]> in
                return Observable.create { observer in
                    NetworkManager.shared.requestLeadRecommendation(
                        latitude: 37.5665,
                        longitude: 126.9780,
                        location: "서울특별시 중구"
                    ) { result in
                        self.isLoadingRelay.accept(false)
                        switch result {
                        case .success(let data):
                            let ids = data.leads.map { $0.id }
                            observer.onNext(ids)
                            observer.onCompleted()
                        case .failure(let error):
                            self.errorRelay.accept(error.localizedDescription)
                            observer.onNext([])
                            observer.onCompleted()
                        }
                    }
                    return Disposables.create()
                }
            }
            .subscribe(onNext: { [weak self] ids in
                self?.leadsRelay.accept(ids)
            })
            .disposed(by: disposeBag)

        return Output(
            leadIds: leadsRelay.asDriver(onErrorDriveWith: .empty()),
            isLoading: isLoadingRelay.asDriver(),
            error: errorRelay.asDriver(onErrorJustReturn: "알 수 없는 오류 발생")
        )
    }
}
