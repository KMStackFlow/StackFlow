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

        
        let a = 1
        let b = 2
        
        // Do any additional setup after loading the view.
        let pythonMessage = Bridge.sharedInstance().getPythonInformation()
        Swift.print("Info from python:\n\(pythonMessage)")
        
        Bridge.sharedInstance().echo!(a: 3, b: 4)
        Swift.print("\(a) + \(b) = \(Bridge.sharedInstance().doSomething!(argumentOne: a, argumentTwo: b))")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

