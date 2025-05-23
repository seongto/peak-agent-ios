//
//  IndustryPickerCollectionView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/23/25.
//

import UIKit

class IndustryPickerCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.minimumLineSpacing = 8
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)

        super.init(frame: frame, collectionViewLayout: flowLayout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        register(IndustryPickerCollectionViewCell.self, forCellWithReuseIdentifier: IndustryPickerCollectionViewCell.id)
        register(IndustryPickerHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IndustryPickerHeaderView.id)
        
        isScrollEnabled = false

    }
    
    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
