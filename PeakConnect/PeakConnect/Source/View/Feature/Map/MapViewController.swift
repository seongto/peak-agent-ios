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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 검색 버튼 탭 시 액션
        mapView.searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
        // 현재 위치에서 리드 찾기 버튼 탭 시 액션
        mapView.leadSearchButton.addTarget(self, action: #selector(didTapLeadResultsButton), for: .touchUpInside)
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
        mapView.showLeadResults()
        mapView.searchButton.isHidden = true
        mapView.leadSearchButton.isHidden = true
    }
}
