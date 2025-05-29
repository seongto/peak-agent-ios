//
//  LeadDeatilView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/29/25.
//

import UIKit
import SnapKit
import Then

class DetailsView: UIView {
    
    private let label = UILabel().then {
        $0.text = "위치"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 14)
    }
    
    private let text = UILabel().then {
        $0.text = "테스트입니다."
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        [
            label,
            text
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
            make.trailing.equalToSuperview()
        }
    }
}

class LeadComponentsView: UIView {
    
    var topView = UIView()
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .textPrimary
    }
    
    var bottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        [
            topView,
            separatorView,
            bottomView
        ].forEach {
            addSubview($0)
        }
        
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(separatorView.snp.bottom).offset(10)
        }
    }
}

class LeadDeatilView: UIView {
    
    private let companyInformationView = LeadComponentsView().then {
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 24
    }
    
    private let detailView = LeadComponentsView().then {
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 24

    }
    
    private let recommendView = LeadComponentsView().then {
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 24
    }
    
    private let companyInformationLabel = UILabel().then {
        $0.text = "회사 정보"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
    }
    
    private let companyInformationDetailLabel = UILabel().then {
        $0.text = "사람과 AI 에이전트가 협력하여 선을 이루는 미래를 꿈꾸는 AI를 연구합니다.사람과 AI 에이전트가 협력하여 선을 이루는 미래를 꿈꾸는 AI를 연구합니다."
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .justified
        $0.numberOfLines = 0
    }
    
    private let detailTopView = UIView()
    
    private let profileImageView = UIImageView().then {
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    private let positionLabel = UILabel().then {
        $0.text = "CEO"
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
        $0.textColor = .grayssss
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "권태욱"
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
    }
    
    private let detailStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private let locationView = DetailsView()
    
    private let siteView = DetailsView()
    
    private let yearView = DetailsView()
    
    private let recommendLabel = UILabel().then {
        $0.text = "추천 내용"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
    }

    private let recommendDetailLabel = UILabel().then {
        $0.text = "더선한이 추구하는 바와 매우 잘 어울려요. 짝짝짝. 더선한이 추구하는 바와 매우 잘 어울려요. 짝짝짝."
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textAlignment = .justified
        $0.numberOfLines = 0
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LeadDeatilView {
    
    private func setupUI() {
        [
            companyInformationView,
            detailView,
            recommendView
        ].forEach {
            addSubview($0)
        }
        
        companyInformationView.topView.addSubview(companyInformationLabel)
        companyInformationView.bottomView
            .addSubview(companyInformationDetailLabel)
        
        detailView.topView.addSubview(detailTopView)
        detailView.bottomView.addSubview(detailStackView)
        
        [
            profileImageView,
            positionLabel,
            nameLabel
        ].forEach {
            detailTopView.addSubview($0)
        }
        
        recommendView.topView.addSubview(recommendLabel)
        recommendView.bottomView.addSubview(recommendDetailLabel)
        
        [
            locationView,
            siteView,
            yearView
        ].forEach {
            detailStackView.addArrangedSubview($0)
        }
        
        companyInformationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(companyInformationDetailLabel.snp.bottom).offset(20)
        }
        
        companyInformationLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        companyInformationDetailLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(companyInformationView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(184)
        }
        
        recommendView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(recommendDetailLabel.snp.bottom).offset(20)
        }
        
        detailTopView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.size.equalTo(44)
        }
        
        positionLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        detailStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        locationView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        siteView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        yearView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        recommendDetailLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
