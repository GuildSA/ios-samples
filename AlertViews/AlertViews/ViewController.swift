//
//  ViewController.swift
//  AlertViews
//
//  Created by Kevin Harris on 1/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

// https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIAlertController_class/

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSimpleAlert(_ sender: UIButton) {
        
        //
        // UIAlertController - Simple Alert
        //
        // https://developer.apple.com/ios/human-interface-guidelines/ui-views/alerts/
        //
        
        let alertController = UIAlertController(title: "Network Error",
                                                message: "Unable to reach the server. Check network connectivity or try again later.",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            print("OK was selected!")
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true) {
            print("Show the Simple Alert!")
        }
    }
    
    @IBAction func showAlertWithButtons(_ sender: UIButton) {
        
        //
        // UIAlertController - Alert with Buttons
        //
        // UI - Terminology and Wording
        // https://developer.apple.com/library/mac/documentation/UserExperience/Conceptual/OSXHIGuidelines/TerminologyWording.html#//apple_ref/doc/uid/20000957-CH15-SW1
        //

        let alertController = UIAlertController(title: "Discard Settings",
                                                message: "Are you sure you want to discard these settings?",
                                                preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("Cancel was selected!")
        }
        
        alertController.addAction(cancelAction)

        let discardAction = UIAlertAction(title: "Discard", style: .default) { action in
            print("Discard was selected!")
        }
        
        alertController.addAction(discardAction)

        self.present(alertController, animated: true) {
            print("Show the Alert with Buttons!")
        }
    }
    
    @IBAction func showAlertWithTextFields(_ sender: UIButton) {
        
        //
        // UIAlertController - Alert With Text Fields & Buttons
        //

        let alertController = UIAlertController(title: "Account Login",
                                                message: "Please enter your login credentials.",
                                                preferredStyle: .alert)

        alertController.addTextField { textField -> Void in

            textField.textColor = UIColor.blue
            textField.placeholder = "User Name"
        }

        alertController.addTextField { textField -> Void in

            textField.textColor = UIColor.blue
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("Cancel was selected!")
        }
        
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "Login", style: .default) { action in
            print("Login was selected!")
            
            let userName = alertController.textFields![0].text!
            let password = alertController.textFields![1].text!
            
            print("User Name entered \(userName)")
            print("Password entered \(password)")
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true) {
            print("Show the Alert With Text Fields & Buttons")
        }
    }
    
    @IBAction func showActionSheet(_ sender: UIButton) {
        
        //
        // UIAlertController - Action Sheet
        //
        // https://developer.apple.com/ios/human-interface-guidelines/ui-views/action-sheets/
        //

        let alertController = UIAlertController(title: nil,
                                                message: "You have changed this image. What would you like to do with it?",
                                                preferredStyle: .actionSheet)

        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            print("Save was selected!")
        }
        
        alertController.addAction(saveAction)

        let discardAction = UIAlertAction(title: "Discard", style: .destructive) { action in
            print("Discard was selected!")
        }
        
        alertController.addAction(discardAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("Cancel was selected!")
        }
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true) {
            print("Show the Action Sheet!")
        }
    }
}

