//
//  QuotesViewController2.swift
//  StackFlow
//
//  Created by Claire Opila on 3/25/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {
    
   
    @IBOutlet var textLabel: NSTextField!
    
    @IBOutlet weak var image_view: NSImageView!
    
    @IBOutlet weak var leftButton: NSButton!
    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        leftButton.wantsLayer = true
        leftButton.layer?.isOpaque = false
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        awakeFromNib()
        
        currentQuoteIndex = 0
        enterFullScreen()
    }
    
    func enterFullScreen() {
        guard let mainScreenFrame = NSScreen.main()?.frame else { return }
        guard let newWindowFrameRect = self.view.window?.frameRect(forContentRect: mainScreenFrame) else { return }
        self.view.window?.setFrame(newWindowFrameRect, display: true)
    }
    
    func updateQuote() {
        textLabel.stringValue = String(describing: quotes[currentQuoteIndex].text) + "\n" +
        " - " + String(describing: quotes[currentQuoteIndex].author)
    }
    
    @IBAction func goLeft(_ sender: Any) {
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
    }
    
    @IBAction func goRight(_ sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }
    
    @IBAction func quit(_ sender: NSButton) {
		let appDelegate = NSApplication.shared().delegate as! AppDelegate
		appDelegate.closePopover(sender: nil)
    }
}
