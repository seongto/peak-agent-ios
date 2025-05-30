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
    
    private var countRelay = BehaviorRelay<Int>(value: 0)
    private var completeRelay = PublishRelay<CreateCompanyMode>()
    private var companyRelay = BehaviorRelay<Company?>(value: nil)
    
    private var companyName: String = ""
    private var companyDescription: String = ""
    
    private let disposeBag = DisposeBag()
    
    init(mode: CreateCompanyMode) {
        switch mode {
        case .edit(let company):
            companyName = company.name
            companyDescription = company.description
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
        let registerButtonTapped: Observable<Void>
    }
    
    struct Output {
        let companyDescriptionCount: Driver<Int>
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
                owner.countRelay.accept(description.count)
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
            complete: completeRelay.asDriver(onErrorDriveWith: .empty()),
            company: companyRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

// MARK: - Actions

extension CreateCompanyViewModel {
    
    private func registerCompany(mode: CreateCompanyMode) {        
        NetworkManager.shared.registerCompany(
            name: companyName,
            description: companyDescription,
            mode: mode
        ) { result in
            switch result {
            case .success(let uuid):
                UserDefaults.standard.isBegginer = true
                UserDefaults.standard.companyName = self.companyName
                self.completeRelay.accept(mode)
                guard let uuid = uuid else {
                    return
                }
                UserDefaults.standard.uuid = uuid
                print("회사 등록 성공, UUID:", uuid)
            case .failure(let error):
                print("회사 등록 실패:", error.localizedDescription)
            }
        }
    }
}
 
