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
        let fetchTrigger: Observable<Int>
    }

    struct Output {
        let detail: Driver<LeadDetail>
        let isLoading: Driver<Bool>
        let error: Driver<String>
    }

    private let disposeBag = DisposeBag()
    private let detailRelay = PublishRelay<LeadDetail>()
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let errorRelay = PublishRelay<String>()

    func transform(input: Input) -> Output {
        input.fetchTrigger
            .do(onNext: { [weak self] _ in
                self?.isLoadingRelay.accept(true)
            })
            .flatMapLatest { leadId in
                Observable<LeadDetail>.create { observer in
                    NetworkManager.shared.requestLeadDetail(id: leadId) { result in
                        switch result {
                        case .success(let detail):
                            observer.onNext(detail)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
                    return Disposables.create()
                }
            }
            .subscribe(onNext: { [weak self] detail in
                self?.detailRelay.accept(detail)
                self?.isLoadingRelay.accept(false)
            }, onError: { [weak self] error in
                self?.errorRelay.accept(error.localizedDescription)
                self?.isLoadingRelay.accept(false)
            })
            .disposed(by: disposeBag)

        return Output(
            detail: detailRelay.asDriver(onErrorDriveWith: .empty()),
            isLoading: isLoadingRelay.asDriver(),
            error: errorRelay.asDriver(onErrorJustReturn: "알 수 없는 오류 발생")
        )
    }
}
