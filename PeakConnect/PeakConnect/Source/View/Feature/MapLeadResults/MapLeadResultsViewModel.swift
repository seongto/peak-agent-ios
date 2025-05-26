//
//  MapLeadResultsViewModel.swift
//  PeakConnect
//
//  Created by 강민성 on 5/26/25.
//

import Foundation

class MapLeadResultsViewModel {
    
    // 회사 데이터 배열
    var companyData: [(name: String, info: String)] = []
    
    // 더미 데이터 로드 메소드
    func loadDummyData() {
        companyData = [
            ("스타트업1", "서울 강남구 테헤란로\n소프트웨어 개발"),
            ("스타트업2", "경기도 성남시 판교\nAI 기술 개발"),
            ("스타트업3", "서울 마포구\n플랫폼 서비스")
        ]
    }
}
