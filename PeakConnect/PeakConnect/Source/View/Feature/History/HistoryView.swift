//
//  HistoryView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/28/25.
//

import UIKit
import SnapKit
import Then

class HistoryView: UIView {
    
    let colletionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(HistoryViewCollectionViewCell.self, forCellWithReuseIdentifier: HistoryViewCollectionViewCell.id)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryView {
    
    private func setupUI() {
        addSubview(colletionView)
        
        colletionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(20)
        }

    }
}
