//
//  IndustryPickerCollectionView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/23/25.
//

import UIKit


final class IndustryPickerCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = IndustryPickerCollectionView.createLayout()) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private static func createLayout() -> UICollectionViewLayout {
        
        
        
        return UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(40))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(10)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.interGroupSpacing = 10

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]

            return section
        }
    }
}

// MARK: - 컬렉션뷰 설정

extension IndustryPickerCollectionView {
    private func setupCollectionView() {
        register(IndustryPickerCollectionViewCell.self, forCellWithReuseIdentifier: IndustryPickerCollectionViewCell.id)
        register(IndustryPickerHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IndustryPickerHeaderView.id)
        isScrollEnabled = false
        backgroundColor = .clear
    }
}
