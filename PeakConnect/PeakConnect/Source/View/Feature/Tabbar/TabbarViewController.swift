//
//  TabbarViewController.swift
//  PeakConnect
//
//  Created by 강민성 on 5/23/25.
//

import UIKit

class TabbarViewController: UIViewController {
    
    let tabbarView = TabbarView()
    
    override func loadView() {
        view = TabbarView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
