//
//  CustomSearchBarView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/30/25.
//

import UIKit
import SnapKit
import Then

final class CustomSearchBarView: UIView {

    let textField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "검색어를 입력하세요.",
            attributes: [
                .foregroundColor: UIColor.disabled,
                .font: UIFont(name: "Pretendard-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
            ]
        )
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 8
        $0.layer.masksToBounds = true
        $0.returnKeyType = .search
        $0.clearButtonMode = .never  // 기본 클리어 버튼 숨김
        $0.leftViewMode = .always
        
        let iconView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconView.tintColor = .white
        iconView.contentMode = .scaleAspectFit
        iconView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let containerView = UIView()
        containerView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        containerView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        $0.leftView = containerView
    }

    private let clearButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .white
        $0.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomSearchBarView {
    
    private func setupUI() {
        addSubview(textField)
        addSubview(clearButton)

        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clearButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.trailing.equalTo(textField.snp.trailing).inset(15)
            make.width.height.equalTo(20)
        }
    }

    private func setupActions() {
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }
}

extension CustomSearchBarView {
    
    @objc private func textDidChange() {
        clearButton.isHidden = textField.text?.isEmpty ?? true
    }

    @objc private func clearText() {
        textField.text = ""
        clearButton.isHidden = true
    }
}
