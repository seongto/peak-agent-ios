//
//  MainViewController.swift
//  PeakConnect
//
//  Created by MaxBook on 5/12/25.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainView = MainView()
        mainView.autoresizingMask = [.flexibleWidth, . flexibleHeight]
        self.view = mainView
        
    }


}

