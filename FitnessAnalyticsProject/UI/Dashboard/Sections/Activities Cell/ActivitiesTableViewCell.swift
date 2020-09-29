//
//  ActivitiesTableViewCell.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 19/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {
    
    // MARK: - IBOultes
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var activityViewModels: [ActivityCollectionViewCellViewModel] = []
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        collectionView.register(ActivityCollectionViewCell.nib,
                                forCellWithReuseIdentifier: ActivityCollectionViewCell.identifier)
    }
    
    // MARK: - Setup functions
    func configure(activityViewModels: [ActivityCollectionViewCellViewModel]) {
        self.activityViewModels = activityViewModels
        collectionView.reloadData()
    }
}

extension ActivitiesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activityViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivityCollectionViewCell.identifier,
                                                          for: indexPath) as? ActivityCollectionViewCell
            else {
                return UICollectionViewCell()
            }
        cell.configure(viewModel: activityViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        activityViewModels[indexPath.row].onTap()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
    }
}

