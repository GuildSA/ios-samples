//
//  ViewController.swift
//  SwinjectDemo
//
//  Created by Kevin Harris on 6/27/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cloudDatabase: CloudDatabase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let userData = cloudDatabase!.getUserData("42");
        print("getUserData returned: = \(userData)");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNextView(sender: UIButton) {
        
        performSegueWithIdentifier("NextView", sender: self)
    }
    
    // We can override this method in UIViewController if we want to perform some
    // logic before a Segue actually fires off.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "NextView" {
            
            print("Preparing for the NextView segue!")

            let nextVC = segue.destinationViewController as! NextViewController
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            nextVC.cloudDatabase = appDelegate.container.resolve(CloudDatabase.self)
        }
    }
}
