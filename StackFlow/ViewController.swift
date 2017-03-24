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
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.handleBreatheButtonClicked(_:)), name: NotificationBreatheButtonClicked, object: self.appDelegate!)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func loadVideo() {
        guard let filePath = Bundle.main.path(forResource: "breathe-with-me", ofType: "m4v") else { return }
        player = AVPlayer(url: URL(fileURLWithPath: filePath))
        playerView.player = player
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.itemDidFinishPlaying(_:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    
    func itemDidFinishPlaying(_ noitfication: Notification) {
        self.view.window?.orderOut(self)
    }
    
    func handleBreatheButtonClicked(_ noitfication: Notification) {
        self.view.window?.makeKeyAndOrderFront(nil)
        NSApplication.shared().activate(ignoringOtherApps: true)
        loadVideo()
        player?.play()
    }
}
