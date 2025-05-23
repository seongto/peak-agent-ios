//
//  MainViewController.swift
//  PeakConnect
//
//  Created by MaxBook on 5/12/25.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 지도에서 리드찾기 버튼에 액션 연결
        mainView.mapSearchButton.addTarget(self, action: #selector(tapMapSearch), for: .touchUpInside)
    }

    // 지도에서 리드찾기 버튼 눌렀을 때 MapViewController로 이동
    @objc private func tapMapSearch() {
        let mapVC = MapViewController()
        navigationController?.pushViewController(mapVC, animated: true)
    }
}
