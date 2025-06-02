//
//  LoadingView.swift
//  PeakConnect
//
//  Created by 강민성 on 6/2/25.
//

import UIKit
import Then
import SnapKit

class LoadingView: UIView {
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "LoadingImage")
        $0.contentMode = .scaleAspectFit
    }
    
    private let activityIndicator = UIActivityIndicatorView(style: .large).then {
        $0.color = .white
        $0.startAnimating()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .background
        
        addSubview(logoImageView)
        addSubview(activityIndicator)
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
            $0.width.height.equalTo(150)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
}

