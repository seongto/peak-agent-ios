//
//  HistoryViewCollectionViewCell.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import SnapKit
import Then

class HistoryViewCollectionViewCell: UICollectionViewCell {
    
    static let id = "HistoryViewCollectionViewCell"
    
    private let dateLabel = BaseLabel().then {
        $0.text = "추천 날짜 : 2025.05.03"
        $0.textColor = .white
        $0.backgroundColor = .textPrimary
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.layer.cornerRadius = 11
        $0.clipsToBounds = true
    }
    
    private let pinImageView = UIImageView().then {
        $0.image = UIImage(systemName: "mappin")
        $0.tintColor = .primary
        $0.contentMode = .scaleAspectFit
    }
    
    private let addresLabel = UILabel().then {
        $0.text = "서울시 강남구 역삼동 148"
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.textAlignment = .left
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .textPrimary
    }
    
    private let listLabel = UILabel().then {
        $0.text = "리드 목록"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 14)
    }
    
    private let listTextLabel = UILabel().then {
        $0.text = "더선한, 힐링페이퍼, 마이크로소프트..."
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private let countLabel = UILabel().then {
        $0.text = "리드 개수"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 14)
    }
    
    private let countTextLabel = UILabel().then {
        $0.text = "총 10개 업체"
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

extension HistoryViewCollectionViewCell {
    
    private func setupUI() {
        backgroundColor = .text
        layer.cornerRadius = 24
        
        [
            dateLabel,
            pinImageView,
            addresLabel,
            separatorView,
            listLabel,
            listTextLabel,
            countLabel,
            countTextLabel
        ].forEach {
            addSubview($0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        pinImageView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(20)
        }
        
        addresLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalTo(pinImageView.snp.trailing).offset(2.5)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(addresLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
        listTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(listLabel.snp.trailing).offset(10)
            make.top.equalTo(separatorView.snp.bottom).offset(10)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(listLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        
        countTextLabel.snp.makeConstraints { make in
            make.leading.equalTo(countLabel.snp.trailing).offset(10)
            make.top.equalTo(listLabel.snp.bottom).offset(10)
        }
    }
}
