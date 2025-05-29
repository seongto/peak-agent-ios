//
//  LeadComponentsView.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/29/25.
//

import UIKit
import SnapKit
import Then

class LeadComponentsView: UIView {
    
    var topView = UIView()
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .textPrimary
    }
    
    var bottomView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        [
            topView,
            separatorView,
            bottomView
        ].forEach {
            addSubview($0)
        }
        
        topView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(20)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(separatorView.snp.bottom).offset(10)
        }
    }
}
