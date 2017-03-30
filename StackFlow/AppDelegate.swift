//
//  AppDelegate.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 3/22/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Cocoa

let NotificationBreatheButtonClicked: Notification.Name = Notification.Name(rawValue: "com.keymochi.stackflow.breath-button-clicked")

class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    let notificationCenter = NSUserNotificationCenter.default
    let popover = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Send Notification", action: #selector(AppDelegate.sendNotification), keyEquivalent: "s"))
        menu.addItem(NSMenuItem(title: "Quit StackFlow", action: #selector(AppDelegate.terminate(sender:)), keyEquivalent: "q"))
        menu.addItem(NSMenuItem(title: "Inspiration", action: #selector(AppDelegate.togglePopover), keyEquivalent: "i"))
		menu.addItem(NSMenuItem(title: "End My Day", action: #selector(AppDelegate.endMyDay), keyEquivalent: "e"))
        
        statusItem.menu = menu
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
        }
        
    
       
        popover.contentViewController = QuotesViewController(nibName: "QuotesViewController", bundle: nil)
        
        
                notificationCenter.delegate = self
        
        // TODO: Hack to hide window at launch time
    
        NSApplication.shared().windows.last!.close()
        

        eventMonitor = EventMonitor(mask: [NSEventMask.leftMouseDown, NSEventMask.rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(sender: event)
            }
        }
        eventMonitor?.start()
        
    }
    
    
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func sendNotification() {
        let notification = NSUserNotification()
        notification.title = "StackFlow"
        notification.informativeText = "You've been context switching a lot..."
        notification.soundName = NSUserNotificationDefaultSoundName
        notification.actionButtonTitle = "Breathe"
        notification.hasActionButton = true
        
        notificationCenter.deliver(notification)
    }

    func terminate(sender: NSButton) {
        NSApplication.shared().terminate(sender)
    }
    
    // Visualization pop up
    
    func dataPopUp(){
        print("Productivity Data Requested")
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func togglePopover(sender: AnyObject?) {
        print ("in Toggle Popeover")
        if popover.isShown {
//            closePopover(sender:  anyObject?)
            closePopover(sender: NSObject.self)
        } else {
            showPopover(sender: NSObject.self)
        }
    }
	
	func endMyDay(sender: AnyObject?) {
		print("end my day")
		popover.contentViewController = EndMyDayViewController(nibName: "EndMyDayViewController", bundle: nil)
		if let button = statusItem.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
		}
	}
    

}

// MARK: - NSUserNotificationCenterDelegate
extension AppDelegate: NSUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {
        print("Notification delivered: \(notification)")
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        print("Notification activated: \(notification)")
        switch notification.activationType {
        case .additionalActionClicked:
            print("Additional Action Clicked")
        case .actionButtonClicked:
            print("Action Button Clicked")
            handleBreathe()
        case .contentsClicked:
            print("Contents Clicked")
        case .replied:
            print("Replided")
        case .none:
            print("None")
        }
    }
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}

// MARK: - Notification Action Handlers
extension AppDelegate {
    func handleBreathe() {
        print("Breathe!")
        NotificationCenter.default.post(name: NotificationBreatheButtonClicked, object: self)
    }
}

