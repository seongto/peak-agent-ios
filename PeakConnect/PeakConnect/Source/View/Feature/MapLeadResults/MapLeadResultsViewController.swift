//
//  Untitled.swift
//  PeakConnect
//
//  Created by 강민성 on 5/29/25.
//

import UIKit

class MapLeadResultsViewController: UIViewController {
    
    let resultsView = MapLeadResultsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = resultsView

        resultsView.onTrashButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc private func didTapLeadResultsButton() {
        let leadResultsVC = MapLeadResultsViewController()
        navigationController?.pushViewController(leadResultsVC, animated: true)
    }
}
