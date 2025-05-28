//
//  MapLeadResultsViewModel.swift
//  PeakConnect
//
//  Created by 강민성 on 5/26/25.
//

import Foundation

class MapLeadResultsViewModel {
    
    // 회사 데이터 배열: (이름, 주소, 태그, CEO, 설립연도)
    var companyData: [(name: String, address: String, tags: String, ceo: String, established: String)] = []
    
    // 더미 데이터 로드 메소드
    func loadDummyData() {
        companyData = [
            ("더선한 주식회사", "서울특별시 서초구 효령로 391", "소프트웨어 개발", "김철수", "2018"),
            ("더선한 주식회사", "서울특별시 서초구 효령로 391", "AI 기술 개발", "이영희", "2020"),
            ("더선한 주식회사", "서울특별시 서초구 효령로 391", "플랫폼 서비스", "박민수", "2015")
        ]
    }
}
