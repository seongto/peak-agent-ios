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
    
    // 탑 로고 이미지뷰
    private let topLogoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "TopLogo")
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "리드 추천 히스토리"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 20)
    }
    
    let colletionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.register(HistoryViewCollectionViewCell.self, forCellWithReuseIdentifier: HistoryViewCollectionViewCell.id)
    }
    
    let noHistoryLabel = UILabel().then {
        $0.text = "리드 추천 히스토리가 없습니다."
        $0.numberOfLines = 2
        $0.font = UIFont(name: "Pretendard-Regular", size: 20)
        $0.textColor = .disabled
        $0.isHidden = true
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
            topLogoImageView,
            titleLabel,
            colletionView,
            noHistoryLabel
        ].forEach {
            addSubview($0)
        }
        
        topLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(25)
            make.width.equalTo(190)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topLogoImageView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        colletionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
        noHistoryLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

    }
}
