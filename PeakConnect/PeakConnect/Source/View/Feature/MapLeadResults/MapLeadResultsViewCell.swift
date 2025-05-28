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
    
    private let container = UIView().then {
        $0.backgroundColor = UIColor.primary
        $0.layer.cornerRadius = 24
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 8
    }
    
    private let companyNameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = UIColor.white
        $0.numberOfLines = 1
    }
    
    private let addressLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = UIColor.white
        $0.numberOfLines = 2
    }
    
    private let ceoButton = UIButton(type: .system).then {
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor(named: "primary-dark")
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    private let establishedButton = UIButton(type: .system).then {
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor(named: "primary-dark")
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private let siteButton = UIButton(type: .system).then {
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.backgroundColor = UIColor(named: "primary-dark")
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        $0.setContentHuggingPriority(.required, for: .horizontal)
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        $0.setTitle("사이트", for: .normal)
        $0.isUserInteractionEnabled = true
    }
    
    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .center
        $0.distribution = .fillProportionally
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
            make.width.equalTo(320)
            make.height.equalTo(200)
        }
        
        container.addSubview(companyNameLabel)
        container.addSubview(addressLabel)
        container.addSubview(bottomStackView)
        
        bottomStackView.addArrangedSubview(ceoButton)
        bottomStackView.addArrangedSubview(establishedButton)
        bottomStackView.addArrangedSubview(siteButton)
        
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(companyNameLabel)
        }

        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
    
    func configure(companyName: String, address: String, tags: String, ceo: String, established: String) {

        companyNameLabel.text = companyName
        addressLabel.text = address
        ceoButton.setTitle(ceo, for: .normal)
        establishedButton.setTitle(established, for: .normal)

    }
}


class PaddingLabel: UILabel {
    var padding = UIEdgeInsets.zero

    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}
