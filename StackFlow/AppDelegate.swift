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
//    var prompted_flow: Bool 
    var timer = 60

    

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        setUpMenu()
        popover.contentViewController = PopupViewController(nibName: "PopupViewController", bundle: nil)
        setUpEventMonitor()
        
        // TODO: Hack to hide window at launch time
        NSApplication.shared().windows.last!.close()
        
        _ = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(AppDelegate.countdown), userInfo: nil, repeats: true)
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
        
//        statusItem.menu = menu
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            button.action = #selector(AppDelegate.togglePopover(sender:))
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
    
    func countdown(){
        
        if timer == 60 {
            triggerFlow()
        }
        // Create a timer
        else if timer == 0 {
            triggerFlow()
            timer = 60
        }
//
        timer -= 1
        
    }
    
  
    
    func triggerFlow(){
        let flow_boolean = Bridge.sharedInstance().findFlowTime()
        print("flow_boolean: " , flow_boolean)
        if flow_boolean == true {
            simulateInitiateFlow()
        }
        else {
            print("there are no flow periods right now")
        }
    }
    
    
    @IBAction func initiateFlow(_ sender: Any) {
        simulateInitiateFlow()
    }
    
   
    func simulateInitiateFlow() {
        print(Bridge.sharedInstance().findFlowTime())
        UserNotificationManager.sharedInstance.sendInitiateFlowUserNotification(forMaxMinutes: 90) { notification in
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

