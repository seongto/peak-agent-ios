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
    
    private let viewModel = MapViewModel()
    private var currentLocationMarker: NMFMarker?
    private var leadMarkers: [NMFMarker] = []
    
    let leadResultsView = MapLeadResultsView().then {
        $0.isHidden = true
    }
    
    let mapContainerView = NMFNaverMapView()
    
    // MARK: - UI Components
    
    // 검색 버튼
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
    
    // 현재 위치로 이동 버튼
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
    
    // 추천 결과 전체 보기 버튼
    let showAllResultsButton = UIButton(type: .system).then {
        $0.setTitle("추천 결과 전체 보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
        $0.isHidden = true
    }
    
    // 리드 결과 컬렉션 뷰
    let resultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isHidden = true
        collectionView.register(CompanyInfoCell.self, forCellWithReuseIdentifier: CompanyInfoCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        moveToCurrentLocation()
        currentLocationButton.addTarget(self, action: #selector(moveToCurrentLocation), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        // 지도를 보여주는 메인 뷰
        addSubview(mapContainerView)
        // 검색 버튼 추가
        addSubview(searchButton)
        // 현재 위치 버튼 추가
        addSubview(currentLocationButton)
        // 현재 위치에서 리드 찾기 버튼 추가
        addSubview(leadSearchButton)
        // 회사 정보 리스트 뷰 추가
        addSubview(resultCollectionView)
        // 리드 결과 뷰 추가
        addSubview(leadResultsView)
        // 추천 결과 전체 보기 버튼 추가
        addSubview(showAllResultsButton)
    }
    
    private func setupLayout() {

        mapContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        // 검색 버튼 설정
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        // 리드 찾기 버튼 설정
        leadSearchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchButton.snp.bottom).offset(20)
            make.height.equalTo(36)
            make.leading.trailing.equalToSuperview().inset(100)
        }
        // 현재 위치 버튼 설정
        currentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-100)
            make.width.height.equalTo(48)
        }
        // 회사 정보 리스트 컬렉션뷰 설정
        resultCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(150)
            make.height.equalTo(150)
        }
        // 리드 결과 뷰 설정
        leadResultsView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(150 + 30)
        }
        // 추천 결과 전체 보기 버튼 설정
        showAllResultsButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(leadResultsView.snp.top).offset(-12)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
    }
    
    func showLeadResults() {
        bringSubviewToFront(leadResultsView)
        bringSubviewToFront(showAllResultsButton)
        currentLocationButton.snp.remakeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-250)
            make.width.height.equalTo(48)
        }
        leadResultsView.isHidden = false
        showAllResultsButton.isHidden = false
        leadResultsView.showLeadResults()
        showCurrentLocationMarker()
        showLeadMarkers()
    }
    
    func showOnlyCurrentLocationMarker() {
        leadMarkers.forEach { $0.mapView = nil }
        leadMarkers.removeAll()
        showCurrentLocationMarker()
        moveToCurrentLocation()
        leadResultsView.isHidden = true
        showAllResultsButton.isHidden = true
    }
    
    // 현재 위치 마커 생성 및 지도에 표시
    private func showCurrentLocationMarker() {
        if currentLocationMarker == nil {
            currentLocationMarker = NMFMarker()
            currentLocationMarker?.iconImage = NMFOverlayImage(image: UIImage(systemName: "location.fill")!)
            currentLocationMarker?.width = 32
            currentLocationMarker?.height = 32
        }
        currentLocationMarker?.position = viewModel.currentLocation
        currentLocationMarker?.mapView = mapContainerView.mapView
    }
    
    // 회사 마커들을 지도에 표시
    private func showLeadMarkers() {
        leadMarkers.forEach { $0.mapView = nil }
        leadMarkers.removeAll()
        let leadCoordinates = viewModel.leadCoordinates
        for coord in leadCoordinates {
            let marker = NMFMarker(position: coord)
            marker.iconImage = NMFOverlayImage(image: UIImage(systemName: "mappin")!)
            marker.width = 40
            marker.height = 40
            marker.anchor = CGPoint(x: 0.5, y: 1.0)
            marker.mapView = mapContainerView.mapView
            leadMarkers.append(marker)
        }
    }
    
    @objc private func moveToCurrentLocation() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: viewModel.currentLocation)
        cameraUpdate.animation = .easeIn
        mapContainerView.mapView.moveCamera(cameraUpdate)
    }
}
