//
//  ValueFormatter.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 20/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import Foundation
import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "MM/dd"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
