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
    }

    private func setupBindings() {
        let input = MapViewModel.Input(
            fetchLeadsTrigger: mapView.modalLeadSearchButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)

        output.leadCoordinates
            .drive(with: self) { owner, coords in
                owner.mapView.showLeadMarkers(coords)
            }
            .disposed(by: disposeBag)

        output.leads
            .drive(with: self) { owner, leads in
                owner.mapView.updateLeadResults(leads)
                owner.mapView.showLeadResultsView()
                owner.mapView.leadResultsView.isHidden = false
                owner.mapView.leadModalView.isHidden = true
                owner.mapView.modalSearchButton.isHidden = true
                owner.mapView.modalLeadSearchButton.isHidden = true
                owner.mapView.backButton.isHidden = true
            }
            .disposed(by: disposeBag)

        // 로딩 처리
        output.isLoading
            .drive(onNext: { isLoading in
                // 필요 시 로딩 인디케이터 처리
                print("로딩 중: \(isLoading)")
            })
            .disposed(by: disposeBag)

        // 오류 처리
        output.error
            .drive(onNext: { errorMessage in
                print("Error: \(errorMessage)")
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
        let dummySearchVC = SearchViewController()
        dummySearchVC.title = "검색"
        navigationController?.pushViewController(dummySearchVC, animated: false)
    }

    @objc private func didTapLeadResultsButton() {
        mapView.showLeadResultsView()
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
