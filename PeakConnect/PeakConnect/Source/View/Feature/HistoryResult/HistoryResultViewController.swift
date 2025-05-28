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
        bind()
        historyResultView.collectionView.delegate = self
        historyResultView.collectionView.dataSource = self
    }
}

extension HistoryResultViewController {
    
    private func bind() {
        
    }
}

extension HistoryResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HistoryResultCollectionViewCell.id,
            for: indexPath
        ) as? HistoryResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension HistoryResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 87)
    }
}
