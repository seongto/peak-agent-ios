//
//  MainViewController.swift
//  PeakConnect
//
//  Created by MaxBook on 5/12/25.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    let mainView = MainView()
    private let mainViewModel = MainViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()

    // 지도에서 리드찾기 버튼에 액션 연결
    mainView.mapSearchButton.addTarget(self, action: #selector(tapMapSearch), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = true
    }

    // 지도에서 리드찾기 버튼 눌렀을 때 MapViewController로 이동
    @objc private func tapMapSearch() {
        let mapVC = MapViewController()
        mapVC.mapView.showOnlyCurrentLocationMarker()
        navigationController?.pushViewController(mapVC, animated: true)
    }
}

extension MainViewController {
    
    private func bind() {
        let viewWillAppear = rx.methodInvoked(#selector(viewWillAppear)).map { _ in }
        let editCompanyButtonTapped = mainView.editCompanyButton.rx.tap.asObservable()
        let input = MainViewModel.Input(viewWillAppear: viewWillAppear, editCompanyButtonTapped: editCompanyButtonTapped)
        
        let output = mainViewModel.transform(input: input)
        
        output.isBeginner
            .skip(1)
            .drive(with: self, onNext: { owner, _ in
                owner.connectCreateCompanyView(mode: .create)
            })
            .disposed(by: disposeBag)
        
        output.company
            .drive(with: self, onNext: { owner, company in
                owner.mainView.setupData(company: company)
            })
            .disposed(by: disposeBag)
        
        output.edit
            .drive(with: self, onNext: { owner, company in
                owner.connectCreateCompanyView(mode: .edit(company: company))
            })
            .disposed(by: disposeBag)
    }
    
}

extension MainViewController {
    
    private func connectCreateCompanyView(mode: CreateCompanyMode) {
        let createCompanyViewModel = CreateCompanyViewModel(mode: mode)
        let createCompanyViewController = CreateCompanyViewController(viewModel: createCompanyViewModel)
        
        switch mode {
        case .create:
            navigationController?.pushViewController(createCompanyViewController, animated: false)

        case .edit(_):
            navigationController?.pushViewController(createCompanyViewController, animated: true)
        }
    }
}
