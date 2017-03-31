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
    
    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        awakeFromNib()
//        self.view.wantsLayer = true
        
        currentQuoteIndex = 0
        enterFullScreen()
    }
    
    override func awakeFromNib() {
//        if self.view.layer != nil {
//            let color : CGColor = CGColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
//            self.view.layer?.backgroundColor = color
//        }
        
    }
    
    func enterFullScreen() {
        guard let mainScreenFrame = NSScreen.main()?.frame else { return }
        guard let newWindowFrameRect = self.view.window?.frameRect(forContentRect: mainScreenFrame) else { return }
        self.view.window?.setFrame(newWindowFrameRect, display: true)
    }
    
    func updateQuote() {
        //        textLabel.stringValue = toString(quotes[currentQuoteIndex])
        textLabel.stringValue = String(describing: quotes[currentQuoteIndex].text) + "\n" +
        " - " + String(describing: quotes[currentQuoteIndex].author)
    }
    
    @IBAction func goLeft(_ sender: Any) {
        
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count

    }
    
    @IBAction func quit(_ sender: NSButton) {
		let appDelegate = NSApplication.shared().delegate as! AppDelegate
		appDelegate.closePopover(sender: nil)
		

		
//        NSApplication.shared().terminate(sender)
//        self.presenting!.presenting!.dismissViewController(self)
//        self.dismissViewController( self)
    }

    
    @IBAction func goRight(_ sender: NSButton) {
        
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }


   
}

extension QuotesViewController {
    @IBAction func goLeft(sender: NSButton) {
        
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
    }
    
    @IBAction func goRight(sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }
    
    @IBAction func quit(sender: NSButton) {
        NSApplication.shared().terminate(sender)
    }
}
