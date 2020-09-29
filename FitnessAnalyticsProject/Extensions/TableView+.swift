//
//  TableView+.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 29/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

extension UITableView {
    func avoidScrollOnScrollViewIfNeeded() {
        //This to avoid the scrollView to scroll if the content fit the screen
        if self.contentSize.height < self.frame.size.height {
            self.isScrollEnabled = false
         } else {
            self.isScrollEnabled = true
         }
    }
}
