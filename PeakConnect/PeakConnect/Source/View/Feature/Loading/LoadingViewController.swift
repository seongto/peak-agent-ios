//
//  LoadingViewController.swift
//  PeakConnect
//
//  Created by 강민성 on 6/2/25.
//

import UIKit

class LoadingViewController: UIViewController {
    
    override func loadView() {
        self.view = LoadingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 필요한 추가 설정이 있으면 여기에 작성
    }
}
