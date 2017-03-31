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
    let popover = NSPopover()
    var eventMonitor: EventMonitor?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        setUpMenu()
        popover.contentViewController = QuotesViewController(nibName: "QuotesViewController", bundle: nil)
        setUpEventMonitor()
        
        // TODO: Hack to hide window at launch time
        NSApplication.shared().windows.last!.close()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    private func setUpMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Inspiration", action: #selector(AppDelegate.togglePopover), keyEquivalent: "i"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Simulate Context Switching", action: #selector(AppDelegate.simulateContextSwitching), keyEquivalent: "c"))
        menu.addItem(NSMenuItem(title: "Simulate Initiate Flow", action: #selector(AppDelegate.simulateInitiateFlow), keyEquivalent: "f"))
        menu.addItem(NSMenuItem.separator())
		menu.addItem(NSMenuItem(title: "End My Day", action: #selector(AppDelegate.endMyDay), keyEquivalent: "e"))
        menu.addItem(NSMenuItem(title: "Quit StackFlow", action: #selector(AppDelegate.terminate(sender:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
        }
        
    }
    
    private func setUpEventMonitor() {
        eventMonitor = EventMonitor(mask: [NSEventMask.leftMouseDown, NSEventMask.rightMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(sender: event)
            }
        }
        eventMonitor?.start()
    }
    
    func simulateContextSwitching() {
        UserNotificationManager.sharedInstance.sendContextSwitchingUserNotification { notification in
            NotificationCenter.default.post(name: NotificationBreatheButtonClicked, object: self)
        }
    }
    
    func simulateInitiateFlow() {
        UserNotificationManager.sharedInstance.sendInitiateFlowUserNotification(forMaxMinutes: 120) { notification in
            print("Initial Flow!")
			if let button = self.statusItem.button {
				button.image = NSImage(named: "StatusBarButtonImageFlow")
			}
        }
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
            closePopover(sender: NSObject.self)
        } else {
            showPopover(sender: NSObject.self)
        }
    }
	
	func showQuote(sender: AnyObject?) {
		print("show quote VC")
		popover.contentViewController = QuotesViewController(nibName: "QuotesViewController", bundle: nil)
		if let button = statusItem.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
			eventMonitor?.start()
		}
	}
	
	func endMyDay(sender: AnyObject?) {
		print("end my day")
		popover.contentViewController = EndMyDayViewController(nibName: "EndMyDayViewController", bundle: nil)
		popover.contentSize = NSSize(width: 868, height: 452)
		if let button = statusItem.button {
			popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
			eventMonitor?.start()
		}
	}
}

