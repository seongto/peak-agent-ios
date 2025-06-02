//
//  MapLeadResultsView.swift
//  PeakConnect
//
//  Created by 강민성 on 5/26/25.
//

import UIKit
import SnapKit
import Then

class MapLeadResultsView: UIView {

    // MARK: - UI Components
    
    private let resultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(CompanyInfoCell.self, forCellWithReuseIdentifier: CompanyInfoCell.identifier)
        return collectionView
    }()

    let showAllResultsButton = UIButton(type: .system).then {
        $0.setTitle("추천 결과 전체 보기", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .background
        $0.layer.cornerRadius = 14
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }

    let trashButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.tintColor = .grayssss
        $0.backgroundColor = .background
        $0.layer.cornerRadius = 39 / 2
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }

    // MARK: - Properties
    private var details: LeadRecommendationResponse?

    var onTrashButtonTapped: (() -> Void)?
    var onShowAllResultsButtonTapped: ((Int) -> Void)?
    var onCellTapped: ((Int) -> Void)?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupActions()
    }

    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(resultCollectionView)
        addSubview(showAllResultsButton)

        resultCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(showAllResultsButton.snp.top).offset(-20)
            make.height.equalTo(120)
        }

        showAllResultsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(39)
            make.width.equalTo(163)
        }

        addSubview(trashButton)
        trashButton.snp.makeConstraints { make in
            make.leading.equalTo(showAllResultsButton.snp.trailing).offset(20)
            make.centerY.equalTo(showAllResultsButton)
            make.size.equalTo(39)
        }

        resultCollectionView.dataSource = self
        resultCollectionView.delegate = self
    }

    private func setupActions() {
        trashButton.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        showAllResultsButton.addTarget(self, action: #selector(showAllResultsTapped), for: .touchUpInside)
    }
    
    @objc private func showAllResultsTapped() {
        guard let id = details?.recommendation_id else { return }
        onShowAllResultsButtonTapped?(id) // ✅ Pass recommendation_id to HistoryResult
    }

    @objc private func trashButtonTapped() {
        onTrashButtonTapped?()
    }

    func updateLeads(_ details: LeadRecommendationResponse) {
        self.details = details
        print("업데이트된 leads 개수: \(details.leads.count)")
        resultCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension MapLeadResultsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("📍 컬렉션뷰 셀 개수: \(details?.leads.count ?? 0)")
        return details?.leads.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyInfoCell.identifier, for: indexPath) as? CompanyInfoCell,
              let lead = details?.leads[indexPath.item] else {
            return UICollectionViewCell()
        }

        cell.configure(lead)

        // ✅ 셀 클릭 시 recommendation_id만 넘김
        cell.onCellTapped = { [weak self] in
            self?.onCellTapped?(lead.id) // lead.id를 넘김!
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let lead = details?.leads[indexPath.item] else { return }
        onCellTapped?(lead.id) // lead.id를 넘김!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 80, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
