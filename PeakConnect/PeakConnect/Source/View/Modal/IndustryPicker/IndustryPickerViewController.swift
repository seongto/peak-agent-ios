//
//  IndustryPickerViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/23/25.
//

import UIKit
import SnapKit

class IndustryPickerViewController: UIViewController {
    
    enum Section: Hashable {
        case category(IndustryCategory)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Industry>!
    private let industryPickerView = IndustryPickerView()
    
    override func loadView() {
        view = industryPickerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        industryPickerView.collectionView.delegate = self // 꼭 추가
        setupDataSource()
        applySnapshot()
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Industry>(collectionView: industryPickerView.collectionView) {
            (collectionView, indexPath, industry) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IndustryPickerCollectionViewCell.id,
                for: indexPath
            ) as? IndustryPickerCollectionViewCell else { return UICollectionViewCell() }
            cell.setTitle(industry.name)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: IndustryPickerHeaderView.id,
                for: indexPath
            ) as? IndustryPickerHeaderView else {
                return nil
            }
            
            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            switch section {
            case .category(let category):
                header.setTitle(category.name)
            }
            
            return header
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Industry>()
        
        for category in IndustryPickerData.categories {
            let section = Section.category(category)
            snapshot.appendSections([section])
            snapshot.appendItems(category.industries, toSection: section)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension IndustryPickerViewController: UICollectionViewDelegateFlowLayout {


}
