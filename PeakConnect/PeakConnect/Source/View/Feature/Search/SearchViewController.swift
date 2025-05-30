//
//  SearchViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/30/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let searchViewModel = SearchViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        let titleLabel = UILabel()
        titleLabel.text = "위치 검색"
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        titleLabel.textColor = .label
        navigationItem.titleView = titleLabel
    }

}

extension SearchViewController {
    
    private func bind() {
        let searchText = searchView.searchBar.textField.rx.text.asObservable()
        let itemSelected =  searchView.collectionView.rx.itemSelected.asObservable()
        let input = SearchViewModel.Input(
            searchText: searchText,
            itemSelected: itemSelected
        )
        let output = searchViewModel.transform(input: input)
        
        output.search
            .drive(searchView.collectionView.rx.items(
                cellIdentifier: SearchCollectionViewCell.id,
                cellType: SearchCollectionViewCell.self)) { row, element, cell in
                    cell.configure(data: element)
                }
                .disposed(by: disposeBag)
        
        searchView.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 87)
    }
}
 
extension HistoryResultViewController {
    
    private func connectView(_ id: Int) {
        let leadDeatilViewModel = LeadDeatilViewModel(id: id)
        let leadDeatilViewController = LeadDeatilViewController(leadDeatilViewModel: leadDeatilViewModel)
        navigationController?.pushViewController(leadDeatilViewController, animated: false)
    }
}
