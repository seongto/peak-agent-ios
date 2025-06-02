//
//  HistoryResultViewController.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryResultViewController: UIViewController {
    
    private let historyResultView = HistoryResultView()
    private let loadingView = LoadingView()
    private let historyResultViewModel: HistoryResultViewModel
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: HistoryResultViewModel) {
        historyResultViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = historyResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBar()
        setupLoadingView()
        bind()
    }
    
    private func setupBar() {
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        let titleLabel = UILabel()
        titleLabel.text = "리드 추천 결과"
        titleLabel.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        navigationItem.titleView = titleLabel
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { $0.edges.equalToSuperview() }
        loadingView.isHidden = false
    }
}

extension HistoryResultViewController {
    
    private func bind() {
        let viewWillAppear = rx.methodInvoked(#selector(viewWillAppear)).map { _ in }
        let itemSelected =  historyResultView.collectionView.rx.itemSelected.asObservable()
        let input = HistoryResultViewModel.Input(
            viewWillAppear: viewWillAppear,
            itemSelected: itemSelected
        )
        let output = historyResultViewModel.transform(input: input)

        output.historyList
            .drive(with: self, onNext: { owner, result in
                owner.historyResultView.configure(result)
                owner.loadingView.isHidden = true
            })
            .disposed(by: disposeBag)
        
        output.leads
            .drive(historyResultView.collectionView.rx.items(
                cellIdentifier: HistoryResultCollectionViewCell.id,
                cellType: HistoryResultCollectionViewCell.self)) { row, element, cell in
                    cell.configure(data: element)
                }
                .disposed(by: disposeBag)
        
        output.id
            .drive(with: self, onNext: { owner, id in
                owner.connectView(id)
            })
            .disposed(by: disposeBag)
        
        historyResultView.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension HistoryResultViewController: UICollectionViewDelegateFlowLayout {
    
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
        navigationController?.pushViewController(leadDeatilViewController, animated: true)
    }
}
