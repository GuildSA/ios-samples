//
//  ViewController.swift
//  Singleton
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        
//        UtilitySWIFT.showAlert(viewController: self, title: "My Alert", message: "This is my alert coming from Swift!")
     
//        UtilityOBJC.showAlert(self, title: "My Alert", message: "This is my alert coming from Objective-C!")
        
        
//        UtilitySWIFT.delayTask(seconds: 3, task: {
//        
//            UtilitySWIFT.showAlert(viewController: self, title: "Delayed Alert", message: "This is my delayed alert coming from Swift!")
//        })
        
        UtilityOBJC.delayTask(3, task: {
            
            UtilityOBJC.showAlert(self, title: "Delayed Alert", message: "This is my delayed alert coming from Objective-C!")
        })
        
        
//        if !UtilitySWIFT.isValidEmail(emailAddress: "kevin@gmail") {
//            
//            UtilitySWIFT.showAlert(viewController: self, title: "Bad Email Error", message: "Bad email address deteced by Swift!")
//        }
        
//        if !UtilityOBJC.isValidEmail("kevin@gmail") {
//
//            UtilityOBJC.showAlert(self, title: "Bad Email Error", message: "Bad email address deteced by Objective-C!")
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

