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
    let titleLabel = UILabel()
    let companyNameLabel = UILabel()
    let industryTagsStack = UIStackView()
    let editCompanyButton = UIButton(type: .system)
    let locationSearchButton = UIButton(type: .system)
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

        titleLabel.text = "Peak Connect"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        companyNameLabel.text = "<회사명>"
        companyNameLabel.font = UIFont.systemFont(ofSize: 20)

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

        editCompanyButton.setTitle("회사 정보 수정", for: .normal)
        editCompanyButton.setTitleColor(.systemBlue, for: .normal)

        locationSearchButton.setTitle("현위치에서 리드찾기", for: .normal)
        locationSearchButton.backgroundColor = .systemBlue
        locationSearchButton.setTitleColor(.black, for: .normal)
        locationSearchButton.layer.cornerRadius = 15
        locationSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        mapSearchButton.setTitle("지도에서 리드찾기", for: .normal)
        mapSearchButton.backgroundColor = .systemOrange
        mapSearchButton.setTitleColor(.black, for: .normal)
        mapSearchButton.layer.cornerRadius = 15
        mapSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)

        [titleLabel, companyNameLabel, industryTagsStack, editCompanyButton, locationSearchButton, mapSearchButton].forEach {
            addSubview($0)
        }
    }

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
