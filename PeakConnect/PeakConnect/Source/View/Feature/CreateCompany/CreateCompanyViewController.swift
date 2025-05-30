//
//  CreateCompanyViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/22/25.
//

import UIKit
import RxSwift
import RxCocoa

final class CreateCompanyViewController: UIViewController {
    
    private let createCompanyView = CreateCompanyView()
    private var createCompanyViewModel: CreateCompanyViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: CreateCompanyViewModel) {
        self.createCompanyViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = createCompanyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - bind

extension CreateCompanyViewController {
    
    private func bind() {
        let name = createCompanyView.companyNameTextField.rx.text.orEmpty.skip(1).asObservable()
        let description = createCompanyView.companyDescriptionTextView.rx.text.orEmpty.skip(1).asObservable()
        
        let registerbuttonTapped = createCompanyView.createButton.rx.tap.asObservable()
        
        let input = CreateCompanyViewModel.Input(
            companyNameTextFieldInput: name,
            companyDescriptionTextFieldInput: description,
            registerButtonTapped: registerbuttonTapped
        )
        
        let output = createCompanyViewModel.transform(input: input)
        
        output.companyDescriptionCount
            .drive(with: self, onNext: { owner, count in
                owner.createCompanyView.companyDescriptionCountLabel.text = "\(count)/100"
                if count > 100 {
                    owner.createCompanyView.overCount()
                } else {
                    owner.createCompanyView.underCount()
                }
            })
            .disposed(by: disposeBag)
        
        output.complete
            .drive(with: self, onNext: { owner, mode  in
                owner.gobackMain(mode: mode)
            })
            .disposed(by: disposeBag)
        
        output.company
            .drive(with: self, onNext: { owner, company in
                guard let company = company else { return }
                owner.createCompanyView.setupEditMode(company)
                owner.navigation()
            })
            .disposed(by: disposeBag)
    }
    
    private func gobackMain(mode: CreateCompanyMode) {
        switch mode {
        case .create:
            navigationController?.popViewController(animated: true)
        case .edit(_):
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func navigation() {
        navigationController?.navigationBar.isHidden = false
        let titleLabel = UILabel()
        titleLabel.text = "회사 정보 수정"
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        navigationItem.titleView = titleLabel

    }
}
