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

}

extension SearchViewController {
    
    private func bind() {
        let itemSelected =  searchView.collectionView.rx.itemSelected.asObservable()
        let input = SearchViewModel.Input(
            itemSelected: itemSelected
        )
        let output = searchViewModel.transform(input: input)
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
