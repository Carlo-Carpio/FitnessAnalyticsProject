//
//  ActivityCollectionViewCell.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 19/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

struct ActivityCollectionViewCellViewModel {
    var activity: Activity
    var onTap: (() -> Void)
}

class ActivityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var iconTrainingImageView: UIImageView!
    @IBOutlet private weak var activityContentLabel: UILabel!
    @IBOutlet private weak var activityTrainingLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    // MARK: - Setup Functions
    func configure(viewModel: ActivityCollectionViewCellViewModel) {
        setupViews()
        iconTrainingImageView.image = viewModel.activity.training.icon
        activityTrainingLabel.text = viewModel.activity.training.name
        
        containerView.backgroundColor = viewModel.activity.training.color
        
        if viewModel.activity.training.type == .steps ||
            viewModel.activity.training.type == .running {
            guard
                let stepsNumber = viewModel.activity.statistics.first(where: ({ $0.type == .step}))?.value
                else { return }
            activityContentLabel.text = "\(stepsNumber)"
        } else {
            guard
                let durationActivity = viewModel.activity.statistics.first(where: ({ $0.type == .duration}))
                else { return }
            activityContentLabel.text = "\(durationActivity.value) \(durationActivity.unitOfMeasurement)"
        }
    }
    
    // MARK: - Setup functions
    
    private func setupViews() {
        self.containerView.layer.cornerRadius = 10
    }
}
