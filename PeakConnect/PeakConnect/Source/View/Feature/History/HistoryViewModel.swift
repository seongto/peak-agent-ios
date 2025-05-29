//
//  HistoryViewModel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import Foundation
import RxSwift
import RxCocoa

struct History {
    let id: Int
    let createdAt: String
    let location: String
    let leads: String
    let count: Int
}

class HistoryViewModel {
    
    private var historyRelay = BehaviorRelay<[History?]>(value: [])
    private var idRealy = PublishRelay<Int>()
    private let disposeBag = DisposeBag()
}

extension HistoryViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let itemSelected: Observable<IndexPath>
    }
    
    struct Output {
        let history: Driver<[History?]>
        let id: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                owner.fetchData()
            })
            .disposed(by: disposeBag)
        
        input.itemSelected
            .subscribe(with: self, onNext: { owner, indexPath in
                owner.selectedItem(indexPath: indexPath)
            })
            .disposed(by: disposeBag)
        
        return Output(
            history: historyRelay.asDriver(onErrorDriveWith: .empty()),
            id: idRealy.asDriver(onErrorDriveWith: .empty())
        )
    }
}

extension HistoryViewModel {
    
    private func fetchData() {
        NetworkManager.shared.requestHistList() { result in
            switch result {
            case .success(let input):
                var historys = [History]()
                input.forEach {
                    let history = History(
                        id: $0.id,
                        createdAt: $0.created_at,
                        location: $0.location,
                        leads: $0.leads,
                        count: $0.count
                    )
                    
                    historys.append(history)
                }

                self.historyRelay.accept(historys)
                print("회사 조회 성공:", historys)
            case .failure(let error):
                print("회사 조회 실패:", error.localizedDescription)
            }
        }
    }
    
    private func selectedItem(indexPath: IndexPath) {
        let history = historyRelay.value
        guard let item = history[indexPath.item] else { return }
        idRealy.accept(item.id)
    }
}
