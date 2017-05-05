//
//  PopupViewController.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 5/4/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import AppKit
import Charts
import DynamicColor

class PopupViewController: NSViewController {
    
    let settingsMenu = NSMenu()
    
    var appDelegate: AppDelegate? {
        return NSApplication.shared().delegate as? AppDelegate
    }
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var stackView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true
        self.view.layer!.backgroundColor = DynamicColor(hex: 0xFCFAF2).cgColor
        
        settingsMenu.addItem(NSMenuItem(title: "Simulate Context Switching", action: #selector(PopupViewController.simulateContextSwitching), keyEquivalent: "C"))
        settingsMenu.addItem(NSMenuItem(title: "Simulate Initiate Flow", action: #selector(PopupViewController.simulateInitiateFlow), keyEquivalent: "F"))
        
        settingsMenu.addItem(NSMenuItem(title: "End My Day", action: #selector(PopupViewController.endMyDay), keyEquivalent: "E"))
        
        settingsMenu.addItem(NSMenuItem(title: "Quit", action: #selector(PopupViewController.quit(_:)), keyEquivalent: "Q"))
        
        let pieChartEntries = [
            PieChartDataEntry(value: 70.0, label: "Productive"),
            PieChartDataEntry(value: 20.0, label: "Distracted")
        ]
        let pieChartDataSet = PieChartDataSet(values: pieChartEntries, label: "")
        pieChartDataSet.colors = [DynamicColor(hex: 0xF05E1C), DynamicColor(hex: 0xE8B647)]
        pieChartDataSet.valueColors = [DynamicColor(hex: 0x434343)]
        pieChartDataSet.entryLabelColor = DynamicColor(hex: 0x434343)
        pieChartView.data = PieChartData(dataSets: [pieChartDataSet])
        
        pieChartView.legend.formSize = 0.0
		pieChartView.legend.enabled = false
		pieChartView.chartDescription?.text = ""
        
        let stackViewWidth = stackView.bounds.size.width
        let stackViewHeight = stackView.bounds.size.height
//        for i in 0..<5 {
//            let y = stackViewHeight / 5.0 * CGFloat(i)
//            let stackEntryView = NSTextView(frame: CGRect(x: 0.0, y: y, width: stackViewWidth, height: stackViewHeight / 5.0))
//            stackEntryView.isEditable = false
//            stackEntryView.isSelectable = false
//            stackEntryView.string = "Safari"
//            stackView.addSubview(stackEntryView)
//        }
    }
    
    func createStack( stack_list: NSArray){
        if stackView != nil {
            for subView in stackView.subviews {
                subView.removeFromSuperview()
            }
            
            let stackViewWidth = stackView.bounds.size.width
            let stackViewHeight = stackView.bounds.size.height
            print("stack list is: " , stack_list)
            let new_stack_list = stack_list.reversed()
            for i in 0..<5 {
                
                let y = stackViewHeight / 5.0 * CGFloat(5 - i)
                let stackEntryView = NSTextView(frame: CGRect(x: 0.0, y: y, width: stackViewWidth, height: stackViewHeight / 5.0))
                stackEntryView.isEditable = false
                stackEntryView.isSelectable = false
                if new_stack_list.count > i {
                    let progamName = new_stack_list[i] as! String
                    if !progamName.hasPrefix("StackFlow") {
                        stackEntryView.string = progamName
                        stackView.addSubview(stackEntryView)
                    }
                    
                }
                
            }
           
        }

        
    }
    
    @IBAction func startFlowTime(_ sender: Any) {
        print("start flow time")
        appDelegate?.simulateInitiateFlow()
    }
    
    @IBAction func toggleSettings(_ sender: Any) {
        print("toggle settings")
        let width = self.view.bounds.size.width
        let height = self.view.bounds.size.height
        self.settingsMenu.popUp(positioning: self.settingsMenu.items[0], at: NSPoint(x: width - 15.0, y: height - 30.0), in: self.view)
    }
    
}

// MARK: - Settings Menu Item Actions
extension PopupViewController {
    func quit(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    
    func simulateContextSwitching(_ sender: Any) {
        appDelegate?.simulateContextSwitching()
    }
    
    func simulateInitiateFlow(_ sender: Any) {
        appDelegate?.simulateInitiateFlow()
    }
    
    func endMyDay(_ sender: Any) {
        appDelegate?.endMyDay(sender: self)
    }
}
