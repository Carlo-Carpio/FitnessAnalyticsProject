//
//  StatisticsTableViewCell.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 21/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var staticViewModels: [StatisticCollectionViewCellViewModel] = []
    private let padding: CGFloat = 10
    private let numberOdImagesForRow = 2
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        collectionView.register(StatisticCollectionViewCell.nib,
                                forCellWithReuseIdentifier: StatisticCollectionViewCell.identifier)
    }
    
    // MARK: - Setup funcions
    func configure(viewModels: [StatisticCollectionViewCellViewModel]) {
        staticViewModels = viewModels
        collectionView.reloadData()
    }
}

extension StatisticsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return staticViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticCollectionViewCell.identifier,
                                                            for: indexPath) as? StatisticCollectionViewCell
            else {
                return UICollectionViewCell()
            }
        cell.configure(viewModel: staticViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
       
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width - 3 * padding) / 2
        return CGSize(width: cellWidth, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding)
    }
}
