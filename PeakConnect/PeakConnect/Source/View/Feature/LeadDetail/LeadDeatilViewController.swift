//
//  LeadDeatilViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/29/25.
//

import UIKit
import RxSwift
import RxCocoa

class LeadDeatilViewController: UIViewController {
    
    private let leadDeatilView = LeadDeatilView()
    private let leadDeatilViewModel: LeadDeatilViewModel
    
    private let disposeBag = DisposeBag()
    
    init(leadDeatilViewModel: LeadDeatilViewModel) {
        self.leadDeatilViewModel = leadDeatilViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = leadDeatilView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
}

extension LeadDeatilViewController {
    
    private func bind() {
        let viewWillAppear = rx.methodInvoked(#selector(viewWillAppear)).map { _ in }
        let copyButtonTapped = Observable.merge(
            leadDeatilView.locationView.copyButton.rx.tap.asObservable(),
            leadDeatilView.siteView.copyButton.rx.tap.asObservable()
        )
        let input = LeadDeatilViewModel.Input(
            viewWillAppear: viewWillAppear,
            copyButtonTapped: copyButtonTapped
        )
        let output = leadDeatilViewModel.transform(input: input)
        
        output.leadInfo
            .drive(with: self, onNext: { owner, result in
                owner.leadDeatilView.configure(result)
            })
            .disposed(by: disposeBag)
        
        output.title
            .drive(with: self, onNext: { owner, result in
                owner.setupNavigation(result)
            })
            .disposed(by: disposeBag)
        
        output.copyText
            .drive(with: self, onNext: { owner, _ in
                owner.popupToastView()
            })
            .disposed(by: disposeBag)
    }
}

extension LeadDeatilViewController {
    
    private func setupNavigation(_ title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        navigationItem.titleView = titleLabel
    }
    
    private func popupToastView() {
        leadDeatilView.toastView.showToastMessage()
    }
}
