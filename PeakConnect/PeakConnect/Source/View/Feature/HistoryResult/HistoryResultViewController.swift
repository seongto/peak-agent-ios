//
//  HistoryResultViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryResultViewController: UIViewController {
    
    private let historyResultView = HistoryResultView()
    private let historyResultViewModel = HistoryResultViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = historyResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension HistoryViewController {
    
}
