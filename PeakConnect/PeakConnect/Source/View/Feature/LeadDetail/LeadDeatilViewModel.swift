//
//  LeadDeatilViewModel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/29/25.
//

import UIKit
import RxSwift
import RxCocoa

enum CopyType {
    case location
    case site
    
    var text: String {
        switch self {
        case .location: "위치 주소가 복사되었습니다."
        case .site: "사이트 주소가 복사되었습니다."
        }
    }
}

class LeadDeatilViewModel {
    
    private var lead: LeadInfo?
    
    private let leadInfoRelay = PublishRelay<LeadInfo>()
    private let titleRelay = PublishRelay<String>()
    private let copyTextRelay = PublishRelay<String>()
    private let disposeBag = DisposeBag()
    
    init(id: Int) {
        fetchData(id: id)
    }
}

extension LeadDeatilViewModel {
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let locationCopybuttonTapped: Observable<Void>
        let siteCopybuttonTapped: Observable<Void>

    }
    
    struct Output {
        let leadInfo: Driver<LeadInfo>
        let title: Driver<String>
        let copyText: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        input.locationCopybuttonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.copyText(.location)
            })
            .disposed(by: disposeBag)
        
        input.siteCopybuttonTapped
            .subscribe(with: self, onNext: { owner, _ in
                owner.copyText(.site)
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
    
    private func copyText(_ type: CopyType) {
        guard let lead = lead else { return }
        var copyValue = ""
        switch type {
        case .location:
            copyValue = lead.address
        case .site: copyValue = lead.website
        }
        
        UIPasteboard.general.string = copyValue
        copyTextRelay.accept(type.text)
    }
}
