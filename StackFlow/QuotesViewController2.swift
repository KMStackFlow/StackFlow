//
//  QuotesViewController2.swift
//  StackFlow
//
//  Created by Claire Opila on 3/25/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Cocoa

class QuotesViewController2: NSViewController {
    
    @IBOutlet var textLabel: NSTextField!
    
    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
            
        }
    }
    
    
    override func viewWillAppear() {
                super.viewWillAppear()
        
        currentQuoteIndex = 0
    }
    
    func updateQuote() {
        //        textLabel.stringValue = toString(quotes[currentQuoteIndex])
        textLabel.stringValue = String(describing: quotes[currentQuoteIndex])
    }
    
    @IBAction func goLeft(_ sender: Any) {
        
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count

    }
    
    @IBAction func quit(_ sender: NSButton) {
        
        

        
//        NSApplication.shared().terminate(sender)
//        self.presenting!.presenting!.dismissViewController(self)
//        self.dismissViewController( self)
    }

    
    @IBAction func goRight(_ sender: NSButton) {
        
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }


//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do view setup here.
//    }
    
}

extension QuotesViewController2 {
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
