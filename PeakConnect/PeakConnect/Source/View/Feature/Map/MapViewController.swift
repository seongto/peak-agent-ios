//
//  MapViewController.swift
//  PeakConnect
//
//  Created by 강민성 on 5/22/25.
//

import UIKit

class MapViewController: UIViewController {
    
    private let mapView = MapView()
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.searchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapSearchButton() {
        let dummySearchVC = UIViewController()
        dummySearchVC.view.backgroundColor = .white
        dummySearchVC.title = "검색"
        navigationController?.pushViewController(dummySearchVC, animated: true)
        
    }
}
