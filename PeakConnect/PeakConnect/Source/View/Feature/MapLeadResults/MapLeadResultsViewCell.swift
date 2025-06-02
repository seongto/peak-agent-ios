//
//  MapLeadResultsViewCell.swift
//  PeakConnect
//
//  Created by 강민성 on 5/26/25.
//

import UIKit
import SnapKit
import Then

class CompanyInfoCell: UICollectionViewCell {
    
    static let identifier = "CompanyInfoCell"
    
    var onCellTapped: (() -> Void)?  // 셀 클릭 시 콜백
    
    private let companyNameLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = UIColor.white
        $0.numberOfLines = 1
    }
    
    private let addressLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = UIColor.white
        $0.numberOfLines = 2
    }
    
    private let industryLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupAction()
    }
    
    private func setupUI() {
        layer.cornerRadius = 24
        backgroundColor = .primary
        
        [
            companyNameLabel,
            addressLabel,
            industryLabel
        ].forEach {
            addSubview($0)
        }
        
        companyNameLabel.snp.makeConstraints { make in make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalTo(companyNameLabel)
        }
        
        industryLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(20)
        }
        
    }
    
    private func setupAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleCellTap() {
        print("📍 셀 클릭됨")
        onCellTapped?()
    }
    
    func configure(_ lead: Lead) {
        companyNameLabel.text = lead.name
        addressLabel.text = lead.address
        let industries = lead.industry
            .split(separator: ",")
            .map { "# \($0.trimmingCharacters(in: .whitespaces))" }
            .joined(separator: " ")
        
        industryLabel.text = industries
    }
}
