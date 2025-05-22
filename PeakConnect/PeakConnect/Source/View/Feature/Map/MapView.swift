//
//  MapView.swift
//  PeakConnect
//
//  Created by 강민성 on 5/22/25.
//

import UIKit
import NMapsMap
import SnapKit
import Then

class MapView: UIView {

    // MARK: - UI Components
    
    // 검색 창 컨테이너 뷰
    let searchContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.05
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        $0.layer.shadowRadius = 4
    }
    
    // 돋보기 아이콘 이미지 뷰
    let searchIcon = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    // 검색어 입력 텍스트 필드
    let searchTextField = UITextField().then {
        $0.placeholder = "검색"
        $0.borderStyle = .none
        $0.font = UIFont.systemFont(ofSize: 16)
    }
    
    // 네이버 지도 뷰
    let mapContainerView = NMFNaverMapView()
    
    // 현재 위치 이동 버튼
    let currentLocationButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "location.fill"), for: .normal)
        $0.tintColor = .black
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
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
        
        // 각 컴포넌트를 뷰에 추가
        addSubview(searchContainerView)
        addSubview(currentLocationButton)
        addSubview(mapContainerView)
        
        searchContainerView.addSubview(searchIcon)
        searchContainerView.addSubview(searchTextField)
    }
    
    // 각 컴포넌트의 오토레이아웃 제약 조건 설정
    private func setupLayout() {
        mapContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        searchContainerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }

        searchIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }

        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchIcon.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }

        currentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-100)
            make.width.height.equalTo(48)
        }

        bringSubviewToFront(searchContainerView)
        bringSubviewToFront(currentLocationButton)
    }
}
