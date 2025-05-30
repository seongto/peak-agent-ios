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
            fetchTrigger: Observable.just(())
        )

        let output = viewModel.transform(input: input)

        output.leadIds
            .drive(onNext: { [weak self] leadIds in
                // 받아온 리드 ID들을 출력하거나 UI 갱신
                print("추천된 리드 ID 목록: \(leadIds)")
                // TODO: 여기에 resultsView 업데이트 로직 추가 (예: updateLeadIds)
                // self?.resultsView.updateLeadIds(leadIds)
            })
            .disposed(by: disposeBag)

        output.isLoading
            .drive(onNext: { isLoading in
                // 필요 시 로딩 인디케이터 처리
                print("로딩 중: \(isLoading)")
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
