//
//  Activity.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 19/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit

enum StatisticType {
    case distance
    case velocity
    case calorie
    case duration
    case heartRate
    case step
}

struct Statistic {
    var value: Float
    var type: StatisticType
    var unitOfMeasurement: String {
        switch type {
        case .distance:
            return UnitLength.kilometers.symbol
        case .duration:
            return UnitDuration.minutes.symbol
        case .velocity:
            return UnitSpeed.kilometersPerHour.symbol
        case .calorie:
            return UnitEnergy.kilocalories.symbol
        case .heartRate:
            return "Bpm"
        default:
            return ""
        }
    }
}

enum TrainingType {
    case steps
    case swimming
    case cycling
    case running
}

struct Training {
    var type: TrainingType
    var icon: UIImage?
    
    var name: String {
        switch type {
        case .steps:
            return "Steps"
        case .swimming:
            return "Swimming"
        case .cycling:
            return "Cycling"
        case .running:
            return "Running"
        }
    }
    
    var color: UIColor {
        switch type {
        case .steps:
            return ColorManager.slateBlue
        case .swimming:
            return ColorManager.razzmatazz
        case .cycling:
            return ColorManager.tangerine
        case .running:
            return ColorManager.vistaBlue
        }
    }
    
    init(type: TrainingType, icon: UIImage? = nil) {
        self.type = type
        self.icon = icon
    }
}

struct Period {
    let title: String
    let days: Int
}

struct Activity {
    var training: Training
    var statistics: [Statistic]
}
