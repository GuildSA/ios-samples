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

    @IBAction func showSimpleAlert(sender: UIButton) {
        
        //
        // UIAlertController - Simple Alert
        //
        
        let alertController = UIAlertController(title: "Network Error", message: "Unable to reach the server. Check network connectivity or try again later..", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            print("OK was selected!")
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true) {
            print("Show the Simple Alert!")
        }
    }
    
    @IBAction func showAlertWithButtons(sender: UIButton) {
        
        //
        // UIAlertController - Alert with Buttons
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
            print("Show the Alert with buttons!")
        }
    }
    
    @IBAction func showAlertWithTextFields(sender: UIButton) {
        
        //
        // UIAlertController - Alert With Text Fields & Buttons
        //

        let alertController = UIAlertController(title: "Account Login",
                                                message: "Please enter your login credentials.",
                                                preferredStyle: .Alert)

        alertController.addTextFieldWithConfigurationHandler { textField -> Void in

            textField.textColor = UIColor.blueColor()
            textField.placeholder = "User Name"
        }

        alertController.addTextFieldWithConfigurationHandler { textField -> Void in

            textField.textColor = UIColor.blueColor()
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            print("Cancel was selected!")
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Login", style: .Default) { (action) in
            print("Login was selected!")
            
            let userName = alertController.textFields![0].text!
            let password = alertController.textFields![1].text!
            
            print("User Name entered \(userName)")
            print("Password entered \(password)")
        }
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true) {
            print("Show the Alert + Text Fields!")
        }
    }
    
    @IBAction func showActionSheet(sender: UIButton) {
        
        //
        // UIAlertController - Action Sheet
        //

        let alertController = UIAlertController(title: nil,
                                                message: "You have changed this image. What would you like to do with it?",
                                                preferredStyle: .ActionSheet)

        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) in
            print("Save was selected!")
        }
        alertController.addAction(saveAction)

        let discardAction = UIAlertAction(title: "Discard", style: .Destructive) { (action) in
            print("Discard was selected!")
        }
        alertController.addAction(discardAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            print("Cancel was selected!")
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
            print("Show the Action Sheet!")
        }
    }
}

