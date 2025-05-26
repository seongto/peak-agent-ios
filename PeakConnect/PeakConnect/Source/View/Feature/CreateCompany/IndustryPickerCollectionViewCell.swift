import UIKit
import SnapKit
import Then

final class IndustryPickerCollectionViewCell: UICollectionViewCell {
    
    static let id = "IndustryPickerCollectionViewCell"
    
    private let tagButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.contentEdgeInsets = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        $0.layer.cornerRadius = 13
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - 레이아웃 설정

extension IndustryPickerCollectionViewCell {
    
    private func setupUI() {
        contentView.addSubview(tagButton)
        
        tagButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - 데이터 설정

extension IndustryPickerCollectionViewCell {
    
    func setTitle(_ title: String) {
        tagButton.setTitle(title, for: .normal)
    }
    
    func setColor(_ isSelected: Bool) {
        tagButton.backgroundColor = isSelected ? .primary : .disabled
    }
}
