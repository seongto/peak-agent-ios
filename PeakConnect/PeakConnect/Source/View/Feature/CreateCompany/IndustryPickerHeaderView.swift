//
//  IndustryPickerHeaderView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/23/25.
//

import UIKit
import SnapKit
import Then

class IndustryPickerHeaderView: UICollectionReusableView {
    
    static let id = "IndustryPickerHeaderView"
    
    let titleLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .headline)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
