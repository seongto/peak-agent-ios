//
//  IndustryPickerCollectionView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/23/25.
//

import UIKit

final class IndustryPickerCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        setupLayout()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 컬렉션뷰 설정

extension IndustryPickerCollectionView {
    
    private func setupLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
        self.collectionViewLayout = flowLayout
    }
    
    private func setupCollectionView() {
        register(IndustryPickerCollectionViewCell.self, forCellWithReuseIdentifier: IndustryPickerCollectionViewCell.id)
        register(IndustryPickerHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IndustryPickerHeaderView.id)
        isScrollEnabled = false
    }
}
