//
//  BridgeInterface.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 3/22/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Foundation

import Foundation

/// A simple demonstration interface to the python module
@objc public protocol BridgeInterface {
    static func createInstance() -> BridgeInterface
    func getPythonInformation() -> String
    func add(a: Int, b: Int) -> Int
	func isContextSwitching() -> Bool
	func moniterWindowChange()
}

/// A simple class for access to an instance of the python interface
class Bridge {
    static private var instance : BridgeInterface?
	
    static func sharedInstance() -> BridgeInterface {
        return instance!
    }
    static func setSharedInstance(to: BridgeInterface?) {
        instance = to
    }
}
