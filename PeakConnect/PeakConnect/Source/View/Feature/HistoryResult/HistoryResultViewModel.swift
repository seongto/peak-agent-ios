//
//  HistoryResultViewModel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import Foundation
import RxSwift
import RxCocoa

class HistoryResultViewModel {
    
    private var id: Int
    
    private let historyListRelay = PublishRelay<HistoryListInfo>()
    private let leadsRelay = PublishRelay<[HistoryListInfo.Lead]>()
    private var idRelay = PublishRelay<Int>()
    private let disposeBag = DisposeBag()
    private var leads: [HistoryListInfo.Lead]?
    
    init(id: Int) {
        self.id = id
    }
    
}

extension HistoryResultViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let itemSelected: Observable<IndexPath>
    }
    
    struct Output {
        let historyList: Driver<HistoryListInfo>
        let leads: Driver<[HistoryListInfo.Lead]>
        let id: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                owner.fetchData(id: owner.id)
            })
            .disposed(by: disposeBag)
        
        input.itemSelected
            .subscribe(with: self, onNext: { owner, indexPath in
                owner.selectedItem(indexPath: indexPath)
            })
            .disposed(by: disposeBag)
        
        return Output(
            historyList: historyListRelay.asDriver(onErrorDriveWith: .empty()),
            leads: leadsRelay.asDriver(onErrorDriveWith: .empty()),
            id: idRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

extension HistoryResultViewModel {
    
    private func fetchData(id: Int) {
        NetworkManager.shared.requestHistLists(id: id) { result in
            switch result {
            case .success(let input):
                self.historyListRelay.accept(input)
                self.leads = input.leads
                self.leadsRelay.accept(input.leads)
                print("회사 조회 성공:", input)
            case .failure(let error):
                print("회사 조회 실패:", error.localizedDescription)
            }
        }
    }
    
    private func selectedItem(indexPath: IndexPath) {
        guard let leads = leads else { return }
        let item = leads[indexPath.item]
        idRelay.accept(item.id)
    }
}
