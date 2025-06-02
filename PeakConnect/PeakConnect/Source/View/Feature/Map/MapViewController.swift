//
//  MapViewController.swift
//  PeakConnect
//
//  Created by 강민성 on 5/22/25.
//

import UIKit
import NMapsMap
import RxSwift
import RxCocoa

class MapViewController: UIViewController {

    let mapView = MapView()
    private let viewModel = MapViewModel()
    private let disposeBag = DisposeBag()
    private let loadingView = LoadingView()
    private let searchResultRelay = PublishRelay<Location>()
    var initialLocation: Location?

    override func loadView() {
        view = mapView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupActions()
        
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { $0.edges.equalToSuperview() }
        loadingView.isHidden = true
        
        // 🌟 initialLocation 있을 경우, 해당 위치로 마커 및 카메라 이동
        if let location = initialLocation {
            let coord = NMGLatLng(lat: location.latitude, lng: location.longitude)
            
            // 기존 마커 제거
            mapView.leadMarkers.forEach { $0.mapView = nil }
            mapView.leadMarkers.removeAll()
            
            // 마커 추가
            let marker = NMFMarker(position: coord)
            marker.anchor = CGPoint(x: 0.5, y: 1.0)
            marker.mapView = mapView.mapContainerView.mapView
            mapView.leadMarkers.append(marker)
            
            // 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
            cameraUpdate.animation = .easeIn
            mapView.mapContainerView.mapView.moveCamera(cameraUpdate)
        }
            
        
        // ✅ 🔍 검색 결과 구독
        searchResultRelay
            .subscribe(onNext: { [weak self] location in
                guard let self = self else { return }
                print("📍 검색 결과 수신: \(location.latitude), \(location.longitude)")

                let coord = NMGLatLng(lat: location.latitude, lng: location.longitude)

                // 📍 기존 leadMarkers 초기화
                self.mapView.leadMarkers.forEach { $0.mapView = nil }
                self.mapView.leadMarkers.removeAll()

                // 📍 새로운 마커 추가 - 네이버 기본 마커 스타일 적용
                let marker = NMFMarker(position: coord)
                // 기본 마커를 쓰기 위해 iconImage 설정을 생략
                // marker.iconImage = NMFOverlayImage.default ← 이 부분 삭제
                marker.anchor = CGPoint(x: 0.5, y: 1.0)
                marker.mapView = self.mapView.mapContainerView.mapView
                self.mapView.leadMarkers.append(marker)

                // 📍 카메라 이동
                let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
                cameraUpdate.animation = .easeIn
                self.mapView.mapContainerView.mapView.moveCamera(cameraUpdate)
            })
            .disposed(by: disposeBag)
        
        // 📍 셀 클릭 시 화면 전환 처리
        mapView.onCellTapped = { [weak self] id in
            guard let self = self else { return }
            let detailVM = LeadDeatilViewModel(id: id)
            let detailVC = LeadDeatilViewController(leadDeatilViewModel: detailVM)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        // 📍 추천 결과 전체 보기 클릭 시 화면 전환 처리
        mapView.onShowAllResultsButtonTapped = { [weak self] recommendationId in
            let viewModel = HistoryResultViewModel(id: recommendationId)
            let vc = HistoryResultViewController(viewModel: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func setupBindings() {
        let input = MapViewModel.Input(
            fetchLeadsTrigger: mapView.modalLeadSearchButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.details
            .drive(onNext: { [weak self] details in
                guard let self = self else { return }
                self.mapView.showLeadMarkers(details.leads.map { NMGLatLng(lat: $0.latitude, lng: $0.longitude) })
                self.mapView.updateLeadResults(details.leads, recommendationId: details.recommendation_id)
                self.mapView.showLeadResultsView(recommendationId: details.recommendation_id)
                
                self.mapView.currentRecommendationId = details.recommendation_id  // 저장!
                self.mapView.leadResultsView.isHidden = false
                self.mapView.leadModalView.isHidden = true
                self.mapView.modalSearchButton.isHidden = true
                self.mapView.modalLeadSearchButton.isHidden = true
                self.mapView.backButton.isHidden = true
            })
            .disposed(by: disposeBag)

        output.isLoading
            .drive(onNext: { [weak self] isLoading in
                self?.loadingView.isHidden = !isLoading
            })
            .disposed(by: disposeBag)
    }

    private func setupActions() {
        mapView.modalSearchButton.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
        mapView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
    }

    @objc private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func didTapSearchButton() {
        let searchViewModel = SearchViewModel(searchResultRelay)
        let searchViewController = SearchViewController(searchViewModel: searchViewModel)
        searchViewController.title = "검색"
        navigationController?.pushViewController(searchViewController, animated: false)
    }

    @objc private func didTapLeadResultsButton() {
        let mapLeadResultsVC = MapLeadResultsViewController()
        navigationController?.pushViewController(mapLeadResultsVC, animated: true)
        
        let recommendationId = mapView.currentRecommendationId ?? 0  // 안전하게 처리
        mapView.showLeadResultsView(recommendationId: recommendationId)
        
        mapView.modalSearchButton.isHidden = true
        mapView.modalLeadSearchButton.isHidden = true
        mapView.backButton.isHidden = true
    }

    private func showLeadMarkers(_ coordinates: [NMGLatLng]) {
        mapView.leadMarkers.forEach { $0.mapView = nil }
        mapView.leadMarkers.removeAll()
        coordinates.forEach {
            let marker = NMFMarker(position: $0)
            marker.iconImage = NMFOverlayImage(image: UIImage(systemName: "flag.fill")!)
            marker.width = 40
            marker.height = 40
            marker.anchor = CGPoint(x: 0.5, y: 1.0)
            marker.mapView = mapView.mapContainerView.mapView
            mapView.leadMarkers.append(marker)
        }
    }
}
