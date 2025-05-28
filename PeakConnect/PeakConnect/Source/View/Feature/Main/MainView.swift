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
    
    // Top logo image view
    let topLogoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "TopLogo")
    }
    
    // Company Info Container View
    let companyInfoContainerView = UIView().then {
        $0.backgroundColor = UIColor(white: 1, alpha: 0.1)
        $0.layer.cornerRadius = 12
    }
    
    let greetingLabel = UILabel().then {
        $0.text = "안녕하세요"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.textColor = .white
    }
    
    let companyNameLabel = UILabel().then {
        $0.text = "더선한 스튜디오 님"
        $0.font = UIFont(name: "Pretendard-Bold", size: 20)
        $0.textColor = .white
    }
    
    let editCompanyButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "pencil"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .primary
        $0.layer.cornerRadius = 20
    }
    
    // Map image view
    let mapImageView = UIImageView().then {
        $0.image = UIImage(named: "MapImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
    }
    
    // 지도에서 리드 찾기 버튼
    let mapSearchButton = UIButton(type: .system).then {
        $0.setTitle("지도에서 리드찾기", for: .normal)
        $0.backgroundColor = .primary
        $0.tintColor = .white
        $0.layer.cornerRadius = 25
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
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
        backgroundColor = .black
        
        addSubview(topLogoImageView)
        addSubview(companyInfoContainerView)
        addSubview(mapImageView)
        addSubview(mapSearchButton)
        
        [greetingLabel, companyNameLabel, editCompanyButton].forEach {
            companyInfoContainerView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        topLogoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(25)
            make.width.equalTo(190)
        }
        
        companyInfoContainerView.snp.makeConstraints { make in
            make.top.equalTo(topLogoImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        greetingLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalTo(companyInfoContainerView).inset(20)
        }
        
        companyNameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(20)
        }
        
        editCompanyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.size.equalTo(40)
        }
        
        mapImageView.snp.makeConstraints { make in
            make.top.equalTo(companyInfoContainerView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(57)
            make.height.width.equalTo(260)
        }
        
        mapSearchButton.snp.makeConstraints { make in
            make.top.equalTo(mapImageView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
}


extension MainView {
    
    func setupData(company: Company) {
        companyNameLabel.text = "\(company.name) 님"
    }
}
