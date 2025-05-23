//
//  CreateCompanyView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/22/25.
//

import UIKit
import Then
import SnapKit

class CreateCompanyView: UIView {
    
    // MARK: - UI Components
    
    // 로고 라벨
    private let logoLabel = UILabel().then {
        $0.text = "Peak Connect"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.textAlignment = .left
    }
    
    // 회사 설명 라벨
    private let descriptionLabel = UILabel().then {
        $0.text = """
회사 정보를 등록하고,
리드 추천을 받아보세요.
"""
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: 24, weight: .medium)
        $0.numberOfLines = 2
    }
    
    // 스크롤뷰
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let companyNameLabel = UILabel().then {
        $0.text = "회사명"
        $0.textAlignment = .left
    }
    
    private let companyNameTextField = UITextField().then {
        $0.placeholder = " 회사명을 입력해주세요."
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
        
    private let companyDescriptionLabel = UILabel().then {
        $0.text = "회사 소개"
        $0.textAlignment = .left
    }
    
    private let companyDescriptionTextField = UITextField().then {
        $0.placeholder = " 회사에서 제공하는 서비스에 대해 입력해주세요."
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private let companyDescriptionCountLabel = UILabel().then {
        $0.text = "1/100"
        $0.textColor = .lightGray
        $0.textAlignment = .right
    }
        
    private let industryLabel = UILabel().then {
        $0.text = "산업군"
        $0.textAlignment = .left
    }
    
    let industryCollectionView = IndustryPickerCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    // 등록하기 버튼
    private let createButton = UIButton(type: .system).then {
        $0.backgroundColor = .blue
        $0.tintColor = .white
        $0.layer.cornerRadius = 10
        $0.setTitle("등록하기", for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 레이아웃 설정
    
    private func setupUI() {
        backgroundColor = .white
        
        
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
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(logoLabel.snp.bottom).offset(16)
        }
        
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        companyNameTextField.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        companyDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameTextField.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        companyDescriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(companyDescriptionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(80)
        }
        
        companyDescriptionCountLabel.snp.makeConstraints { make in
            make.top.equalTo(companyDescriptionTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        industryLabel.snp.makeConstraints { make in
            make.top.equalTo(companyDescriptionCountLabel.snp.bottom).offset(32)
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
            make.bottom.equalToSuperview()
        }
    }
}
