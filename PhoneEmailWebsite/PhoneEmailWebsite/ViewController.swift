//
//  ViewController.swift
//  PhoneEmailWebsite
//
//  Created by Kevin Harris on 9/13/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func callPhoneNumber(sender: UIButton) {
        
        if let url = NSURL(string: "tel://8042221111") {

            let alertController = UIAlertController(title: "Place Call",
                                                    message: "Do you wish to call (804) 222-1111 now?",
                                                    preferredStyle: .Alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            
            let cancelAction = UIAlertAction(title: "Call", style: .Default) { action in
                
                UIApplication.sharedApplication().openURL(url)
            }
            
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            print("Failed to convert phone number to NSURL")
        }
    }

    @IBAction func createEmail(sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients(["info@guildsa.org"])
            mailComposerVC.setSubject("My Subject...")
            mailComposerVC.setMessageBody("Here's my email! Blah Blah Blah.", isHTML: false)
            
            self.presentViewController(mailComposerVC, animated: true, completion: nil)
            
        } else {
            
            let alertController = UIAlertController(title: "Could Not Send Email",
                                                    message: "Your device is not configured to send e-mail. Please check e-mail configuration and try again.",
                                                    preferredStyle: .Alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            
            let configureAction = UIAlertAction(title: "Configure", style: .Default) { action in
                
                // Send the user to the device's Settings app.
                if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(appSettings)
                }
            }
            
            alertController.addAction(configureAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

    // Implemented from MFMailComposeViewControllerDelegate...
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func gotoWebsite(sender: UIButton) {

        if let url = NSURL(string: "https://guildsa.org") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
}

