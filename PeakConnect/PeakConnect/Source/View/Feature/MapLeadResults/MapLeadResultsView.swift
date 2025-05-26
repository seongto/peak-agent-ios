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
    
    private var viewModel = MapLeadResultsViewModel()
    
    // 전체 추천 결과 보기 버튼
    let showAllResultsButton = UIButton(type: .system).then {
        $0.setTitle("추천 결과 전체 보기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = .boldSystemFont(ofSize: 14)
    }
    
    // 추천 결과를 보여줄 컬렉션 뷰
    let resultCollectionView: UICollectionView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear

        addSubview(resultCollectionView)
        resultCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(200)
        }

        resultCollectionView.dataSource = self
        resultCollectionView.delegate = self
    }
    
    // 데이터를 로드하여 추천 결과를 보여주는 메소드 (더미 데이터)
    func showLeadResults() {
        viewModel.loadDummyData()
        resultCollectionView.reloadData()
    }
}

extension MapLeadResultsView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.companyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyInfoCell.identifier, for: indexPath) as? CompanyInfoCell else {
            return UICollectionViewCell()
        }
        let data = viewModel.companyData[indexPath.item]
        cell.configure(companyName: data.name, additionalInfo: data.info)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 150)
    }
}
