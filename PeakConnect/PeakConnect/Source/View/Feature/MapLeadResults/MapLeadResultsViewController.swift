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
    
    private func setupBindings() {
        resultsView.onTrashButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        resultsView.onShowAllResultsButtonTapped = { [weak self] ids in
            guard let self = self else { return }
            let sampleRecommendationId = 1  // 추천 응답의 recommendation_id
            let detailVM = LeadDeatilViewModel(id: sampleRecommendationId)
            let detailVC = LeadDeatilViewController(leadDeatilViewModel: detailVM)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        resultsView.onCellTapped = { [weak self] id in
            guard let self = self else { return }
            let detailVM = LeadDeatilViewModel(id: id)
            let detailVC = LeadDeatilViewController(leadDeatilViewModel: detailVM)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    private func bindViewModel() {
        let input = MapLeadResultsViewModel.Input(fetchTrigger: Observable.just(()))
        let output = viewModel.transform(input: input)

        output.leadIds
            .drive(onNext: { [weak self] leadIds in
                let leads = leadIds.map { id in Lead(id: id, name: "Company \(id)", address: "Address \(id)", industry: "Industry", latitude: 0.0, longitude: 0.0) }
                self?.resultsView.updateLeads(leads)

                self?.resultsView.onCellTapped = { id in
                    let detailVM = LeadDeatilViewModel(id: id)
                    let detailVC = LeadDeatilViewController(leadDeatilViewModel: detailVM)
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
            })
            .disposed(by: disposeBag)

        output.isLoading.drive().disposed(by: disposeBag)
        output.error.drive().disposed(by: disposeBag)
    }
}
