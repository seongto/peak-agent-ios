//
//  TabbarView.swift
//  PeakConnect
//
//  Created by 강민성 on 5/23/25.
//

import UIKit
import SnapKit
import Then

class TabbarView: UIView {

    // MARK: - UI Components

    // 탭바 전체 컨테이너 뷰
    let tabbarContainerView = UIView().then {
        $0.backgroundColor = UIColor.white
    }

    // 홈 버튼
    let homeButton = UIButton(type: .system).then {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "house.fill")
        config.title = "홈"
        config.imagePlacement = .top
        config.imagePadding = 6
        config.baseForegroundColor = .black
        config.titleTextAttributesTransformer = .init({ container in
            var attr = container
            attr.font = UIFont.systemFont(ofSize: 12)
            return attr
        })
        $0.configuration = config
        $0.tintColor = .black
    }

    // 히스토리 버튼
    let historyButton = UIButton(type: .system).then {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "clock.fill")
        config.title = "히스토리"
        config.imagePlacement = .top
        config.imagePadding = 6
        config.baseForegroundColor = .black
        config.titleTextAttributesTransformer = .init({ container in
            var attr = container
            attr.font = UIFont.systemFont(ofSize: 12)
            return attr
        })
        $0.configuration = config
        $0.tintColor = .black
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
        
        // 컨테이너 뷰 추가 및 버튼들 하위에 추가
        addSubview(tabbarContainerView)
        [homeButton, historyButton].forEach { tabbarContainerView.addSubview($0) }
    }

    private func setupLayout() {
        // 탭바 컨테이너의 위치와 높이 설정
        tabbarContainerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
        }

        // 홈 버튼 레이아웃 설정
        homeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.centerY.equalToSuperview()
        }

        // 히스토리 버튼 레이아웃 설정
        historyButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview()
        }
    }
}
