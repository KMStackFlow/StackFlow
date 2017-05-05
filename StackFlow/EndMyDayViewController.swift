//
//  EndMyDayViewController.swift
//  StackFlow
//
//  Created by HsiaoChing Lin on 3/30/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Cocoa
import Charts
import DynamicColor

class EndMyDayViewController: NSViewController {
	
	@IBOutlet var barChartView: BarChartView!
	@IBOutlet weak var pieChartView: PieChartView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let (hours, productiveMinutes) = getProductivityData()
		let yse1 = zip(hours, productiveMinutes).map { BarChartDataEntry(x: Double($0.0), y: Double($0.1)) }
		
		let data = BarChartData()
		let ds1 = BarChartDataSet(values: yse1, label: "Productive Time")
		ds1.colors = [DynamicColor(hex: 0xF05E1C)]
		data.addDataSet(ds1)
		
		barChartView.data = data
		
		barChartView.gridBackgroundColor =
			DynamicColor(hex: 0xFCFAF2)
		
		barChartView.chartDescription?.text = "Productivity"
		barChartView.chartDescription?.textColor = DynamicColor(hex: 0x434343)
		barChartView.xAxis.axisMaximum = Double(hours.max()!)
		barChartView.xAxis.axisMinimum = Double(hours.min()!)
		barChartView.xAxis.labelCount = hours.max()! - hours.min()!
		
		
		let pieChartData = [
			("Sublime Text", 75),
			("stackoverflow.com", 23),
			("github.com", 12),
			("amazon.com", 20),
			("Terminal", 24),
			("Slack", 49)
		]
		
		let pieChartEntries = pieChartData.map {
			PieChartDataEntry(value: Double($0.1), label: $0.0)
		}
			
		let pieChartDataSet = PieChartDataSet(values: pieChartEntries, label: "")
		pieChartDataSet.colors = [DynamicColor(hex: 0xF05E1C), DynamicColor(hex: 0xE8B647)]
		pieChartDataSet.valueColors = [DynamicColor(hex: 0x434343)]
		pieChartDataSet.entryLabelColor = DynamicColor(hex: 0x434343)
		pieChartView.data = PieChartData(dataSets: [pieChartDataSet])
		pieChartView.chartDescription?.text = ""
		pieChartView.legend.formSize = 0.0
		pieChartView.legend.enabled = false
	}
	
	func getProductivityData() -> (Array<Int>, Array<Int>) {
		let productivityData = Bridge.sharedInstance().aggregateByHour()
		if let data = productivityData.data(using: String.Encoding.utf8) {
			do {
				let json_productivity = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:Int]
				
				let hoursStr = Array(json_productivity.keys)
				let hours = hoursStr.map { Int($0)! }
				let productiveMinutesStr = Array(json_productivity.values)
				let productiveMinutes = productiveMinutesStr.map { Int($0) }
				return (hours, productiveMinutes)
			} catch {
				print("Something went wrong")
			}
		}
		return ([Int](), [Int]())
	}
	
	override func viewWillAppear()
	{
		self.barChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
	}
	
}
