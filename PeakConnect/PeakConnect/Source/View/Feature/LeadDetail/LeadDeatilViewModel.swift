//
//  LeadDeatilViewModel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/29/25.
//

import UIKit
import RxSwift
import RxCocoa

class LeadDeatilViewModel {
    
    private var lead: LeadInfo?
    
    private let leadInfoRelay = PublishRelay<LeadInfo>()
    private let titleRelay = PublishRelay<String>()
    private let copyTextRelay = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    init(id: Int) {
        fetchData(id: id)
    }
}

extension LeadDeatilViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let copyButtonTapped: Observable<Void>
    }
    
    struct Output {
        let leadInfo: Driver<LeadInfo>
        let title: Driver<String>
        let copyText: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        input.copyButtonTapped
            .throttle(.seconds(3), scheduler: MainScheduler.asyncInstance)
            .subscribe(with: self, onNext: { owner, _ in
                owner.copyText()
            })
            .disposed(by: disposeBag)
        
        return Output(
            leadInfo: leadInfoRelay.asDriver(onErrorDriveWith: .empty()),
            title: titleRelay.asDriver(onErrorDriveWith: .empty()),
            copyText: copyTextRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

extension LeadDeatilViewModel {
    
    private func fetchData(id: Int) {
        NetworkManager.shared.requestLead(id: id) { result in
            switch result {
            case .success(let input):
                self.leadInfoRelay.accept(input)
                self.titleRelay.accept(input.name)
                self.lead = input
                print("리드 조회 성공:", input)
            case .failure(let error):
                print("회사 조회 실패:", error.localizedDescription)
            }
        }
    }
    
    private func copyText() {
        guard let lead = lead else { return }
        var copyValue = ""
        
        UIPasteboard.general.string = copyValue
        copyTextRelay.accept(())
    }
}
