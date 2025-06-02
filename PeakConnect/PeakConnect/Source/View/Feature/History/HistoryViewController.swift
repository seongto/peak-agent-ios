//
//  HistoryViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UIViewController, UICollectionViewDelegate {
    
    private let historyView = HistoryView()
    private let historyViewModel = HistoryViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = historyView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension HistoryViewController {
    
    private func bind() {
        let viewWillAppear = rx.methodInvoked(#selector(viewWillAppear)).map { _ in }
        let itemSelected =  historyView.colletionView.rx.itemSelected.asObservable()
        let input = HistoryViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected
        )
        let output = historyViewModel.transform(input: input)
        
        output.history
            .do(onNext: { [weak self] history in
                guard let self = self else { return }
                let historyIsEmpty = history.isEmpty ? false : true
                self.historyView.noHistoryLabel.isHidden = historyIsEmpty
            })
            .drive(historyView.colletionView.rx.items(
                cellIdentifier: HistoryViewCollectionViewCell.id,
                cellType: HistoryViewCollectionViewCell.self)) { row, element, cell in
                    cell.configure(history: element!)
                }
                .disposed(by: disposeBag)
        
        output.id
            .drive(with: self, onNext: { owner, id in
                owner.connectView(id)
            })
            .disposed(by: disposeBag)
        
        historyView.colletionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
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

extension HistoryViewController {
    
    private func connectView(_ id: Int) {
        let historyResultViewModel = HistoryResultViewModel(id: id)
        let historyResultViewController = HistoryResultViewController(viewModel: historyResultViewModel)
        navigationController?.pushViewController(historyResultViewController, animated: false)
    }
}
