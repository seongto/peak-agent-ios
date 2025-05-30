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
    private let editRelay = PublishRelay<Company>()
    private let companyNameRelay = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    private var company: Company?
    
}

extension MainViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let editCompanyButtonTapped: Observable<Void>
    }
    
    struct Output {
        let isBeginner: Driver<Void>
        let companyName: Driver<String>
        let edit: Driver<Company>
    }
    
    func transform(input: Input) -> Output {
        
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                if UserDefaults.standard.isBegginer {
                    owner.companyNameRelay.accept(UserDefaults.standard.companyName)
                } else {
                    owner.isBeginnerRelay.accept(())
                }
            })
            .disposed(by: disposeBag)
        
        input.editCompanyButtonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.fetchData()
            })
            .disposed(by: disposeBag)
        
        
        return Output(
            isBeginner: isBeginnerRelay.asDriver(onErrorDriveWith: .empty()),
            companyName: companyNameRelay.asDriver(onErrorDriveWith: .empty()),
            edit: editRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

extension MainViewModel {
    
    private func fetchData() {
        NetworkManager.shared.requestCompany() { result in
            switch result {
            case .success(let input):
                print(input)
                let company = Company(name: input.name, description: input.description)
                self.editRelay.accept(company)
                print("회사 조회 성공:", company)
            case .failure(let error):
                print("회사 조회 실패:", error.localizedDescription)
            }
        }
    }
}
