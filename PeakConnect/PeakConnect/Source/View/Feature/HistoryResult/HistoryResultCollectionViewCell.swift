//
//  HistoryResultCollectionViewCell.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import SnapKit
import Then

class HistoryResultCollectionViewCell: UICollectionViewCell {
    
    static let id = "HistoryResultCollectionViewCell"
    
    private let companyNameLabel = UILabel().then {
        $0.text = "더선한 주식회사"
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    
    private let adressNameLabel = UILabel().then {
        $0.text = "서울특별시 서초구 효령료 391"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryResultCollectionViewCell {
    
    private func setupUI() {
        backgroundColor = .text
        layer.cornerRadius = 24
        
        [
            companyNameLabel,
            adressNameLabel
        ].forEach {
            addSubview($0)
        }
        
        companyNameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        adressNameLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview().inset(20)
        }
    }
}

extension HistoryResultCollectionViewCell {
    
    func configure(data: HistoryListInfo.Lead) {
        companyNameLabel.text = data.address
        adressNameLabel.text = data.address
    }
}
