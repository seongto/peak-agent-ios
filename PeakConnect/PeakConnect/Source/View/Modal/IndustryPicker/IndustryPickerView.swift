//
//  IndustryPickerView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/23/25.
//

import UIKit
import SnapKit
import Then

class IndustryPickerView: UIView {
    
    // MARK: - UI Components
    
    var collectionView = IndustryPickerCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
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
            collectionView
        ].forEach {
            addSubview($0)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
