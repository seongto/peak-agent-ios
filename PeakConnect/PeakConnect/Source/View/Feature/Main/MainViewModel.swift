//
//  MainViewModel.swift
//  PeakConnect
//
//  Created by MaxBook on 5/12/25.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewModel: UIViewController {
    private let isBeginnerRelay = BehaviorRelay<Void>(value: ())
    private let companyRelay = PublishRelay<Company>()
    private let disposeBag = DisposeBag()
    
}

extension MainViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let isBeginner: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                if UserDefaults.standard.isBegginer {
                    owner.isBeginnerRelay.accept(())
                } else {
                    // 네트워크 매니저에서 가져오기
                }
            })
            .disposed(by: disposeBag)
        
        
        return Output(
            isBeginner: isBeginnerRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}
