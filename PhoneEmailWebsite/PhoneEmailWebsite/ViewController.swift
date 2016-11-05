//
//  ViewController.swift
//  PhoneEmailWebsite
//
//  Created by Kevin Harris on 9/13/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func callPhoneNumber(_ sender: UIButton) {
        
        if let url = URL(string: "tel://8042221111") {

            let alertController = UIAlertController(title: "Place Call",
                                                    message: "Do you wish to call (804) 222-1111 now?",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            let callAction = UIAlertAction(title: "Call", style: .default) { action in
                
                UIApplication.shared.openURL(url)
            }
            
            alertController.addAction(callAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            print("Failed to convert phone number to NSURL")
        }
    }

    @IBAction func createEmail(_ sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients(["info@guildsa.org"])
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

    @IBAction func gotoWebsite(_ sender: UIButton) {

        if let url = URL(string: "https://guildsa.org") {
            UIApplication.shared.openURL(url)
        }
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}
