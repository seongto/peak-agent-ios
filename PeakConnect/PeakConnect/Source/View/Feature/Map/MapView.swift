//
//  MapView.swift
//  PeakConnect
//
//  Created by 강민성 on 5/22/25.
//

import UIKit
import NMapsMap
import SnapKit

class MapView: UIView {

    // MARK: - UI Components
    let searchContainerView = UIView()
    let searchIcon = UIImageView()
    let searchTextField = UITextField()
    let mapContainerView = NMFNaverMapView()
    let currentLocationButton = UIButton(type: .system)

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
        
        addSubview(searchContainerView)
        addSubview(currentLocationButton)
        addSubview(mapContainerView)
        
        searchContainerView.backgroundColor = .white
        searchContainerView.layer.cornerRadius = 10
        searchContainerView.layer.shadowColor = UIColor.black.cgColor
        searchContainerView.layer.shadowOpacity = 0.05
        searchContainerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchContainerView.layer.shadowRadius = 4

        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = .gray
        searchIcon.contentMode = .scaleAspectFit
        searchContainerView.addSubview(searchIcon)

        searchTextField.placeholder = "검색"
        searchTextField.borderStyle = .none
        searchTextField.font = UIFont.systemFont(ofSize: 16)
        searchContainerView.addSubview(searchTextField)

        currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        currentLocationButton.tintColor = .black
        currentLocationButton.backgroundColor = .white
        currentLocationButton.layer.cornerRadius = 24
        currentLocationButton.layer.shadowColor = UIColor.black.cgColor
        currentLocationButton.layer.shadowOpacity = 0.2
        currentLocationButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        currentLocationButton.layer.shadowRadius = 4
    }

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
