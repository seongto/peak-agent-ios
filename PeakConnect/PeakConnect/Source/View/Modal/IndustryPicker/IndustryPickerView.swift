//
//  IndustryPickerView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/23/25.
//

import UIKit
import SnapKit
import Then

final class IndustryPickerView: UIView {
    
    // MARK: - UI Components
    
    let collectionView = IndustryPickerCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let resultTitle = UILabel().then {
        $0.text = "선택된 산업군"
        $0.textAlignment = .left
    }
    
    private let industryStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    
    let cancleButton = UIButton(type: .system).then {
        $0.setTitle("취소", for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .gray
    }
    
    let acceptButton = UIButton(type: .system).then {
        $0.setTitle("확인", for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .blue
    }
        
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension IndustryPickerView {
    
    private func setupUI() {
        backgroundColor = .white
        
        [
            collectionView,
            resultTitle,
            industryStackView,
            bottomStackView
        ].forEach {
            addSubview($0)
        }
        
        [
            cancleButton,
            acceptButton
        ].forEach {
            bottomStackView.addArrangedSubview($0)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.bottom.equalTo(resultTitle.snp.top).inset(-20)
        }
        
        resultTitle.snp.makeConstraints { make in
            make.bottom.equalTo(industryStackView.snp.top).inset(-20)
            make.horizontalEdges.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        
        industryStackView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.horizontalEdges.equalToSuperview().offset(10)
            make.bottom.equalTo(bottomStackView.snp.top).inset(-20)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
            make.height.equalTo(50)
        }
        
        cancleButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}
