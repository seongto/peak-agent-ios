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
        historyView.colletionView.delegate = self
        historyView.colletionView.dataSource = self
    }
}

extension HistoryViewController {
    
    private func bind() {
        
    }
}

extension HistoryViewController: UICollectionViewDataSource {
    
}

extension HistoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryViewCollectionViewCell.id, for: indexPath) as? HistoryViewCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
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
