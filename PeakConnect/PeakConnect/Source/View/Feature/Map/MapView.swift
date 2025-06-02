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
    
    // 지도와 위치 관련 데이터를 관리하는 뷰모델
    private let viewModel = MapViewModel()
    // 현재 위치를 나타내는 마커
    private var currentLocationMarker: NMFMarker?
    // 리드(회사 등) 위치 마커 배열
    var leadMarkers: [NMFMarker] = []
    
    var currentRecommendationId: Int?
    var onShowAllResultsButtonTapped: ((Int) -> Void)?
    var onCellTapped: ((Int) -> Void)?
    
    // 리드 검색 결과를 보여주는 뷰 (초기에는 숨김)
    let leadResultsView = MapLeadResultsView().then {
        $0.isHidden = true
    }
    
    // 네이버 지도를 표시하는 컨테이너 뷰
    let mapContainerView = NMFNaverMapView()
    
    // MARK: - UI 컴포넌트 선언
    // 지도 하단의 리드 탐색 모달 뷰
    let leadModalView = UIView().then {
        $0.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        $0.layer.cornerRadius = 20
        $0.isHidden = false
    }
    
    // 뒤로 가기 버튼
    let backButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        $0.tintColor = .white
    }
    
    // 모달의 타이틀 라벨
    let modalTitleLabel = UILabel().then {
        $0.text = "리드 탐색"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    // 장소/지역 검색 버튼
    let modalSearchButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor.primary
        $0.setTitle("장소 / 지역\n검색", for: .normal)
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 10
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.titleLabel?.numberOfLines = 2
        $0.titleLabel?.textAlignment = .center
        $0.contentHorizontalAlignment = .leading
        $0.contentVerticalAlignment = .center
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 60, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 80, left: -10, bottom: 40, right: 0)
    }
    
    // 현재 위치에서 리드 찾기 버튼
    let modalLeadSearchButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor.secondary
        $0.setTitle("현재 위치에서\n리드 찾기", for: .normal)
        $0.setImage(UIImage(systemName: "dot.scope"), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 10
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        $0.titleLabel?.numberOfLines = 2
        $0.titleLabel?.textAlignment = .center
        $0.contentHorizontalAlignment = .leading
        $0.contentVerticalAlignment = .center
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 60, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets(top: 80, left: -10, bottom: 40, right: 0)
    }
    
    // 현재 위치로 이동 버튼
    let currentLocationButton = UIButton(type: .system).then {
        
        $0.backgroundColor = UIColor.background
        $0.tintColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
        $0.setImage(UIImage(systemName: "dot.scope"), for: .normal)
    }
    
    // MARK: - 초기화
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        moveToCurrentLocation()
        
        // 현재 위치 버튼에 액션 연결
        currentLocationButton.addTarget(self, action: #selector(moveToCurrentLocation), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 뷰 계층 설정
    
    private func setupViews() {
        backgroundColor = .white
        // 지도 뷰 추가
        addSubview(mapContainerView)
        // 리드 탐색 모달 추가
        addSubview(leadModalView)
        // 현재 위치 버튼 추가
        addSubview(currentLocationButton)
        
        // 모달 내부 컴포넌트 추가
        leadModalView.addSubview(backButton)
        leadModalView.addSubview(modalTitleLabel)
        leadModalView.addSubview(modalSearchButton)
        leadModalView.addSubview(modalLeadSearchButton)
    }
    
    // MARK: - SnapKit 레이아웃 설정
    
    private func setupLayout() {
        // 지도 뷰는 전체 화면 설정
        mapContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 리드 탐색 모달 설정
        leadModalView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(260)
        }
        
        // 뒤로가기 버튼 설정
        backButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.size.equalTo(24)
        }
        
        // 모달 타이틀 설정
        modalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(leadModalView).offset(20)
            make.centerX.equalTo(leadModalView)
        }
        
        // 장소/지역 검색 버튼 설정
        modalSearchButton.snp.makeConstraints { make in
            make.top.equalTo(modalTitleLabel.snp.bottom).offset(40)
            make.leading.equalTo(leadModalView).offset(20)
            make.trailing.equalTo(leadModalView.snp.centerX).offset(-10)
            make.height.equalTo(120)
        }
        
        // 현재 위치에서 리드 찾기 버튼 설정
        modalLeadSearchButton.snp.makeConstraints { make in
            make.top.equalTo(modalTitleLabel.snp.bottom).offset(40)
            make.leading.equalTo(leadModalView.snp.centerX).offset(10)
            make.trailing.equalTo(leadModalView).offset(-20)
            make.height.equalTo(120)
        }
        
        // 현재 위치 버튼 설정
        currentLocationButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.bottom.equalTo(leadModalView.snp.top).offset(-30)
            make.width.height.equalTo(40)
        }
    }
    
    // MARK: - 지도 마커 관련 기능
    
    private func showCurrentLocationMarker() {
        if currentLocationMarker == nil {
            currentLocationMarker = NMFMarker()
        }

        // 현재 위치로 마커 위치 지정 및 지도에 표시
        currentLocationMarker?.position = viewModel.currentLocation
        currentLocationMarker?.mapView = mapContainerView.mapView
    }
    
    
    func showLeadMarkers(_ coordinates: [NMGLatLng]) {
        leadMarkers.forEach { $0.mapView = nil }
        leadMarkers.removeAll()
        for coord in coordinates {
            let marker = NMFMarker(position: coord)
            marker.anchor = CGPoint(x: 0.5, y: 1.0)
            marker.mapView = mapContainerView.mapView
            
            leadMarkers.append(marker)
        }
    }

    func updateLeadResults(_ leads: [Lead], recommendationId: Int) {
        let response = LeadRecommendationResponse(recommendation_id: recommendationId, leads: leads)
        leadResultsView.updateLeads(response)
    }
    
    // MARK: - 지도 이동 및 버튼 액션
    
    @objc private func moveToCurrentLocation() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: viewModel.currentLocation)
        cameraUpdate.animation = .easeIn
        mapContainerView.mapView.moveCamera(cameraUpdate)
    }
    
    func showLeadResultsView(recommendationId: Int) {
        leadModalView.isHidden = true
        showCurrentLocationMarker()

        if leadResultsView.superview == nil {
            mapContainerView.addSubview(leadResultsView)
        }

        leadResultsView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(10) // safe area 고려
            make.height.equalTo(300)
        }
        
//        leadResultsView.updateLeads(LeadRecommendationResponse(recommendation_id: recommendationId, leads: []))
        
        leadResultsView.onShowAllResultsButtonTapped = { [weak self] id in
            self?.onShowAllResultsButtonTapped?(id)
        }

        leadResultsView.onTrashButtonTapped = { [weak self] in
            self?.leadResultsView.isHidden = true
            self?.leadModalView.isHidden = false
            self?.modalSearchButton.isHidden = false
            self?.modalLeadSearchButton.isHidden = false
            self?.backButton.isHidden = false
            self?.leadMarkers.forEach { $0.mapView = nil }
            self?.leadMarkers.removeAll()
        }
        
        leadResultsView.onCellTapped = { [weak self] id in
            print("📍 MapView에서 셀 클릭 id: \(id)")
            self?.onCellTapped?(id)
        }

        leadResultsView.isHidden = false
    }
    
    func showOnlyCurrentLocationMarker() {
        leadMarkers.forEach { $0.mapView = nil }
        leadMarkers.removeAll()
        showCurrentLocationMarker()
        moveToCurrentLocation()
    }
}
