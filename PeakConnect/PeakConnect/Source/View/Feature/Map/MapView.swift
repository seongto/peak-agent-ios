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
    
    // 검색창 역할을 하는 버튼 (탭 시 검색 화면으로 이동)
    let searchButton = UIButton(type: .system).then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.05
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        $0.layer.shadowRadius = 4
        $0.setImage(UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .black
        $0.setTitle("  장소, 지역 검색", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -6)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
    }
    
    // 네이버 지도 뷰
    let mapContainerView = NMFNaverMapView()
    
    // 현재 위치 이동 버튼
    let currentLocationButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "dot.scope"), for: .normal)
        $0.tintColor = .black
        $0.layer.cornerRadius = 24
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
    }
    
    // 현재 위치에서 리드 찾기 버튼
    let leadSearchButton = UIButton(type: .system).then {
        $0.setTitle("현재 위치에서 리드 찾기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 8
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
        addSubview(searchButton)
        addSubview(currentLocationButton)
        addSubview(mapContainerView)
        addSubview(leadSearchButton)
    }
    
    // 각 컴포넌트의 오토레이아웃 제약 조건 설정
    private func setupLayout() {
        mapContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        searchButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        leadSearchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchButton.snp.bottom).offset(20)
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview().inset(100)
        }

        currentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-100)
            make.width.height.equalTo(48)
        }

        bringSubviewToFront(searchButton)
        bringSubviewToFront(currentLocationButton)
    }
}
