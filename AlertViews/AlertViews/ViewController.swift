//
//  ViewController.swift
//  AlertViews
//
//  Created by Kevin Harris on 1/26/16.
//  Copyright © 2016 guildsa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchUpInside(sender: UIButton) {
        
        print("tag id = \(sender.tag)")
        
        // Starting in iOS 8, UIActionSheet and UIAlertViews have been replaced by the new UIAlertController.
        
        if sender.tag == 1 {
            
            //
            // Simple Alert
            //
            
            let alertController = UIAlertController(title: "Discard Settings", message: "Are you sure you want to discard these settings?", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                print("Cancel was selected!")
            }
            alertController.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                print("OK was selected!")
            }
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true) {
                print("Show the Simple Alert!")
            }

        } else if sender.tag == 2 {
                
            //
            // Alert + TextFields
            //
            
            let alertController = UIAlertController(title: "Account Login", message: "Please enter your login credentials.", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                print("Cancel was selected!")
            }
            alertController.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "Login", style: .Default) { (action) in
                print("Login was selected!")
                
                let userName = alertController.textFields![0].text
                let password = alertController.textFields![1].text
                
                print("User Name entered \(userName)")
                print("Password entered \(password)")
            }
            alertController.addAction(okAction)
            
            alertController.addTextFieldWithConfigurationHandler { textField -> Void in
                
                textField.textColor = UIColor.blueColor()
                textField.placeholder = "User Name"
            }
            
            alertController.addTextFieldWithConfigurationHandler { textField -> Void in

                textField.textColor = UIColor.blueColor()
                textField.placeholder = "Password"
                textField.secureTextEntry = true
            }
            
            self.presentViewController(alertController, animated: true) {
                print("Show the Alert + TextFields!")
            }
                
        } else if sender.tag == 3 {
            
            //
            // Action Sheet
            //
            
            let alertController = UIAlertController(title: nil, message: "You have changed this image. What would you like to do with it?", preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                print("Cancel was selected!")
            }
            alertController.addAction(cancelAction)
            
            let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) in
                print("Save was selected!")
            }
            alertController.addAction(saveAction)
            
            let discardAction = UIAlertAction(title: "Discard", style: .Destructive) { (action) in
                print("Discard was selected!")
            }
            alertController.addAction(discardAction)
            
            self.presentViewController(alertController, animated: true) {
                print("Show the Action Sheet!")
            }
        }
    }
}

