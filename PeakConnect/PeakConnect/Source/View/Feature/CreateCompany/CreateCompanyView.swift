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
    private let logoLabel = UILabel().then {
        $0.text = "Peak Connect"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textAlignment = .left
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
    
    // 스크롤뷰
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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
    
    let companyDescriptionTextField = UITextView().then {
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
        
    private let industryLabel = UILabel().then {
        $0.text = "산업군 선택"
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    let industryCollectionView = IndustryPickerCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    // 등록하기 버튼
    private let createButton = UIButton(type: .system).then {
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
        
        [ scrollView ].forEach { addSubview($0) }
        
        [ contentView ].forEach { scrollView.addSubview($0) }
        
        [
            logoLabel,
            descriptionLabel,
            companyNameLabel,
            companyNameTextField,
            companyDescriptionLabel,
            companyDescriptionTextField,
            companyDescriptionCountLabel,
            industryLabel,
            industryCollectionView,
            createButton
        ].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        logoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(logoLabel.snp.bottom).offset(16)
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
        
        companyDescriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(companyDescriptionLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(145)
        }
        
        industryLabel.snp.makeConstraints { make in
            make.top.equalTo(companyDescriptionTextField.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        industryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(industryLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(800)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(industryCollectionView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}
