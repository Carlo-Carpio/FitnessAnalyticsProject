//
//  DetailsTableViewController.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 21/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit
import Charts

class DetailsTableViewController: UITableViewController, ChartViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var barChartView: BarChartView!
    @IBOutlet private weak var statisticsTableViewCell: StatisticsTableViewCell!
    @IBOutlet private weak var detailedActivitiesTableViewCell: DetailedActivitiesTableViewCell!
    
    // MARK: - Properties
    var selectedActivity: Activity!
    var dailyActivities: [Activity]!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupStatisticsSection()
        setupDetailedSection()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.avoidScrollOnScrollViewIfNeeded()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: - Setup fuctions
    
    private func setupViews() {
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        
        barChartView.maxVisibleCount = 60
        
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor.black
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 1
        
        setDataCount(7, range: 30)
    }
    
    private func setDataCount(_ count: Int, range: UInt32) {
        
        let groupSpace = 0.08
        let barSpace = 0.03
        let barWidth = 0.2
        
        guard
            let swimmingActivity = dailyActivities.first(where: ({ $0.training.type == .swimming})),
            let runningActivity = dailyActivities.first(where: ({ $0.training.type == .running})),
            let stepsActivity = dailyActivities.first(where: ({ $0.training.type == .steps})),
            let cyclingActivity = dailyActivities.first(where: ({ $0.training.type == .cycling}))
        else { return }
        
        let swimmingActivityValues: [BarChartDataEntry] = stride(from: 0, to: 23, by: 1).map { x in
            
            guard
                let velocity = swimmingActivity.statistics.first(where: ({ $0.type == .velocity}))?.value
                else {
                    return BarChartDataEntry(x: 0.0, y: 0.0)
                }
            let y = Double(arc4random_uniform(UInt32(velocity)) + 15)
            return BarChartDataEntry(x: Double(x), y: Double(y))
        }
        
        let runningActivityValues: [BarChartDataEntry] = stride(from: 0, to: 23, by: 1).map { x in
            
            guard
                let velocity = runningActivity.statistics.first(where: ({ $0.type == .velocity}))?.value
                else {
                    return BarChartDataEntry(x: 0.0, y: 0.0)
                }
            let y = Double(arc4random_uniform(UInt32(velocity)) + 15)
            return BarChartDataEntry(x: Double(x), y: Double(y))
        }
        
        let stepsActivityValues: [BarChartDataEntry] = stride(from: 0, to: 23, by: 1).map { x in
            
            guard
                let velocity = stepsActivity.statistics.first(where: ({ $0.type == .velocity}))?.value
                else {
                    return BarChartDataEntry(x: 0.0, y: 0.0)
                }
            let y = Double(arc4random_uniform(UInt32(velocity)) + 15)
            return BarChartDataEntry(x: Double(x), y: Double(y))
        }
        
        let cyclingActivityValues: [BarChartDataEntry] = stride(from: 0, to: 23, by: 1).map { x in
            
            guard
                let duration = cyclingActivity.statistics.first(where: ({ $0.type == .velocity}))?.value
                else {
                    return BarChartDataEntry(x: 0.0, y: 0.0)
                }
            let y = Double(arc4random_uniform(UInt32(duration)) + 15)
            return BarChartDataEntry(x: Double(x), y: Double(y))
        }
        
        let set1 = BarChartDataSet(entries: stepsActivityValues, label: "Step")
        set1.setColor(stepsActivity.training.color)
        
        let set2 = BarChartDataSet(entries: swimmingActivityValues, label: "Swimming")
        set2.setColor(swimmingActivity.training.color)
        
        let set3 = BarChartDataSet(entries: cyclingActivityValues, label: "Cycling")
        set3.setColor(cyclingActivity.training.color)
        
        let set4 = BarChartDataSet(entries: runningActivityValues, label: "Running")
        set4.setColor(runningActivity.training.color)
        
        let data = BarChartData(dataSets: [set1, set2, set3, set4])
        data.barWidth = barWidth
        
        barChartView.xAxis.axisMinimum = 0
        barChartView.xAxis.axisMaximum = 23
        
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        barChartView.data = data
    }
    
    private func setupBarChartView() {
        
    }
    
    private func setupStatisticsSection() {
        
        guard
            let distanceStatistic = selectedActivity.statistics.first(where: ({ $0.type == .distance})),
            let durationStatistic = selectedActivity.statistics.first(where: ({ $0.type == .duration})),
            let caloriesStatistic = selectedActivity.statistics.first(where: ({ $0.type == .calorie})),
            let speedStatistic = selectedActivity.statistics.first(where: ({ $0.type == .velocity}))
            else { return }
        
        let distanceViewModel = StatisticCollectionViewCellViewModel(icon: nil,
                                                                     title: "Distance",
                                                                     statistic: distanceStatistic)
        
        let durationViewModel = StatisticCollectionViewCellViewModel(icon: nil,
                                                                     title: "Duration",
                                                                     statistic: durationStatistic)
        
        let caloriesViewModel = StatisticCollectionViewCellViewModel(icon: nil,
                                                                     title: "Calories",
                                                                     statistic: caloriesStatistic)
        
        let speedViewModel = StatisticCollectionViewCellViewModel(icon: nil,
                                                                  title: "Speed",
                                                                  statistic: speedStatistic)
        
        statisticsTableViewCell.configure(viewModels: [distanceViewModel,
                                                       durationViewModel,
                                                       caloriesViewModel,
                                                       speedViewModel])
    }
    
    private func setupDetailedSection() {
        
        let dailyActivityViewModels: [DetailedActivityCollectionViewCellViewModel] = dailyActivities.map({ activity in
            
            guard
                let distanceStatistic = activity.statistics.first(where: ({ $0.type == .distance})),
                let caloriesStatistic = activity.statistics.first(where: ({ $0.type == .calorie})),
                let speedStatistic = activity.statistics.first(where: ({ $0.type == .velocity})),
                let heartRateStatistic = activity.statistics.first(where: ({ $0.type == .heartRate}))
            else {
                return DetailedActivityCollectionViewCellViewModel()
            }
            
            return DetailedActivityCollectionViewCellViewModel(title: activity.training.name,
                                                               contentTitle: "Distance",
                                                               contentValue: "\(distanceStatistic.value) \(distanceStatistic.unitOfMeasurement)",
                                                               icon: nil,
                                                               caloriesBurnt: caloriesStatistic.value,
                                                               heartRate: heartRateStatistic.value,
                                                               speed: speedStatistic.value,
                                                               training: activity.training,
                                                               onTap: {
                                                                self.selectedActivity = activity
                                                                self.setupStatisticsSection()
                                                               })
        })
        
        detailedActivitiesTableViewCell.configure(detailedActivityViewModels: dailyActivityViewModels)
    }
}
