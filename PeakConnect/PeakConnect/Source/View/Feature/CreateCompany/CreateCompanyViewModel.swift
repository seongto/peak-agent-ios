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
    private var completeRelay = PublishRelay<CreateCompanyMode>()
    private var companyRelay = BehaviorRelay<Company?>(value: nil)
    
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
            companyRelay.accept(company)
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
        let registerButtonTapped: Observable<Void> // 추가
    }
    
    struct Output {
        let companyDescriptionCount: Driver<String>
        let industry: Driver<[Industry]>
        let complete: Driver<CreateCompanyMode>
        let company: Driver<Company?>
    }
    
    func transform(input: Input) -> Output {
        input.companyNameTextFieldInput
            .withUnretained(self)
            .subscribe(onNext: { owner, name in
                owner.companyName = name
            })
            .disposed(by: disposeBag)
        
        input.companyDescriptionTextFieldInput
            .withUnretained(self)
            .subscribe(onNext: { owner, description in
                owner.companyDescription = description
                owner.countRelay.accept("\(description.count)/\(100)")
            })
            .disposed(by: disposeBag)
        
        input.industryButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, industry in
                if owner.industy.contains(industry) {
                    owner.industryRelay.accept(owner.industy)
                } else {
                    owner.industy.append(industry)
                    owner.industryRelay.accept(owner.industy)
                }
            })
            .disposed(by: disposeBag)
        
        input.registerButtonTapped
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
            
                if let company = owner.companyRelay.value {
                    owner.registerCompany(mode: .edit(company: company))

                } else {
                    owner.registerCompany(mode: .create)
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            companyDescriptionCount: countRelay.asDriver(onErrorDriveWith: .empty()),
            industry: industryRelay.asDriver(onErrorDriveWith: .empty()),
            complete: completeRelay.asDriver(onErrorDriveWith: .empty()),
            company: companyRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

// MARK: - Actions

extension CreateCompanyViewModel {
    
    private func registerCompany(mode: CreateCompanyMode) {        
        let industryText = industy.map { $0.name }.joined(separator: ",")
        NetworkManager.shared.registerCompany(
            name: companyName,
            industry: industryText,
            description: companyDescription,
            mode: mode
        ) { result in
            switch result {
            case .success(let uuid):
                UserDefaults.standard.isBegginer = true
                self.completeRelay.accept(mode)
                print("회사 등록 성공, UUID:", uuid)
            case .failure(let error):
                print("회사 등록 실패:", error.localizedDescription)
            }
        }
    }
}
 
