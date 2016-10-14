//
//  ChatBubbleData.swift
//  ChatBubble
//
//  Created by Sauvik Dolui on 8/21/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit

enum ChatBubbleOwner: Int {
    
    case mine = 0
    case other
}

// Data model for maintaining the message data for a single chat bubble.
class ChatBubbleData {
    
    var text: String?
    var image: UIImage?
    var date: Date?
    var type: ChatBubbleOwner
    
    init(text: String?, image: UIImage?, date: Date?, type: ChatBubbleOwner = .mine) {

        self.text = text
        self.image = image
        self.date = date
        self.type = type
    }
}
