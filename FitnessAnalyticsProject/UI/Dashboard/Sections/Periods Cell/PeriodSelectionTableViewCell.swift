//
//  PeriodSelectionTableViewCell.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 19/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

class PeriodSelectionTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    private var periodViewModels: [PeriodCollectionViewCellViewModel] = []
    private var isAlreadyBeenHandled: Bool = false
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(PeriodCollectionViewCell.nib,
                                forCellWithReuseIdentifier: PeriodCollectionViewCell.identifier)
    }
    
    override func layoutIfNeeded() {
        if !isAlreadyBeenHandled {
            let indexPath:IndexPath = IndexPath(row: 0, section: 0)
            collectionView?.selectItem(at: indexPath, animated: false, scrollPosition: .top)
            isAlreadyBeenHandled.toggle()
        }
    }
    
    // MARK: - Setup functions
    func configure(periodViewModels: [PeriodCollectionViewCellViewModel]) {
        self.periodViewModels = periodViewModels
        self.collectionView.reloadData()
    }
}

extension PeriodSelectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return periodViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeriodCollectionViewCell.identifier,
                                                          for: indexPath) as? PeriodCollectionViewCell
            else {
                return UICollectionViewCell()
            }
        
        cell.configure(viewModel: periodViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / CGFloat(periodViewModels.count)
        return CGSize(width: width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        periodViewModels[indexPath.row].onTap()
    }
}
