//
//  CreateCompanyViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/22/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

struct SectionOfIndustries {
    var header: String
    var items: [Industry]
}

extension SectionOfIndustries: SectionModelType {
    typealias Item = Industry
    
    init(original: SectionOfIndustries, items: [Industry]) {
        self = original
        self.items = items
    }
}

final class CreateCompanyViewController: UIViewController {
    
    private let createCompanyView = CreateCompanyView()
    private var createCompanyViewModel: CreateCompanyViewModel
    private let industrySelectedRelay = PublishRelay<Industry>()
    private let disposeBag = DisposeBag()
    
    private var dataSource: RxCollectionViewSectionedReloadDataSource<SectionOfIndustries>!
    private var selectedIndexPaths = Set<IndexPath>()
    
    init(viewModel: CreateCompanyViewModel) {
        self.createCompanyViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = createCompanyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(100),
                heightDimension: .absolute(40)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(40)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(10)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            section.interGroupSpacing = 10

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(40)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]

            return section
        }
        
        createCompanyView.industryCollectionView.collectionViewLayout = layout
        createCompanyView.industryCollectionView.delegate = self

        dataSource = RxCollectionViewSectionedReloadDataSource<SectionOfIndustries>(
            configureCell: { dataSource, collectionView, indexPath, industry in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: IndustryPickerCollectionViewCell.id,
                    for: indexPath
                ) as? IndustryPickerCollectionViewCell else { return UICollectionViewCell() }
                let isSelected = self.selectedIndexPaths.contains(indexPath)
                cell.setTitle(industry.name)
                cell.setColor(isSelected)
                cell.layer.cornerRadius = 10
                cell.contentView.isUserInteractionEnabled = false
                return cell
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: IndustryPickerHeaderView.id,
                    for: indexPath
                ) as? IndustryPickerHeaderView else {
                    return UICollectionReusableView()
                }
                let section = dataSource.sectionModels[indexPath.section]
                header.setTitle(section.header)
                return header
            }
        )
    }
}

// MARK: - bind

extension CreateCompanyViewController {
    
    private func bind() {
        let sections = IndustryPickerData.categories.map { category in
            SectionOfIndustries(header: category.name, items: category.industries)
        }
        Observable.just(sections)
            .bind(to: createCompanyView.industryCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        createCompanyView.industryCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                if self.selectedIndexPaths.contains(indexPath) {
                    self.selectedIndexPaths.remove(indexPath)
                } else {
                    self.selectedIndexPaths.insert(indexPath)
                }
                self.createCompanyView.industryCollectionView.reloadItems(at: [indexPath])
            })
            .disposed(by: disposeBag)
        
        let name = createCompanyView.companyNameTextField.rx.text.orEmpty.skip(1).asObservable()
        let description = createCompanyView.companyDescriptionTextView.rx.text.orEmpty.skip(1).asObservable()
        
        let registerbuttonTapped = createCompanyView.createButton.rx.tap.asObservable()
        
        let input = CreateCompanyViewModel.Input(
            companyNameTextFieldInput: name,
            companyDescriptionTextFieldInput: description,
            industryButtonTapped: createCompanyView.industryCollectionView.rx.modelSelected(Industry.self).asObservable(), registerButtonTapped: registerbuttonTapped
        )
        
        let output = createCompanyViewModel.transform(input: input)
        
        output.companyDescriptionCount
            .drive(with: self, onNext: { owner, text in
                owner.createCompanyView.companyDescriptionCountLabel.text = text
            })
            .disposed(by: disposeBag)
        
        output.complete
            .drive(with: self, onNext: { owner, _  in
                owner.gobackMain()
            })
            .disposed(by: disposeBag)
        
        output.company
            .drive(with: self, onNext: { owner, company in
                guard let company = company else { return }
                owner.createCompanyView.companyNameTextField.text = company.name
                owner.createCompanyView.companyDescriptionTextView.text = company.description
            })
            .disposed(by: disposeBag)
    }
    
    private func gobackMain() {
        navigationController?.popViewController(animated: true)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension CreateCompanyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
} 
