//
//  Quote.swift
//  StackFlow
//
//  Created by Claire Opila on 3/25/17.
//  Copyright © 2017 Keymochi. All rights reserved.
//

import Foundation

struct Quote {
    let text: String
    let author: String
    
    static let all: [Quote] = [
        Quote(text: " Whether you think you can, or you think you can’t – you’re right.", author: "Henry Ford"),
        Quote(text: "I know not all that may be coming, but be it what it will, I’ll go to it laughing.", author: "Herman Melville"),
        Quote(text: "The sun himself is weak when he first rises, and gathers strength and courage as the day gets on.", author: "Charles Dickens"),
        Quote(text: "How wonderful it is that nobody need wait a single moment before starting to improve the world.", author: "Anne Frank"),
        Quote(text: "Simplicity is the ultimate sophistication", author: "Leonardo da Vinci"),
        Quote(text: "It’s not just what it looks like and feels like. Design is how it works.", author: "Steve Jobs"),
        Quote(text: "Oh yes, the past can hurt. But you can either run from it, or learn from it.", author:"Rafiki")
    ]
}

// MARK: - Printable

//extension Quote: Printable {
//    var description: String {
//        return "\"\(text)\" — \(author)"
//    }
//}

