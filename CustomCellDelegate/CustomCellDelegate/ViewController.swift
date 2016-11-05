//
//  ViewController.swift
//  CustomCellDelegate
//
//  Created by Kevin Harris on 9/15/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {
    
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
    
    func isSimulator() -> Bool {
#if (arch(i386) || arch(x86_64)) && os(iOS)
        return true
#else
        return false
#endif
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return businessDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        // If this UIViewController implements MyTableViewCellDelegate, it can set
        // itself as the cell's delegate and receive function calls such as didTapEmail().
        cell.delegate = self
        
        let row = (indexPath as NSIndexPath).row
        
        let fullUrl = businessDataArray[row].website
        cell.websiteUrl = fullUrl
        
        var shortUrl: String = ""
        
        // If the URL has "http://" or "https://" in it - remove it!
        if fullUrl.lowercased().range(of: "http://") != nil {
            shortUrl = fullUrl.replacingOccurrences(of: "http://", with: "")
        } else if fullUrl.lowercased().range(of: "https://") != nil {
            shortUrl = fullUrl.replacingOccurrences(of: "https://", with: "")
        }
        
        cell.websiteBtn.setTitle(shortUrl, for: UIControlState())
        
        cell.emailBtn.setTitle(businessDataArray[row].email, for: UIControlState())
        cell.emailAddress = businessDataArray[row].email
        
        return cell
    }
}

extension ViewController: MyTableViewCellDelegate {
    
    // If this gets called we know that a user has tapped on the email button on one of our cells.
    func didTapEmail(_ email: String) {
        
        if isSimulator() {
            
            let alertController = UIAlertController(title: "Could Not Send Email",
                                                    message: "You can not send an email from the simulator!",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([email])
            mailComposerVC.setSubject("My Subject...")
            mailComposerVC.setMessageBody("Here's my email! Blah Blah Blah.", isHTML: false)
            
            self.present(mailComposerVC, animated: true, completion: nil)
            
        } else {
            
            let alertController = UIAlertController(title: "Could Not Send Email",
                                                    message: "Your device is not configured to send e-mail. Please check e-mail configuration and try again.",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            let configureAction = UIAlertAction(title: "Configure", style: .default) { action in
                
                // Send the user to the device's Settings app.
                if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.openURL(appSettings)
                }
            }
            
            alertController.addAction(configureAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
