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
    private let searchViewModel: SearchViewModel
    
    private let disposeBag = DisposeBag()
    
    init(searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        output.result
            .drive(with: self, onNext: { owner, location in
                let mapVC = MapViewController()
                mapVC.initialLocation = location  // 🌟 초기 위치 전달!
                owner.navigationController?.pushViewController(mapVC, animated: true)
            })
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
 
extension SearchViewController {
    
    private func gobackView() {
        navigationController?.popViewController(animated: true)
    }
}
