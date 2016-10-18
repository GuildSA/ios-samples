//
//  UtilitySWIFT.swift
//  Singleton
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import Foundation
import UIKit

class UtilitySWIFT {
    
    // This gives access to the one and only instance.
    static let sharedInstance = UtilitySWIFT()
    
    // This prevents others from using the default '()' initializer for this class.
    private init() {}

    
    static func isValidEmail(emailAddress: String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: emailAddress)
    }
    
    static func showAlert(viewController: UIViewController, title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
        
            print("Ok button selected!");
        })
        
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func delayTask(seconds: Double, task: @escaping () -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            task()
        }
    }
}