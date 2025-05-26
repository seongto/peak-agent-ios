import UIKit
import SnapKit
import Then

final class IndustryPickerCollectionViewCell: UICollectionViewCell {
    
    static let id = "IndustryPickerCollectionViewCell"
    
    private let tagButton = UIButton().then {
        $0.backgroundColor = .yellow
        $0.tintColor = .black
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
        $0.layer.cornerRadius = 10
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
        tagButton.backgroundColor = isSelected ? .lightGray : .white
    }
}
