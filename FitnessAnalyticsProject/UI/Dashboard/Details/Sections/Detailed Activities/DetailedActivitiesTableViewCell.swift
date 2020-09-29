//
//  DetailedActivitiesTableViewCell.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 21/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

class DetailedActivitiesTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(DetailedActivityCollectionViewCell.nib,
                                forCellWithReuseIdentifier: DetailedActivityCollectionViewCell.identifier)
    }
    
    // MARK: - Properties
    private var detailedActivityViewModels: [DetailedActivityCollectionViewCellViewModel] = []
    
    // MARK: - Setup functions
    func configure(detailedActivityViewModels: [DetailedActivityCollectionViewCellViewModel]) {
        self.detailedActivityViewModels = detailedActivityViewModels
        collectionView.reloadData()
    }
}

extension DetailedActivitiesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailedActivityViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedActivityCollectionViewCell.identifier,
                                                            for: indexPath) as? DetailedActivityCollectionViewCell
            else {
                return UICollectionViewCell()
            }
        cell.configure(viewModel: detailedActivityViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return detailedActivityViewModels[indexPath.row].onTap()
    }
}
