//
//  MainView.swift
//  PeakConnect
//
//  Created by MaxBook on 5/12/25.
//

import UIKit
import SnapKit
import Then

class MainView: UIView {

    // MARK: - UI Components
    
    // 맵 타이틀 라벨
    let titleLabel = UILabel().then {
        $0.text = "Peak Connect"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    // 회사명 표시 라벨
    let companyNameLabel = UILabel().then {
        $0.text = "<회사명>"
        $0.font = UIFont.systemFont(ofSize: 20)
    }
    
    // 산업군 태그들을 보여주는 스택
    let industryTagsStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually
    }
    
    // 회사 정보 수정 버튼
    let editCompanyButton = UIButton(type: .system).then {
        $0.setTitle("회사 정보 수정", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    // 지도에서 리드 찾기 버튼
    let mapSearchButton = UIButton(type: .system).then {
        $0.setTitle("지도에서 리드찾기", for: .normal)
        $0.backgroundColor = .systemOrange
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }

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
        
        [titleLabel, companyNameLabel, industryTagsStack, editCompanyButton, mapSearchButton].forEach {
            addSubview($0)
        }
        
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

        mapSearchButton.snp.makeConstraints { make in
            make.top.equalTo(editCompanyButton.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
    }
}
