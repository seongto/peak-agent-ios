//
//  Untitled.swift
//  PeakConnect
//
//  Created by 강민성 on 5/29/25.
//

import UIKit
import RxSwift
import RxCocoa

class MapLeadResultsViewController: UIViewController {

    private let resultsView = MapLeadResultsView()
    private let viewModel = MapLeadResultsViewModel()
    private let disposeBag = DisposeBag()

    override func loadView() {
        view = resultsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        let input = MapLeadResultsViewModel.Input(fetchTrigger: Observable.just(()))
        let output = viewModel.transform(input: input)

        output.details
            .drive(onNext: { [weak self] detail in
                self?.resultsView.updateLeads(detail)  // 전체 데이터를 넘기고
            })
            .disposed(by: disposeBag)

        output.isLoading
            .drive()
            .disposed(by: disposeBag)

        output.error
            .drive()
            .disposed(by: disposeBag)

        resultsView.onTrashButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        resultsView.onShowAllResultsButtonTapped = { [weak self] id in
            let viewModel = HistoryResultViewModel(id: id)
            let vc = HistoryResultViewController(viewModel: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }

        resultsView.onCellTapped = { [weak self] id in
            let detailVM = LeadDeatilViewModel(id: id)
            let detailVC = LeadDeatilViewController(leadDeatilViewModel: detailVM)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
