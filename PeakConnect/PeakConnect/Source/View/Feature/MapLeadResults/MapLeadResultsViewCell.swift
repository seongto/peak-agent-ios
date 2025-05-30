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

    private let containerButton = UIButton(type: .system).then {
        $0.backgroundColor = UIColor.primary
        $0.layer.cornerRadius = 24
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.15
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 8
        $0.clipsToBounds = true
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

    private let ceoContainer = UIView().then {
        $0.backgroundColor = UIColor(named: "primary-dark")
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    private let ceoTitleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 12)
        $0.textColor = UIColor.white.withAlphaComponent(0.8)
        $0.textAlignment = .center
        $0.text = "CEO"
    }
    private let ceoValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = UIColor.white
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    private lazy var ceoStack = UIStackView(arrangedSubviews: [ceoTitleLabel, ceoValueLabel]).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 5
    }

    private let establishedContainer = UIView().then {
        $0.backgroundColor = UIColor(named: "primary-dark")
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    private let establishedTitleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 12)
        $0.textColor = UIColor.white.withAlphaComponent(0.8)
        $0.textAlignment = .center
        $0.text = "설립년도"
    }
    private let establishedValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = UIColor.white
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    private lazy var establishedStack = UIStackView(arrangedSubviews: [establishedTitleLabel, establishedValueLabel]).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 5
    }

    private let siteButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "primary-dark")
        button.layer.cornerRadius = 12
        button.clipsToBounds = true

        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        titleLabel.textAlignment = .center
        titleLabel.text = "사이트"
        titleLabel.isUserInteractionEnabled = false

        let iconView = UIImageView(image: UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate))
        iconView.tintColor = UIColor.white
        iconView.contentMode = .scaleAspectFit
        iconView.snp.makeConstraints { $0.size.equalTo(20) }
        iconView.isUserInteractionEnabled = false

        let stack = UIStackView(arrangedSubviews: [titleLabel, iconView])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        stack.isUserInteractionEnabled = false

        button.addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview().inset(8) }
        return button
    }()

    private let bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
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
        contentView.addSubview(containerButton)
        containerButton.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }

        containerButton.addSubview(companyNameLabel)
        containerButton.addSubview(addressLabel)
        containerButton.addSubview(bottomStackView)

        ceoContainer.addSubview(ceoStack)
        establishedContainer.addSubview(establishedStack)
        bottomStackView.addArrangedSubview(ceoContainer)
        bottomStackView.addArrangedSubview(establishedContainer)
        bottomStackView.addArrangedSubview(siteButton)

        companyNameLabel.snp.makeConstraints { $0.top.leading.trailing.equalToSuperview().inset(20) }
        addressLabel.snp.makeConstraints { $0.top.equalTo(companyNameLabel.snp.bottom).offset(8); $0.leading.trailing.equalTo(companyNameLabel) }
        ceoStack.snp.makeConstraints { $0.edges.equalToSuperview().inset(8) }
        establishedStack.snp.makeConstraints { $0.edges.equalToSuperview().inset(8) }
        ceoContainer.snp.makeConstraints { $0.size.equalTo(CGSize(width: 75, height: 55)) }
        establishedContainer.snp.makeConstraints { $0.size.equalTo(CGSize(width: 75, height: 55)) }
        siteButton.snp.makeConstraints { $0.size.equalTo(CGSize(width: 75, height: 55)) }
        bottomStackView.snp.makeConstraints { $0.top.equalTo(addressLabel.snp.bottom).offset(4); $0.leading.trailing.equalToSuperview().inset(20) }
    }

    private func setupAction() {
        containerButton.addTarget(self, action: #selector(handleCellTap), for: .touchUpInside)
    }

    @objc private func handleCellTap() {
        print("📍 셀 클릭됨")
        onCellTapped?()
    }

    func configure(companyName: String, address: String, tags: String, ceo: String, established: String) {
        companyNameLabel.text = companyName
        addressLabel.text = address
        ceoValueLabel.text = ceo
        establishedValueLabel.text = established
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
}
