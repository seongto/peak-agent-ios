//
//  DetatilView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/29/25.
//

import UIKit
import SnapKit
import Then

class DetailView: UIView {
    
    enum Title {
        case location
        case site
        case year
        
        var text: String {
            switch self {
            case .location: "위치"
            case .site: "사이트"
            case .year: "설립연도"
            }
        }
    }
    
    private let label = UILabel().then {
        $0.text = "위치"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 14)
    }
    
    private let text = UILabel().then {
        $0.text = "테스트입니다."
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private let copyButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "document.on.document.fill"), for: .normal)
        $0.tintColor = .white
    }
    
    init(_ title: Title) {
        super.init(frame: .zero)
        setupUI(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(_ title: Title) {
        label.text = title.text
        if title == .year {
            copyButton.isHidden = true
        }
        
        [
            label,
            text,
            copyButton
        ].forEach {
            addSubview($0)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
        
        text.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(label.snp.trailing)
        }
        
        copyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(text.snp.trailing).offset(5)
            make.size.equalTo(12)
        }
    }
}

extension DetailView {
    
    private func configure(text: String) {
        self.text.text = text
    }
}
