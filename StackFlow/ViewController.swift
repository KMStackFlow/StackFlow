//
//  ViewController.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 3/22/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let pythonMessage = Bridge.sharedInstance().getPythonInformation()
        Swift.print("Info from python:\n\(pythonMessage)")
        
        let a = 1, b = 2
        Swift.print("\(a) + \(b) = \(Bridge.sharedInstance().add(a: 1, b: 2))")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

