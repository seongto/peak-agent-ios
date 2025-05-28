//
//  HistoryView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import SnapKit
import Then

class HistoryView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.text = "리드 추천 히스토리"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 18)
    }
    
    let colletionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(HistoryViewCollectionViewCell.self, forCellWithReuseIdentifier: HistoryViewCollectionViewCell.id)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryView {
    
    private func setupUI() {
        [
            titleLabel,
            colletionView
        ].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.centerX.equalToSuperview()
        }
        
        colletionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
        }

    }
}
