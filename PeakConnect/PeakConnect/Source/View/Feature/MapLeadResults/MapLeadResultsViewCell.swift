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
    
    // CEO
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
        $0.text = ""
        $0.numberOfLines = 1
    }
    private lazy var ceoStack = UIStackView(arrangedSubviews: [ceoTitleLabel, ceoValueLabel]).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 5
        $0.distribution = .fill
    }
    // Established
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
        $0.text = ""
        $0.numberOfLines = 1
    }
    private lazy var establishedStack = UIStackView(arrangedSubviews: [establishedTitleLabel, establishedValueLabel]).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 5
        $0.distribution = .fill
    }
    // Site as UIButton
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
        
        let iconView = UIImageView()
        let houseImage = UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysTemplate)
        iconView.image = houseImage
        iconView.tintColor = UIColor.white
        iconView.contentMode = .scaleAspectFit
        iconView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
        iconView.isUserInteractionEnabled = false
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, iconView])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        stack.distribution = .fill
        stack.isUserInteractionEnabled = false
        
        button.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        // Add action to check click functionality
        button.addTarget(nil, action: #selector(debugSiteButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func debugSiteButtonTapped() {
        UIPasteboard.general.string = "https://example.com"
        let alert = UIAlertController(title: nil, message: "클립보드가 복사되었습니다.", preferredStyle: .alert)
        DispatchQueue.main.async {
            if let topVC = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                topVC.present(alert, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        alert.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
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
            make.height.equalTo(300)
        }
        
        container.addSubview(companyNameLabel)
        container.addSubview(addressLabel)
        container.addSubview(bottomStackView)
        
        ceoContainer.addSubview(ceoStack)
        establishedContainer.addSubview(establishedStack)
        
        bottomStackView.addArrangedSubview(ceoContainer)
        bottomStackView.addArrangedSubview(establishedContainer)
        bottomStackView.addArrangedSubview(siteButton)
        
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(companyNameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(companyNameLabel)
        }
        
        ceoStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        ceoContainer.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(75)
        }
        establishedStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        establishedContainer.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(75)
        }
        siteButton.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.width.equalTo(75)
        }
        
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(20)
        }
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
