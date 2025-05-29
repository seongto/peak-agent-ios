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
        resultsView.onTrashButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func bindViewModel() {
        let input = MapLeadResultsViewModel.Input(
            fetchTrigger: Observable.just(1)
        )

        let output = viewModel.transform(input: input)

        output.detail
            .drive(onNext: { [weak self] detail in
                // detail 정보를 UI에 표시
                print("리드 상세정보: \(detail)")
                // 예: self?.resultsView.updateDetail(detail)
            })
            .disposed(by: disposeBag)

        output.isLoading
            .drive(onNext: { isLoading in
                // 로딩 인디케이터 처리
            })
            .disposed(by: disposeBag)

        output.error
            .drive(onNext: { errorMessage in
                // 에러 처리
                print("Error: \(errorMessage)")
            })
            .disposed(by: disposeBag)
    }
}
