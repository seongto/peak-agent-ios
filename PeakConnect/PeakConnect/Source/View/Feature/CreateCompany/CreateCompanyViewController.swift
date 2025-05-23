//
//  CreateCompanyViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/22/25.
//

import UIKit

class CreateCompanyViewController: UIViewController {
    
    enum Section: Hashable {
        case category(IndustryCategory)
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Industry>!
    private let createCompanyView = CreateCompanyView()
    
    override func loadView() {
        view = createCompanyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createCompanyView.industryCollectionView.delegate = self // 꼭 추가
        setupDataSource()
        applySnapshot()
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Industry>(collectionView: createCompanyView.industryCollectionView) {
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

extension CreateCompanyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
}
