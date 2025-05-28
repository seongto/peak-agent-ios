//
//  HistoryViewCollectionViewCell.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import SnapKit
import Then

class HistoryViewCollectionViewCell: UICollectionViewCell {
    
    static let id = "HistoryViewCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryViewCollectionViewCell {
    
    private func setupUI() {
        backgroundColor = .text
        layer.cornerRadius = 24

    }
}
