//
//  CreateCompanyView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/22/25.
//

import UIKit
import Then
import SnapKit

final class CreateCompanyView: UIView {
    
    // MARK: - UI Components
    
    // 로고 라벨
    private let logoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "TopLogo")
    }
    
    // 회사 설명 라벨
    private let descriptionLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.textAlignment = .left

        let fullText = """
회사 정보를 등록하고
리드 추천을 받아보세요
"""
        let attributedText = NSMutableAttributedString(string: fullText)

        let firstLineFont = UIFont(name: "Pretendard-Regular", size: 20) ?? .systemFont(ofSize: 20)
        let secondLineFont = UIFont(name: "Pretendard-Bold", size: 20) ?? .boldSystemFont(ofSize: 20)

        let lines = fullText.components(separatedBy: "\n")

        if let firstRange = fullText.range(of: lines[0]) {
            attributedText.addAttribute(.font, value: firstLineFont, range: NSRange(firstRange, in: fullText))
        }
        if lines.count > 1, let secondRange = fullText.range(of: lines[1]) {
            attributedText.addAttribute(.font, value: secondLineFont, range: NSRange(secondRange, in: fullText))
        }

        $0.attributedText = attributedText
        $0.textColor = .white
    }
    
    private let companyNameLabel = UILabel().then {
        $0.text = "회사명"
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    let companyNameTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(
            string: "회사명을 입력해주세요",
            attributes: [
                .foregroundColor: UIColor.disabled,
                .font: UIFont(name: "Pretendard-Regular", size: 14) ?? .systemFont(ofSize: 14)
            ]
        )
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 4
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 50))
        $0.leftViewMode = .always
    }
        
    private let companyDescriptionLabel = UILabel().then {
        $0.text = "회사 소개"
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    let companyDescriptionTextView = UITextView().then {
        $0.backgroundColor = .text
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .white
        $0.layer.cornerRadius = 4
        $0.textContainerInset = UIEdgeInsets(top: 14, left: 12, bottom: 14, right: 12)
    }
    
    let companyDescriptionCountLabel = UILabel().then {
        $0.text = "1/100"
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.textColor = .grayssss
        $0.textAlignment = .right
    }
    
    // 등록하기 버튼
    let createButton = UIButton(type: .system).then {
        $0.backgroundColor = .primary
        $0.tintColor = .white
        $0.layer.cornerRadius = 25
        $0.setTitle("등록하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
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

extension CreateCompanyView {
    
    private func setupUI() {
        backgroundColor = .background
        
        [
            logoImageView,
            descriptionLabel,
            companyNameLabel,
            companyNameTextField,
            companyDescriptionLabel,
            companyDescriptionTextView,
            companyDescriptionCountLabel,
            createButton
        ].forEach {
            addSubview($0)
        }

        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(25)
            make.width.equalTo(190)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
        }
        
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        companyNameTextField.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        companyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        companyDescriptionCountLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        companyDescriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(companyDescriptionLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(145)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(companyDescriptionTextView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}

extension CreateCompanyView {
    
    func setupEditMode(_ company: Company) {
        logoImageView.isHidden = true
        descriptionLabel.isHidden = true
        createButton.setTitle("수정하기", for: .normal)
        
        companyNameTextField.text = company.name
        companyDescriptionTextView.text = company.description
        
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
        }
    }
}
