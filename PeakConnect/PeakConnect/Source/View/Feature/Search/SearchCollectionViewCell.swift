//
//  SearchCollectionViewCell.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/30/25.
//

import UIKit
import SnapKit
import Then

final class SearchCollectionViewCell: UICollectionViewCell {
    
    static let id = "SearchCollectionViewCell"
    
    private let searchLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    
    private let adressNameLabel = UILabel().then {
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

extension SearchCollectionViewCell {
    
    private func setupUI() {
        backgroundColor = .text
        layer.cornerRadius = 24
        
        [
            searchLabel,
            adressNameLabel
        ].forEach {
            addSubview($0)
        }
        
        searchLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        adressNameLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

extension SearchCollectionViewCell {
    
    func configure(data: NaverLocalSearchResponse.Place) {
        searchLabel.text = data.title.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
        adressNameLabel.text = data.address
    }
}
