//
//  ChatBubble.swift
//  ChatBubbleScratch
//
//  Created by Sauvik Dolui on 02/09/15.
//  Copyright (c) 2015 Innofied Solution Pvt. Ltd. All rights reserved.
//

import UIKit

struct ScreenSize {

    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

class ChatBubble: UIView {

    var imageViewChat: UIImageView?
    var imageViewBG: UIImageView?
    var text: String?
    var labelChatText: UILabel?
    
    /**
    Initializes a chat bubble view
    
    :param: data   ChatBubble Data
    :param: startY origin.y of the chat bubble frame in parent view
    
    :returns: Chat Bubble
    */
    init(data: ChatBubbleData, startY: CGFloat) {
        
        // Initializing parent view with calculated frame.
        super.init(frame: ChatBubble.framePrimary(data.type, startY:startY))
        
        // Making Background transparent.
        self.backgroundColor = UIColor.clear
        
        let padding: CGFloat = 10.0
        
        // Drawing image if any.
        if let chatImage = data.image {
            
            let width: CGFloat = min(chatImage.size.width, self.frame.width - 2 * padding)
            let height: CGFloat = chatImage.size.height * (width / chatImage.size.width)
            imageViewChat = UIImageView(frame: CGRect(x: padding, y: padding, width: width, height: height))
            imageViewChat?.image = chatImage
            imageViewChat?.layer.cornerRadius = 5.0
            imageViewChat?.layer.masksToBounds = true
            
            self.addSubview(imageViewChat!)
        }
        
        // Going to add Text if any.
        if data.text != nil {
            
            // frame calculation
            let startX = padding
            var startY:CGFloat = 5.0
            
            if imageViewChat != nil {
                startY += imageViewChat!.frame.maxY
            }
            
            labelChatText = UILabel(frame: CGRect(x: startX, y: startY, width: self.frame.width - 2 * startX , height: 5))
            labelChatText?.textAlignment = data.type == .mine ? .right : .left
            labelChatText?.font = UIFont.systemFont(ofSize: 16)
            labelChatText?.numberOfLines = 0 // Making it multiline
            labelChatText?.text = data.text
			labelChatText?.textColor = data.type == .mine ? UIColor.white : UIColor.black
            labelChatText?.sizeToFit() // Getting fullsize of it
            
            self.addSubview(labelChatText!)
        }
        
        // Calculation of new width and height of the chat bubble view.
        var viewHeight: CGFloat = 0.0
        var viewWidth: CGFloat = 0.0
        
        if imageViewChat != nil {
            
            // Height calculation of the parent view depending upon the image view and text label.
            viewWidth = max(imageViewChat!.frame.maxX, labelChatText!.frame.maxX) + padding
            viewHeight = max(imageViewChat!.frame.maxY, labelChatText!.frame.maxY) + padding

        } else {
            
            viewHeight = labelChatText!.frame.maxY + padding/2
            viewWidth = labelChatText!.frame.width + labelChatText!.frame.minX + padding
        }
        
        // Adding new width and height of the chat bubble frame.
        self.frame = CGRect(x: self.frame.minX, y: self.frame.minY, width: viewWidth, height: viewHeight)
        
        // Adding the resizable image view to give it bubble like shape.
        let bubbleImageFileName = data.type == .mine ? "bubble_mine" : "bubble_other"
        imageViewBG = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height))
        
        if data.type == .mine {
            imageViewBG?.image = UIImage(named: bubbleImageFileName)?.resizableImage(withCapInsets: UIEdgeInsetsMake(14, 14, 17, 28))
        } else {
            imageViewBG?.image = UIImage(named: bubbleImageFileName)?.resizableImage(withCapInsets: UIEdgeInsetsMake(14, 22, 17, 20))
        }
        
        self.addSubview(imageViewBG!)
        self.sendSubview(toBack: imageViewBG!)
        
        // Frame recalculation for filling up the bubble with background bubble image.
        let repsotionXFactor:CGFloat = data.type == .mine ? 0.0 : -8.0
        let bgImageNewX = imageViewBG!.frame.minX + repsotionXFactor
        let bgImageNewWidth =  imageViewBG!.frame.width + CGFloat(12.0)
        let bgImageNewHeight =  imageViewBG!.frame.height + CGFloat(6.0)
        imageViewBG?.frame = CGRect(x: bgImageNewX, y: 0.0, width: bgImageNewWidth, height: bgImageNewHeight)

        //
        // Keep a minimum distance from the edge of the screen.
        //
        
        var newStartX: CGFloat = 0.0
        
        if data.type == .mine {
            
            // Need to maintain the minimum right side padding from the right edge of the screen.
            let extraWidthToConsider = imageViewBG!.frame.width + 10.0
            newStartX = ScreenSize.SCREEN_WIDTH - extraWidthToConsider
            
        } else {
            
            // Need to maintain the minimum left side padding from the left edge of the screen.
            newStartX = -imageViewBG!.frame.minX + 10.0
        }
        
        self.frame = CGRect(x: newStartX, y: self.frame.minY, width: frame.width, height: frame.height)
    }

    required init(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    class func framePrimary(_ type: ChatBubbleOwner, startY: CGFloat) -> CGRect {
        
        let paddingFactor: CGFloat = 0.02
        let sidePadding = ScreenSize.SCREEN_WIDTH * paddingFactor
        let maxWidth = ScreenSize.SCREEN_WIDTH * 0.65 // We are cosidering 65% of the screen width as the Maximum with of a single bubble.
        let startX: CGFloat = type == .mine ? ScreenSize.SCREEN_WIDTH * (CGFloat(1.0) - paddingFactor) - maxWidth : sidePadding
        
        return CGRect(x: startX, y: startY, width: maxWidth, height: 5) // 5 is the primary height before drawing starts.
    }
}
