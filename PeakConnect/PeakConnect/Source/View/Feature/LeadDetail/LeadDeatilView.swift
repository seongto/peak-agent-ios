//
//  LeadDeatilView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/29/25.
//

import UIKit
import SnapKit
import Then

class LeadDeatilView: UIView {
    
    private let companyInformationView = UIView().then {
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 24
    }
    
    private let detailView = UIView().then {
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 24

    }
    
    private let recommendView = UIView().then {
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 24
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private let companyInformationLabel = UILabel().then {
        $0.text = "회사 정보"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .textPrimary
    }
    
    private let companyInformationDetailLabel = UILabel().then {
        $0.text = "사람과 AI 에이전트가 협력하여 선을 이루는 미래를 꿈꾸는 AI를 연구합니다."
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.numberOfLines = 0
    }
    
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
    
    private let separatorView2 = UIView().then {
        $0.backgroundColor = .textPrimary
    }
    
    private let locationLabel = UILabel().then {
        $0.text = "위치"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 14)
    }
    
    private let locationTextLabel = UILabel().then {
        $0.text = "서울특별시 서초구 효령료 391"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private let siteLabel = UILabel().then {
        $0.text = "사이트"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 14)
    }
    
    private let siteTextLabel = UILabel().then {
        $0.text = "https://www.koreaodm.com/"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private let yearLabel = UILabel().then {
        $0.text = "설립연도"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 14)
    }
    
    private let yearTextLabel = UILabel().then {
        $0.text = "2020년"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
    }
    
    private let recommendLabel = UILabel().then {
        $0.text = "추천 내용"
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 16)
    }
    
    private let separatorView3 = UIView().then {
        $0.backgroundColor = .textPrimary
    }
    
    private let recommendDetailLabel = UILabel().then {
        $0.text = "더선한이 추구하는 바와 매우 잘 어울려요. 짝짝짝."
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.numberOfLines = 0
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
        
        [
            companyInformationLabel,
            separatorView,
            companyInformationDetailLabel
        ].forEach {
            companyInformationView.addSubview($0)
        }
        
        [
            profileImageView,
            positionLabel,
            nameLabel,
            separatorView2,
            locationLabel,
            locationTextLabel,
            siteLabel,
            siteTextLabel,
            yearLabel,
            yearTextLabel
        ].forEach {
            detailView.addSubview($0)
        }
        
        [
            recommendLabel,
            separatorView3,
            recommendDetailLabel
        ].forEach {
            recommendView.addSubview($0)
        }
        
        companyInformationView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(122)
        }
        
        detailView.snp.makeConstraints { make in
            make.top.equalTo(companyInformationView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(184)
        }
        
        recommendView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(102)
        }
        
        companyInformationLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(companyInformationLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        companyInformationDetailLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(separatorView.snp.bottom).offset(10)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
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
        
        separatorView2.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(separatorView2.snp.bottom).offset(10)
            make.width.equalTo(80)
        }
        
        locationTextLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView2.snp.bottom).offset(10)
            make.leading.equalTo(locationLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(20)
        }
        
        siteLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.width.equalTo(80)
        }
        
        siteTextLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalTo(siteLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(20)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(siteLabel.snp.bottom).offset(10)
            make.width.equalTo(80)
        }
        
        yearTextLabel.snp.makeConstraints { make in
            make.top.equalTo(siteLabel.snp.bottom).offset(10)
            make.leading.equalTo(yearLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(20)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
        }
        
        separatorView3.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        recommendDetailLabel.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(separatorView3.snp.bottom).offset(10)
        }
    }
}
