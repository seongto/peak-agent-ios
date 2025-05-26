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

    // 지도에서 리드찾기 버튼 눌렀을 때 MapViewController로 이동
    @objc private func tapMapSearch() {
        let mapVC = MapViewController()
        mapVC.hidesBottomBarWhenPushed = true
        mapVC.loadViewIfNeeded()
        mapVC.mapView.showOnlyCurrentLocationMarker()
        navigationController?.pushViewController(mapVC, animated: true)
    }
}

extension MainViewController {
    
    private func bind() {
        let viewWillAppear = rx.methodInvoked(#selector(viewWillAppear)).map { _ in }
        let input = MainViewModel.Input(viewWillAppear: viewWillAppear)
        let output = mainViewModel.transform(input: input)
        
        output.isBeginner
            .drive(with: self, onNext: { owner, _ in
                print("dd")
                owner.connectCreateCompanyView()
            })
            .disposed(by: disposeBag)
    }
    
}

extension MainViewController {
    
    private func connectCreateCompanyView() {
        let createCompanyViewModel = CreateCompanyViewModel(mode: .create)
        let createCompanyViewController = CreateCompanyViewController(viewModel: createCompanyViewModel)
        createCompanyViewController.modalPresentationStyle = .overFullScreen
        present(createCompanyViewController, animated: false)
    }
}
