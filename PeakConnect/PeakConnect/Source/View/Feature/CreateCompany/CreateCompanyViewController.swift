//
//  CreateCompanyViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/22/25.
//

import UIKit

class CreateCompanyViewController: UIViewController {
    
    let createCompanyView = CreateCompanyView()
    
    override func loadView() {
        view = createCompanyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
