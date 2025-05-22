//
//  MainView.swift
//  PeakConnect
//
//  Created by MaxBook on 5/12/25.
//

import UIKit
import SnapKit

class MainView: UIView {

    // MARK: - UI Components
    
    // 맵 타이틀 라벨
    let titleLabel = UILabel()
    
    // 회사명 표시 라벨
    let companyNameLabel = UILabel()
    
    // 산업군 태그들을 보여주는 스택
    let industryTagsStack = UIStackView()
    
    // 회사 정보 수정 버튼
    let editCompanyButton = UIButton(type: .system)
    
    // 현재 위치에서 리드 찾기 버튼
    let locationSearchButton = UIButton(type: .system)
    
    // 지도에서 리드 찾기 버튼
    let mapSearchButton = UIButton(type: .system)

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupViews() {
        backgroundColor = .white
        
        // 타이틀 라벨 스타일 설정
        titleLabel.text = "Peak Connect"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        // 회사명 라벨 스타일 설정
        companyNameLabel.text = "<회사명>"
        companyNameLabel.font = UIFont.systemFont(ofSize: 20)
        
        // 산업군 태그 스타일 및 속성 설정
        industryTagsStack.axis = .horizontal
        industryTagsStack.spacing = 8
        industryTagsStack.distribution = .fillEqually

        for tag in ["산업군 태그", "산업군 태그", "산업군 태그", "산업군 태그"] {
            let tagLabel = UILabel()
            tagLabel.text = tag
            tagLabel.font = UIFont.systemFont(ofSize: 14)
            tagLabel.backgroundColor = .systemGray5
            tagLabel.layer.cornerRadius = 8
            tagLabel.clipsToBounds = true
            tagLabel.textAlignment = .center
            industryTagsStack.addArrangedSubview(tagLabel)
        }
        
        // 회사 정보 수정 버튼 스타일 설정
        editCompanyButton.setTitle("회사 정보 수정", for: .normal)
        editCompanyButton.setTitleColor(.systemBlue, for: .normal)
        
        // 현위치에서 리드찾기 버튼 스타일 설정
        locationSearchButton.setTitle("현위치에서 리드찾기", for: .normal)
        locationSearchButton.backgroundColor = .systemBlue
        locationSearchButton.setTitleColor(.black, for: .normal)
        locationSearchButton.layer.cornerRadius = 15
        locationSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        // 지도에서 리드찾기 버튼 스타일 설정
        mapSearchButton.setTitle("지도에서 리드찾기", for: .normal)
        mapSearchButton.backgroundColor = .systemOrange
        mapSearchButton.setTitleColor(.black, for: .normal)
        mapSearchButton.layer.cornerRadius = 15
        mapSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        [titleLabel, companyNameLabel, industryTagsStack, editCompanyButton, locationSearchButton, mapSearchButton].forEach {
            addSubview($0)
        }
    }
    
    // 각 컴포넌트의 오토레이아웃 제약 조건 설정
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(20)
        }

        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(titleLabel)
        }

        industryTagsStack.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }

        editCompanyButton.snp.makeConstraints { make in
            make.top.equalTo(industryTagsStack.snp.bottom).offset(20)
            make.leading.equalTo(titleLabel)
        }

        locationSearchButton.snp.makeConstraints { make in
            make.top.equalTo(editCompanyButton.snp.bottom).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(self.snp.centerX).offset(-10)
            make.height.equalTo(140)
        }

        mapSearchButton.snp.makeConstraints { make in
            make.top.equalTo(locationSearchButton)
            make.leading.equalTo(self.snp.centerX).offset(10)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(140)
        }
    }
}
