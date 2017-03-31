//
//  ViewController.swift
//  StackFlow
//
//  Created by Huai-Che Lu on 3/22/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import AVKit
import AVFoundation
import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var playerView: AVPlayerView!
    var player: AVPlayer?
    var appDelegate: AppDelegate? {
        return NSApplication.shared().delegate as? AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in 
			let breathe = Bridge.sharedInstance().shouldBreathe()
			if breathe {
				Swift.print("should breathe")
				self.appDelegate?.simulateContextSwitching()
			}
        }

        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.handleBreatheButtonClicked(_:)), name: NotificationBreatheButtonClicked, object: self.appDelegate!)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func enterFullScreen() {
        guard let mainScreenFrame = NSScreen.main()?.frame else { return }
        guard let newWindowFrameRect = self.view.window?.frameRect(forContentRect: mainScreenFrame) else { return }
        self.view.window?.setFrame(newWindowFrameRect, display: true)
    }
    
    func loadVideo() {
        guard let filePath = Bundle.main.path(forResource: "breathe-with-me", ofType: "m4v") else { return }
        player = AVPlayer(url: URL(fileURLWithPath: filePath))
        playerView.player = player
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.itemDidFinishPlaying(_:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
}

// MARK: - Notification Handlers
extension ViewController {
    func itemDidFinishPlaying(_ noitfication: Notification) {
        self.view.window?.orderOut(self)
    }
    
    func handleBreatheButtonClicked(_ noitfication: Notification) {
        self.view.window?.makeKeyAndOrderFront(nil)
        NSApplication.shared().activate(ignoringOtherApps: true)
        enterFullScreen()
        loadVideo()
        player?.play()
    }
}
