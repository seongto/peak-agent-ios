//
//  SearchViewModel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/30/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {

    private let disposeBag = DisposeBag()
}

extension SearchViewModel {
    
    struct Input {
        let itemSelected: Observable<IndexPath>
    }
    
    struct Output {
    }
    
    func transform(input: Input) -> Output {
        input.itemSelected
            .subscribe(with: self, onNext: { owner, indexPath in
                owner.selectedItem(indexPath: indexPath)
            })
            .disposed(by: disposeBag)
        
        return Output(
        )
    }
}

extension SearchViewModel {
    
    private func selectedItem(indexPath: IndexPath) {
    }
}
