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
    let fetchRelay = PublishRelay<Void>()
    private let companyRelay = PublishRelay<Company>()
    private let disposeBag = DisposeBag()
    
}

extension MainViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let isBeginner: Driver<Void>
        let company: Driver<Company>
    }
    
    func transform(input: Input) -> Output {
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                if UserDefaults.standard.isBegginer {
                    owner.fetchData()
                } else {
                    owner.isBeginnerRelay.accept(())
                }
            })
            .disposed(by: disposeBag)
        
        
        return Output(
            isBeginner: isBeginnerRelay.asDriver(onErrorDriveWith: .empty()),
            company: companyRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

extension MainViewModel {
    
    private func fetchData() {
        NetworkManager.shared.requestCompany() { result in
            switch result {
            case .success(let input):
                let industries = input.industry.split(separator: ",").map { Industry(name: $0.trimmingCharacters(in: .whitespaces)) }
                let company = Company(name: input.name, description: input.description, industry: industries)
                self.companyRelay.accept(company)
                print("회사 조회 성공:", company)
            case .failure(let error):
                print("회사 조회 실패:", error.localizedDescription)
            }
        }    }
}
