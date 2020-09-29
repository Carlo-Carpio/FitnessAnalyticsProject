//
//  DetailedActivityCollectionViewCell.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 21/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

struct DetailedActivityCollectionViewCellViewModel {
    var title: String
    var contentTitle: String
    var contentValue: String
    var icon: UIImage?
    var caloriesBurnt: Float
    var heartRate: Float
    var speed: Float
    var training: Training
    var onTap: (() -> Void)
    
    init() {
        self.title = "NaN"
        self.contentTitle = "NaN"
        self.contentValue = "NaN"
        self.icon = nil
        self.caloriesBurnt = 0.0
        self.heartRate = 0.0
        self.speed = 0.0
        self.training = Training(type: .steps)
        self.onTap = {}
    }
    
    init(title: String,
         contentTitle: String,
         contentValue: String,
         icon: UIImage? = nil,
         caloriesBurnt: Float,
         heartRate: Float,
         speed: Float,
         training: Training,
         onTap: @escaping (() -> Void)) {
        self.title = title
        self.contentTitle = contentTitle
        self.contentValue = contentValue
        self.caloriesBurnt = caloriesBurnt
        self.heartRate = heartRate
        self.speed = speed
        self.training = training
        self.onTap = onTap
    }
}

class DetailedActivityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var activityTitleLabel: UILabel!
    @IBOutlet private weak var statisticTitleLabel: UILabel!
    @IBOutlet private weak var statisticValueLabel: UILabel!
    @IBOutlet private weak var activityIconImageView: UIImageView!
    @IBOutlet private weak var speedValueLabel: UILabel!
    @IBOutlet private weak var maxHrValueLabel: UILabel!
    @IBOutlet private weak var caloriesBurntValueLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 10
    }
    
    // MARK: - Setup functions
    func configure(viewModel: DetailedActivityCollectionViewCellViewModel) {
        activityTitleLabel.text = viewModel.title
        statisticTitleLabel.text = viewModel.contentTitle
        statisticValueLabel.text = viewModel.contentValue
        activityIconImageView.image = viewModel.icon
        speedValueLabel.text = "\(viewModel.speed)"
        maxHrValueLabel.text = "\(viewModel.heartRate)"
        caloriesBurntValueLabel.text = "\(viewModel.caloriesBurnt)"
        containerView.backgroundColor = viewModel.training.color
    }
}
