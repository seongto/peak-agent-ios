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
    
    private let disposeBag = DisposeBag()
    
    init(id: Int) {
        self.id = id
    }
}

extension LeadDeatilViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
