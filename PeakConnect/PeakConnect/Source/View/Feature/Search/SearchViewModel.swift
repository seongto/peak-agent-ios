//
//  SearchViewModel.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/30/25.
//

import Foundation
import RxSwift
import RxCocoa

struct Location {
    let latitude: Double
    let longitude: Double
}

final class SearchViewModel {
    
    private let searchRelay = PublishRelay<[NaverLocalSearchResponse.Place]>()
    private var resultRelay: PublishRelay<Location>
    private let disposeBag = DisposeBag()
    private var result: [NaverLocalSearchResponse.Place]?
    
    init(_ resultRelay: PublishRelay<Location>) {
        self.resultRelay = resultRelay
    }

}

extension SearchViewModel {
    
    struct Input {
        let searchText: Observable<String?>
        let itemSelected: Observable<IndexPath>
    }
    
    struct Output {
        let search: Driver<[NaverLocalSearchResponse.Place]>
    }
    
    func transform(input: Input) -> Output {
        input.searchText
            .subscribe(with: self, onNext: { owner, text in
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
                self.searchRelay.accept(input.items)
                self.result = input.items
                print("지도 검색 성공:", input)
            case .failure(let error):
                print("지도 검색 실패:", error.localizedDescription)
            }
        }
    }
    
    private func selectedItem(indexPath: IndexPath) {
        guard let result = result else { return }
        let thisResult = result[indexPath.item]
        
        let location = Location(
            latitude: Double(Int(thisResult.mapx)!) / 10000000,
            longitude: Double(Int(thisResult.mapy)!) / 10000000
        )
        resultRelay.accept(location)
    }
}
