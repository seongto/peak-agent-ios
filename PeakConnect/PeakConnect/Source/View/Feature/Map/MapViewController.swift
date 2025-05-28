//
//  MapViewController.swift
//  PeakConnect
//
//  Created by 강민성 on 5/22/25.
//

import UIKit

class MapViewController: UIViewController {
    
    // 지도 뷰
    let mapView = MapView()
    
    override func loadView() {
        view = mapView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 검색 버튼 탭 시 액션
        mapView.modalSearchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
        // 현재 위치에서 리드 찾기 버튼 탭 시 액션
        mapView.modalLeadSearchButton.addTarget(self, action: #selector(didTapLeadResultsButton), for: .touchUpInside)
        
        // 백 버튼 액션
        mapView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }

    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    // 검색 버튼 탭 시 호출되는 메소드
    @objc private func didTapSearchButton() {
        let dummySearchVC = UIViewController()
        dummySearchVC.view.backgroundColor = .white
        dummySearchVC.title = "검색"
        navigationController?.pushViewController(dummySearchVC, animated: true)
    }
    
    // 현재 위치에서 리드 찾기 버튼 탭 시 호출 되는 메소드
    @objc private func didTapLeadResultsButton() {
        mapView.showLeadResultsView()
        mapView.modalSearchButton.isHidden = true
        mapView.modalLeadSearchButton.isHidden = true
        mapView.backButton.isHidden = true
    }
}
