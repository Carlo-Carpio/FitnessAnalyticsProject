//
//  StatisticCollectionViewCell.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 21/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

struct StatisticCollectionViewCellViewModel {
    var icon: UIImage?
    var title: String
    var statistic: Statistic
}

class StatisticCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var statisticTitleLabel: UILabel!
    @IBOutlet private weak var statisticValueLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = ColorManager.solitude
        
    }
    
    func configure(viewModel: StatisticCollectionViewCellViewModel) {
        statisticTitleLabel.text = viewModel.title
        statisticValueLabel.text = "\(viewModel.statistic.value) \(viewModel.statistic.unitOfMeasurement)"
        
        if let icon = viewModel.icon {
            iconImageView.image = icon
        }
    }
    
}
