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
    private var completeRelay = PublishRelay<Void>()
    
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
        let registerButtonTapped: Observable<Void> // 추가
    }
    
    struct Output {
        let companyDescriptionCount: Driver<String>
        let industry: Driver<[Industry]>
        let complete: Driver<Void>
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
                owner.registerCompany()
            })
            .disposed(by: disposeBag)
        
        return Output(
            companyDescriptionCount: countRelay.asDriver(onErrorDriveWith: .empty()),
            industry: industryRelay.asDriver(onErrorDriveWith: .empty()),
            complete: completeRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

// MARK: - Actions

extension CreateCompanyViewModel {
    
    private func registerCompany() {
        // 테스트용 UUID 직접 세팅
        NetworkManager.shared.companyUUID = "12345678-1234-1234-1234-123456789012"
        
        let industryText = industy.map { $0.name }.joined(separator: ",")
        NetworkManager.shared.registerCompany(
            name: companyName,
            industry: industryText,
            description: companyDescription
        ) { result in
            switch result {
            case .success(let uuid):
                print("회사 등록 성공, UUID:", uuid)
                // TODO: 후속 처리 (예: 화면 닫기, 알림 표시 등)
            case .failure(let error):
                print("회사 등록 실패:", error.localizedDescription)
                // TODO: 에러 처리 (예: 알림 표시)
            }
        }
    }
}
 
