//
//  IndustryPickerHeaderView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/23/25.
//

import UIKit
import SnapKit
import Then

final class IndustryPickerHeaderView: UICollectionReusableView {
    
    static let id = "IndustryPickerHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .headline)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 레이아웃 설정

extension IndustryPickerHeaderView {
    
    private func setupUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - 데이터 설정

extension IndustryPickerHeaderView {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
