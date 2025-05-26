//
//  CreateCompanyViewModel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/26/25.
//

import Foundation
import RxSwift
import RxCocoa

enum CreateCompanyMode {
    
    case create
    case edit(company: Company)
}

final class CreateCompanyViewModel {
    
    private var countRelay = BehaviorRelay<String>(value: "0/100")
    private var industryRelay = BehaviorRelay<[Industry]>(value: [])
    
    private var companyName: String = ""
    private var companyDescription: String = ""
    private var industy: [Industry] = []
    
    private let disposeBag = DisposeBag()
    
    init(mode: CreateCompanyMode) {
        
        switch mode {
        case .edit(let company):
            companyName = company.name
            companyDescription = company.description
            industy = company.industry
        case .create:
            break
        }
    }
}

extension CreateCompanyViewModel {
    
    struct Input {
        let companyNameTextFieldInput: Observable<String>
        let companyDescriptionTextFieldInput: Observable<String>
        let industryButtonTapped: Observable<Industry>
    }
    
    struct Output {
        let companyDescriptionCount: Driver<String>
        let industry: Driver<[Industry]>
    }
    
    func transform(input: Input) -> Output {
        input.companyNameTextFieldInput
            .withUnretained(self)
            .subscribe(onNext: { owner, name in
                print(name)
            })
            .disposed(by: disposeBag)
        
        input.companyDescriptionTextFieldInput
            .withUnretained(self)
            .subscribe(onNext: { owner, description in
                owner.countRelay.accept("\(description.count)/\(100)")
            })
            .disposed(by: disposeBag)
        
        input.industryButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, string in
                if owner.industy.contains(string) {
                    //
                    //owner.industy.re
                    owner.industryRelay.accept(owner.industy)
                } else {
                    owner.industy.append(string)
                    owner.industryRelay.accept(owner.industy)
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            companyDescriptionCount: countRelay.asDriver(onErrorDriveWith: .empty()),
            industry: industryRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}
