//
//  HistoryResultView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import SnapKit
import Then

class HistoryResultView: UIView {
    
    private let topView = UIView().then {
        $0.backgroundColor = .primary
        $0.layer.cornerRadius = 24
    }
    
    private let countLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private let addressLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(HistoryResultCollectionViewCell.self, forCellWithReuseIdentifier: HistoryResultCollectionViewCell.id)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HistoryResultView {
    
    private func setupUI() {
        [
            topView,
            collectionView
        ].forEach {
            addSubview($0)
        }
        
        [
            countLabel,
            addressLabel
        ].forEach {
            topView.addSubview($0)
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(87)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
}

extension HistoryResultView {
    
    func configure(_ result: HistoryListInfo) {
        addressLabel.text = result.address
        countLabel.text = "총 \(result.leads.count)개의 리드 추천을 받았어요!"
    }
}
