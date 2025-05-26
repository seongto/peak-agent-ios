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
    private var industryRelay = BehaviorRelay<[String]>(value: [])
    
    private var companyName: String = ""
    private var companyDescription: String = ""
    private var industy: [Industry] = []
    
    private let disposeBag = DisposeBag()
    
    init(mode: CreateCompanyMode) {
        switch mode {
        case .create:
        case .edit(let company):
            companyName = company.name
            companyDescription = company.description
            industy = company.industry
        }
    }
}

extension CreateCompanyViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let companyNameTextFieldInput: Observable<String>
        let companyDescriptionTextFieldInput: Observable<String>
        let industryButtonTapped: Observable<Industry>
    }
    
    struct Output {
        let companyDescriptionCount: Driver<String>
        let industry: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        
        return Output(
            companyDescriptionCount: countRelay.asDriver(onErrorDriveWith: .empty()),
            industry: industryRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}
