//
//  MyTableViewCell.swift
//  CustomCellDelegate
//
//  Created by Kevin Harris on 9/15/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

// We will use a protocol to create our own custom delegate that will allow other
// classes to receive event notifications from MyTableViewCell.
protocol MyTableViewCellDelegate {
    
    func didTapEmail(email: String)
}

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var websiteBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    
    var websiteUrl: String?
    var emailAddress: String?
    
    
    // Since our MyTableViewCellDelegate is designed to be used with MyTableViewCell
    // we should declare a var of the delegate type so other classes can set or assign
    // themselves as a recipient of the event calls.
    var delegate: MyTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func loadWebsite(sender: UIButton) {
        
        // Since MyTableViewCell can safely call openURL() - we'll just do it here.
        if let url = NSURL(string: websiteUrl!) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    @IBAction func createEmail(sender: UIButton) {
        
        // Since MyTableViewCell CAN NOT call presentViewController() which is
        // required to launch MFMailComposeViewController, we will need to 
        // notify someone else about this event and hope that they will handle
        // it for us.
        
        // If someone has implemented our MyTableViewCellDelegate - call them
        // and let them know that the email button was tapped.
        
        delegate?.didTapEmail(emailAddress!)
    }
}
