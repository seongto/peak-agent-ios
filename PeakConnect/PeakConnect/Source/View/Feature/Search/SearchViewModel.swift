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
    
    private let searchRelay = PublishRelay<[GeocodeResponse.Address]>()
    private let disposeBag = DisposeBag()
}

extension SearchViewModel {
    
    struct Input {
        let searchText: Observable<String?>
        let itemSelected: Observable<IndexPath>
    }
    
    struct Output {
        let search: Driver<[GeocodeResponse.Address]>
    }
    
    func transform(input: Input) -> Output {
        input.searchText
            .subscribe(with: self, onNext: { owner, text in
                print(text)
                owner.searchData(text ?? "")
            })
            .disposed(by: disposeBag)
        
        input.itemSelected
            .subscribe(with: self, onNext: { owner, indexPath in
                owner.selectedItem(indexPath: indexPath)
            })
            .disposed(by: disposeBag)
        
        return Output(
            search: searchRelay.asDriver(onErrorDriveWith: .empty())
        )
    }
}

extension SearchViewModel {
    
    private func searchData(_ text: String) {
        NetworkManager.shared.requestSearch(value: text) { result in
            switch result {
            case .success(let input):
                //self.leadInfoRelay.accept(input)
                //self.titleRelay.accept(input.name)
                //self.lead = input
                self.searchRelay.accept(input.addresses)
                print("지도 검색 성공:", input)
            case .failure(let error):
                print("지도 검색 실패:", error.localizedDescription)
            }
        }
    }
    
    private func selectedItem(indexPath: IndexPath) {
    }
    
    
}
