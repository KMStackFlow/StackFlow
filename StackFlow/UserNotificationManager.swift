//
//  NotificationManager.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 3/30/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Cocoa

let ContextSwitchingNotificationBreatheButtonClicked: Notification.Name = Notification.Name(rawValue: "com.keymochi.stackflow.context-switching-breathe")
let InitialFlowTimeNotificationButtonClicked: Notification.Name = Notification.Name(rawValue: "com.keymochi.stackflow.initial-flow-time")

public class NotificationManager {
    static private var instance: NotificationManager!
    
    static var sharedInstance: NotificationManager {
        return instance!
    }
    
    static func setSharedInstance(to: NotificationManager?) {
        instance = to
    }
    
    public func sendContextSwitchingNotification() {
        
    }
}
