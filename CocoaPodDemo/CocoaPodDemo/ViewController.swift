//
//  ViewController.swift
//  CocoaPodDemo
//
//  Created by Kevin Harris on 1/27/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

// About Cocoa Pods and setup:
// https://guides.cocoapods.org/

// Cocoa Pod Best Practices:
// https://guides.cocoapods.org/using/using-cocoapods.html

// This demo uses the SCLAlertView-Swift custom control:
// https://www.cocoacontrols.com/controls/sclalertview-swift

// GitHib account for SCLAlertView-Swift
// https://github.com/vikmeup/SCLAlertView-Swift


import UIKit
import SCLAlertView // Don't forget to import the source code for SCLAlertView!

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchUpInsideTestAlert(_ sender: UIButton) {
        
        // Some of these examples came from here:
        // https://github.com/vikmeup/SCLAlertView-Swift
        
        // Example #1
        SCLAlertView().showInfo("Important info", subTitle: "You are great!")

        
        // Example #2
//        SCLAlertView().showError("Hello Error", subTitle: "This is a more descriptive error text.") // Error
//        SCLAlertView().showNotice("Hello Notice", subTitle: "This is a more descriptive notice text.") // Notice
//        SCLAlertView().showWarning("Hello Warning", subTitle: "This is a more descriptive warning text.") // Warning
//        SCLAlertView().showInfo("Hello Info", subTitle: "This is a more descriptive info text.") // Info
//        SCLAlertView().showEdit("Hello Edit", subTitle: "This is a more descriptive info text.") // Edit
        
        
        // Example #3
//        let alert = SCLAlertView()
//        let txt = alert.addTextField("Enter your screen name")
//        alert.addButton("Submit Name") {
//            print("Name = \(txt.text!)")
//        }
//        alert.showEdit("Screen Name", subTitle:"Please add a screen name to use during chats.")
        
        
        // Example #4
//        SCLAlertView().showTitle(
//            "Congratulations", // Title of view
//            subTitle: "Operation successfully completed.", // String of view
//            duration: 2.0, // Duration to show before closing automatically, default: 0.0
//            completeText: "Done", // Optional button value, default: ""
//            style: .success, // Styles - see below.
//            colorStyle: 0xA429FF,
//            colorTextButton: 0xFFFFFF
//        )
        
        
        // Example #5
//        let alertView = SCLAlertView()
//        
//        alertView.addButton("First Button", target:self, selector:#selector(ViewController.firstButton))
//        
//        alertView.addButton("Second Button") {
//            print("Second button tapped")
//        }
//        
//        alertView.showSuccess("Button View", subTitle: "This alert view has buttons")
    }
    
    // Used by Example #5 (i.e "First Button")
    func firstButton() {
        print("First button tapped")
    }
}

