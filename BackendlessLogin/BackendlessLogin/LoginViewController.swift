//
//  LoginViewController.swift
//  BackendlessLogin
//
//  Created by Kevin Harris on 9/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldChanged(textField:)), for: UIControlEvents.editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if BackendlessManager.sharedInstance.APP_ID == "<replace-with-your-app-id>" ||
            BackendlessManager.sharedInstance.SECRET_KEY == "<replace-with-your-secret-key>" {
            
            Utility.showAlert(viewController: self, title: "Backendless Error", message: "To use this sample you must register with Backendless, create an app, and replace the APP_ID and SECRET_KEY in this sample's BackendlessManager class with the values from your app's settings.")
        }
    }
    
    func textFieldChanged(textField: UITextField) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            loginBtn.isEnabled = false
        } else {
            loginBtn.isEnabled = true
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        if !Utility.isValidEmail(emailAddress: emailTextField.text!) {
            Utility.showAlert(viewController: self, title: "Login Error", message: "Please enter a valid email address.")
            return
        }

        spinner.startAnimating()

        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        BackendlessManager.sharedInstance.loginUser(email: email, password: password,
            completion: {
            
                self.spinner.stopAnimating()
                
                self.performSegue(withIdentifier: "gotoMenuFromLogin", sender: sender)
            },
            
            error: { message in
                
                self.spinner.stopAnimating()
                
                Utility.showAlert(viewController: self, title: "Login Error", message: message)
            })
    }
    
    func isAppIdSetInPlist() -> Bool {
        
        // If the developer has not replaced the string "backendlessREPLACE_WITH_YOUR_APP_ID"
        // in the info.plist - notify them of the issue.
        
        var foundPlaceHolderText = false
        
        if let urlTypesArray = Bundle.main.infoDictionary?["CFBundleURLTypes"] as? Array<Dictionary<String, Array<String>>> {
            
            for urlSchemesDict in urlTypesArray {
                
                if let urlSchemes = urlSchemesDict["CFBundleURLSchemes"] {
                    
                    for urlScheme in urlSchemes {
                        
                        if urlScheme == "backendlessREPLACE_WITH_YOUR_APP_ID" {
                            foundPlaceHolderText = true
                        }
                    }
                }
            }
        }
        
        if foundPlaceHolderText {
            Utility.showAlert(viewController: self, title: "Backendless Error", message: "For Facebook & Twitter login to work, open the project's info.plist and replace the string \"REPLACE_WITH_YOUR_APP_ID\" with YOUR App's ID from YOUR Backendless Dashboard!")
            return false
        }
        
        return true
    }
    
    @IBAction func loginViaFacebook(_ sender: UIButton) {
        
        if !isAppIdSetInPlist() {
            return
        }
        
        spinner.startAnimating()
        
        BackendlessManager.sharedInstance.loginViaFacebook( completion: {
            
                self.spinner.stopAnimating()
            },
            
            error: { message in
                
                self.spinner.stopAnimating()
                
                Utility.showAlert(viewController: self, title: "Login Error", message: message)
            })
    }
    
    @IBAction func loginViaTwitter(_ sender: UIButton) {
        
        if !isAppIdSetInPlist() {
            return
        }
        
        BackendlessManager.sharedInstance.loginViaTwitter( completion: {
            
                self.spinner.stopAnimating()
            },
            
            error: { message in
                
                self.spinner.stopAnimating()
                
                Utility.showAlert(viewController: self, title: "Login Error", message: message)
            })
    }
}
