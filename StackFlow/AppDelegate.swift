//
//  AppDelegate.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 3/22/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Cocoa


class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Quit StackFlow", action: #selector(AppDelegate.terminate(sender:)), keyEquivalent: "q"))
        statusItem.menu = menu
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func terminate(sender: NSButton) {
        NSApplication.shared().terminate(sender)
    }
}

