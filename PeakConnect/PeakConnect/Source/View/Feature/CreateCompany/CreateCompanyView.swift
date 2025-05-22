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
        
    // 회사 정보 스택뷰
    private let informationStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 10
        $0.distribution = .fillProportionally
    }
    
    // 회사명 스택뷰
    private let companyNameStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fillProportionally
        $0.alignment = .center
    }
    
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
    
    // 회사 소개 스택뷰
    private let companyDescriptionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fillProportionally
    }
    
    private let companyDescriptionHeaderView = UIView()
    
    private let companyDescriptionLabel = UILabel().then {
        $0.text = "회사 소개"
        $0.textAlignment = .left
    }
    
    private let companyDescriptionCountLabel = UILabel().then {
        $0.text = "0/100"
        $0.textAlignment = .right
        $0.textColor = .gray
    }
    
    private let companyDescriptionTextField = UITextField().then {
        $0.placeholder = " 회사에서 제공하는 서비스에 대해 입력해주세요."
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    // 산업군 스택뷰
    private let industryStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fill
        $0.alignment = .leading
    }
    
    private let industryHeaderView = UIView()
    
    private let industryLabel = UILabel().then {
        $0.text = "산업군"
        $0.textAlignment = .left
    }
    
    private let industryButton = UIButton(type: .system).then {
        $0.setTitle("산업군 선택", for: .normal)
    }
    
    private let industryTagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .equalSpacing
        $0.alignment = .top
    }
    
    private let industryTagLabel = UILabel().then {
        $0.text = "산업군 태그"
        $0.backgroundColor = .systemGray4
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
    }

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
        
        [
            logoLabel,
            descriptionLabel,
            informationStackView,
            createButton
        ].forEach {
            addSubview($0)
        }
        
        [
            companyNameStackView,
            companyDescriptionStackView,
            industryStackView,
        ].forEach {
            informationStackView.addArrangedSubview($0)
        }
        
        [
            companyNameLabel,
            companyNameTextField
        ].forEach {
            companyNameStackView.addArrangedSubview($0)
        }
        
        [
            companyDescriptionHeaderView,
            companyDescriptionTextField
        ].forEach {
            companyDescriptionStackView.addArrangedSubview($0)
        }
        
        [
            companyDescriptionLabel,
            companyDescriptionCountLabel
        ].forEach {
            companyDescriptionHeaderView.addSubview($0)
        }
        
        [
            industryHeaderView,
            industryTagStackView
        ].forEach {
            industryStackView.addArrangedSubview($0)
        }
        
        [
            industryLabel,
            industryButton
        ].forEach {
            industryHeaderView.addSubview($0)
        }
        
        industryTagStackView.addArrangedSubview(industryTagLabel)
        
        logoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        informationStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(createButton.snp.top).offset(-20)
        }
        
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        companyNameStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        
        companyDescriptionStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(120)
        }
        
        industryStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        
        companyNameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(20)
        }
        
        companyNameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        companyDescriptionHeaderView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(20)
        }
        
        companyDescriptionTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        
        companyDescriptionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.height.equalTo(20)
        }
        
        companyDescriptionCountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        industryHeaderView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(20)
        }
        
        industryStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }

        industryLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.height.equalTo(20)
        }
        
        industryButton.snp.makeConstraints { make in
            make.left.equalTo(industryLabel.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        industryTagLabel.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
}
