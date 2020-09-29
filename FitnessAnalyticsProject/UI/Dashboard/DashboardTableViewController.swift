//
//  DashboardTableViewController.swift
//  FitnessAnalyticsProject
//
//  Created by Carlo Carpio on 19/09/2020.
//  Copyright © 2020 Carlo Carpio. All rights reserved.
//

import UIKit
import Charts

class DashboardTableViewController: UITableViewController, ChartViewDelegate {

    // MARK: - IBOutlets
    @IBOutlet private weak var selectionPeriodTableViewCell: PeriodSelectionTableViewCell!
    @IBOutlet private weak var lineChartView: LineChartView!
    @IBOutlet private weak var activitiesTableViewCell: ActivitiesTableViewCell!
    
    // MARK: - Properties
    private let periods = [Period(title: "Week", days: 7),
                           Period(title: "Month", days: 30),
                           Period(title: "6 Months", days: 180),
                           Period(title: "Year", days: 365)]
    
    private let activities = [Activity(training: Training(type: .steps),
                                       statistics: [Statistic(value: 23.4, type: .duration),
                                                    Statistic(value: 22.5, type: .distance),
                                                    Statistic(value: 10.5, type: .velocity),
                                                    Statistic(value: 12000, type: .step),
                                                    Statistic(value: 98.0, type: .heartRate),
                                                    Statistic(value: 354, type: .calorie)]),
                              Activity(training: Training(type: .swimming),
                                       statistics: [Statistic(value: 70.7, type: .duration),
                                                    Statistic(value: 25.2, type: .distance),
                                                    Statistic(value: 18.9, type: .velocity),
                                                    Statistic(value: 0.0, type: .step),
                                                    Statistic(value: 101, type: .heartRate),
                                                    Statistic(value: 145.1, type: .calorie)]),
                              Activity(training: Training(type: .cycling),
                                       statistics: [Statistic(value: 30.5, type: .duration),
                                                    Statistic(value: 340, type: .distance),
                                                    Statistic(value: 8.9, type: .velocity),
                                                    Statistic(value: 0.0, type: .step),
                                                    Statistic(value: 95.0, type: .heartRate),
                                                    Statistic(value: 490.1, type: .calorie)]),
                              Activity(training: Training(type: .running),
                                       statistics: [Statistic(value: 10.6, type: .duration),
                                                    Statistic(value: 12, type: .distance),
                                                    Statistic(value: 10.5, type: .velocity),
                                                    Statistic(value: 7500, type: .step),
                                                    Statistic(value: 89, type: .heartRate),
                                                    Statistic(value: 122, type: .calorie)])]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureSelectionPeriodSection()
        configureActivitiesSection()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.avoidScrollOnScrollViewIfNeeded()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let detailesViewController = segue.destination as? DetailsTableViewController
            else { return }
        detailesViewController.selectedActivity = sender as? Activity
        detailesViewController.dailyActivities = activities
    }
    
    // MARK: - Setup functions
    private func setupViews() {
        
        lineChartView.chartDescription?.enabled = false
        lineChartView.dragEnabled = true
        lineChartView.setScaleEnabled(true)
        lineChartView.pinchZoomEnabled = false
        lineChartView.highlightPerDragEnabled = true
        lineChartView.backgroundColor = .white
        lineChartView.legend.enabled = false
        
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor.black
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 86400
        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 100
        leftAxis.yOffset = -9
        leftAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.legend.form = .line
    
        setDataCount(7, range: 30)
    }
    
    private func configureSelectionPeriodSection() {
        let viewModels: [PeriodCollectionViewCellViewModel] = periods.map({ period in
            return PeriodCollectionViewCellViewModel(title: period.title,
                                                     onTap: {
                                                        self.setDataCount(period.days, range: 30)
            })
        })
        selectionPeriodTableViewCell.configure(periodViewModels: viewModels)
    }
    
    private func configureActivitiesSection() {
        let viewModels: [ActivityCollectionViewCellViewModel] = activities.map({ activity in
            return ActivityCollectionViewCellViewModel(activity: activity,
                                                       onTap: {
                                                        self.performSegue(withIdentifier: "showDetailedActivitiesVC",
                                                                          sender: activity)
            })
        })
        
        activitiesTableViewCell.configure(activityViewModels: viewModels)
    }
    
    private func setupLineChart() {
        lineChartView.delegate = self
        
        var entries = [ChartDataEntry]()
        
        for activity in activities {
            guard
                let duration = activity.statistics.first(where: ({ $0.type == .duration }))?.value,
                let calories = activity.statistics.first(where: ({ $0.type == .calorie }))?.value
                else { return }
            entries.append(ChartDataEntry(x: Double(duration),
                                          y: Double(calories)))
        }
        
        let set = LineChartDataSet(entries: entries)
        let data = LineChartData(dataSet: set)
        lineChartView.data = data
        
        for set in lineChartView.data?.dataSets as! [LineChartDataSet] {
            set.drawCirclesEnabled = false
            set.mode = .cubicBezier
        }
    }
    
    private func setDataCount(_ count: Int, range: UInt32) {
        let now = Date().timeIntervalSince1970
        let hourSeconds: TimeInterval = 3600
        let dayHourSeconds: TimeInterval = 24 * hourSeconds
        
        let from = now - (Double(count) * dayHourSeconds)
        let to = now + 86400
        
        let datasets: [LineChartDataSet] = activities.map({ activity in
            let values: [ChartDataEntry] = stride(from: from, to: to, by: dayHourSeconds).map { x in
                
                guard
                    let duration = activity.statistics.first(where: ({ $0.type == .duration }))?.value
                    else {
                        return ChartDataEntry(x: 0.0, y: 0.0)
                    }
                let y = Double(arc4random_uniform(UInt32(duration)) + 15)
                return ChartDataEntry(x: x, y: Double(y))
            }
            
            let dataset = LineChartDataSet(entries: values, label: "DataSet 1")
            dataset.axisDependency = .left
            dataset.setColor(activity.training.color)
            dataset.lineWidth = 2.5
            dataset.drawCirclesEnabled = false
            dataset.drawValuesEnabled = false
            dataset.fillAlpha = 0.26
            dataset.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
            dataset.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
            dataset.drawCircleHoleEnabled = false
            dataset.mode = .cubicBezier
            
            return dataset
        })
        
        let data = LineChartData(dataSets: datasets)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        lineChartView.data = data
        lineChartView.animate(xAxisDuration: 0.2)
    }
}


