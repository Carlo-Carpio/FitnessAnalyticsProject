//
//  PeriodCollectionViewCell.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 19/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

struct PeriodCollectionViewCellViewModel {
    var title: String
    var onTap: (() -> Void)
}

class PeriodCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var periodTitleLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        self.periodTitleLabel.textColor = .lightGray
        self.layer.cornerRadius = 12
    }
    
    override var isSelected: Bool {
        didSet {
            periodTitleLabel.textColor = isSelected ? .white : .lightGray
            periodTitleLabel.font = isSelected ? .boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 15)
            contentView.backgroundColor = isSelected ? .red : .clear
        }
    }
    
    // MARK: - Setup functions
    
    func configure(viewModel: PeriodCollectionViewCellViewModel) {
        periodTitleLabel.text = viewModel.title
    }
}
