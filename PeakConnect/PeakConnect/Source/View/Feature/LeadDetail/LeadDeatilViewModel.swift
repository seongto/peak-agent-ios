//
//  LeadDeatilViewModel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/29/25.
//

import Foundation
import RxSwift
import RxCocoa

class LeadDeatilViewModel {
    
    private let id: Int
    
    private let leadInfoRelay = PublishRelay<LeadInfo>()
    private let disposeBag = DisposeBag()
    
    init(id: Int) {
        self.id = id
    }
}

extension LeadDeatilViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>

    }
    
    struct Output {
        let leadInfo: Driver<LeadInfo>

    }
    
    func transform(input: Input) -> Output {
        input.viewWillAppear
            .subscribe(with: self, onNext: { owner, _ in
                owner.fetchData(id: owner.id)
            })
            .disposed(by: disposeBag)
        
        return Output(
            leadInfo: leadInfoRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

extension LeadDeatilViewModel {
    
    private func fetchData(id: Int) {
        NetworkManager.shared.requestLead(id: id) { result in
            switch result {
            case .success(let input):
                self.leadInfoRelay.accept(input)
                print("리드 조회 성공:", input)
            case .failure(let error):
                print("회사 조회 실패:", error.localizedDescription)
            }
        }
    }
}
