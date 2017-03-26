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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        // Do view setup here.
    }
    
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        awakeFromNib()
//        self.view.wantsLayer = true
        
        currentQuoteIndex = 0
    }
    
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color : CGColor = CGColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
            self.view.layer?.backgroundColor = color
        }
        
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
        
        

        
//        NSApplication.shared().terminate(sender)
//        self.presenting!.presenting!.dismissViewController(self)
//        self.dismissViewController( self)
    }

    
    @IBAction func goRight(_ sender: NSButton) {
        
        currentQuoteIndex = (currentQuoteIndex + 1) % quotes.count
    }


   
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
