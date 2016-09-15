//
//  ViewController.swift
//  CustomCellDelegate
//
//  Created by Kevin Harris on 9/15/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UITableViewDataSource, MFMailComposeViewControllerDelegate, MyTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    struct BusinessData {
        
        var website: String
        var email: String
    }
    
    var businessDataArray = [BusinessData]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadSomeData()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSomeData() {
        
        businessDataArray.append(BusinessData(website: "https://guildsa.org", email: "info@guildsa.org"))
        businessDataArray.append(BusinessData(website: "https://guildsa.org", email: "info@guildsa.org"))
        businessDataArray.append(BusinessData(website: "https://guildsa.org", email: "info@guildsa.org"))
        businessDataArray.append(BusinessData(website: "https://guildsa.org", email: "info@guildsa.org"))
        businessDataArray.append(BusinessData(website: "https://guildsa.org", email: "info@guildsa.org"))
        businessDataArray.append(BusinessData(website: "https://guildsa.org", email: "info@guildsa.org"))
    }
    
    // From UITableViewDataSource protocol.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return businessDataArray.count
    }
    
    // From UITableViewDataSource protocol.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! MyTableViewCell
        
        // If this UIViewController implements MyTableViewCellDelegate, it can set
        // itself as the cell's delegate and receive function calls such as didTapEmail().
        cell.delegate = self
        
        let row = indexPath.row
        
        let fullUrl = businessDataArray[row].website
        cell.websiteUrl = fullUrl
        
        var shortUrl: String = ""
        
        // If the URL has "http://" or "https://" in it - remove it!
        if fullUrl.lowercaseString.rangeOfString("http://") != nil {
            shortUrl = fullUrl.stringByReplacingOccurrencesOfString("http://", withString: "")
        } else if fullUrl.lowercaseString.rangeOfString("https://") != nil {
            shortUrl = fullUrl.stringByReplacingOccurrencesOfString("https://", withString: "")
        }
        
        cell.websiteBtn.setTitle(shortUrl, forState: .Normal)
        
        cell.emailBtn.setTitle(businessDataArray[row].email, forState: .Normal)
        cell.emailAddress = businessDataArray[row].email
        
        return cell
    }
    
    func isSimulator() -> Bool {
#if (arch(i386) || arch(x86_64)) && os(iOS)
        return true
#else
        return false
#endif
    }
    
    // Implemented from  MyTableViewCellDelegate
    // If this gets called we know that a user has tapped on the email button on one of our cells.
    func didTapEmail(email: String) {
        
        if isSimulator() {
            
            let alertController = UIAlertController(title: "Could Not Send Email",
                                                    message: "You can not send an email from the simulator!",
                                                    preferredStyle: .Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return
        }
        
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
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
}

