//
//  HistoryViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private let historyView = HistoryView()
    private let historyViewModel = HistoryViewModel()
    
    override func loadView() {
        view = historyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension HistoryViewController {
    
    private func bind() {
        
    }
}
