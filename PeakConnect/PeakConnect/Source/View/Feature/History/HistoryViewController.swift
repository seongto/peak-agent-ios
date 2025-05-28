//
//  HistoryViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController {
    
    private let historyView = HistoryView()
    private let historyViewModel = HistoryViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = historyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        historyView.colletionView.delegate = self

    }
}

extension HistoryViewController {
    
    private func bind() {
        let viewWillAppear = rx.methodInvoked(#selector(viewWillAppear)).map { _ in }
        let input = HistoryViewModel.Input(viewWillAppear: viewWillAppear)
        let output = historyViewModel.transform(input: input)
        
        output.history
            .drive(historyView.colletionView.rx.items(
                cellIdentifier: HistoryViewCollectionViewCell.id,
                cellType: HistoryViewCollectionViewCell.self)) { row, element, cell in
                    print("ddddd")
                    cell.configure(history: element!)
                }
                .disposed(by: disposeBag)
    }
}

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 167)
    }
}
