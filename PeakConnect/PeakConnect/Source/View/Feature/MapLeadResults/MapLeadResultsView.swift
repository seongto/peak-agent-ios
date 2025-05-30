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
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .background
        $0.layer.cornerRadius = 14
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }

    let trashButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "trash"), for: .normal)
        $0.backgroundColor = .background
        $0.layer.cornerRadius = 14
        $0.imageView?.contentMode = .scaleAspectFit
        $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }

    // MARK: - Properties
    private var details: [Lead] = []

    var onTrashButtonTapped: (() -> Void)?
    var onShowAllResultsButtonTapped: (([Int]) -> Void)?
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
        resultCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
            make.height.equalTo(250)
        }

        addSubview(showAllResultsButton)
        showAllResultsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
            make.width.equalTo(160)
        }

        addSubview(trashButton)
        trashButton.snp.makeConstraints { make in
            make.leading.equalTo(showAllResultsButton.snp.trailing).offset(30)
            make.centerY.equalTo(showAllResultsButton)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }

        resultCollectionView.dataSource = self
        resultCollectionView.delegate = self
    }

    private func setupActions() {
        trashButton.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        showAllResultsButton.addTarget(self, action: #selector(showAllResultsTapped), for: .touchUpInside)
    }
    
    @objc private func showAllResultsTapped() {
        let sampleId = details.first?.id ?? 1  // 없으면 1
        onShowAllResultsButtonTapped?([sampleId])
    }

    // MARK: - Public Methods
    func updateLeads(_ details: [Lead]) {
        print("🔥 updateLeads 호출, leads 개수: \(details.count)")  // ✅
        self.details = details
        resultCollectionView.reloadData()
    }
    // MARK: - Actions
    @objc private func trashButtonTapped() {
        onTrashButtonTapped?()
    }
}

// MARK: - UICollectionViewDataSource
extension MapLeadResultsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyInfoCell.identifier, for: indexPath) as? CompanyInfoCell else {
            return UICollectionViewCell()
        }
        let detail = details[indexPath.item]
        cell.configure(
            companyName: detail.name,
            address: detail.address,
            tags: detail.industry,
            ceo: "N/A",
            established: "N/A"
        )
        
        cell.onCellTapped = { [weak self] in  // 추가: 셀 내부 버튼 클릭 처리
            print("📍 MapLeadResultsView에서 셀 클릭 id: \(detail.id)")
            self?.onCellTapped?(detail.id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedId = details[indexPath.item].id
        print("📍 collectionView didSelectItemAt 클릭됨, id: \(selectedId)")
        onCellTapped?(selectedId)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MapLeadResultsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 200)
    }
}
