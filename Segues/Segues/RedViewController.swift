//
//  RedViewController.swift
//  Segues
//
//  Created by Kevin Harris on 8/29/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segueToGreenViewController(sender: UIButton) {
        
        // To trigger a manual Segue, we simply call performSegueWithIdentifier, but this
        // requires that the Segue have an identifier set.
        performSegueWithIdentifier("segueFromViewController", sender: sender)
    }
    
    // If we create an action Segue that was directly connected from a control such as a
    // button to a new UIViewControler, our only chance to stop the Segue is by overriding
    // shouldPerformSegueWithIdentifier. This will not be called for manual Segues that are
    // connected from one UIViewControler to the next UIViewControler.
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "segueFromButtonAction" {
            
            // If for some reason we shouldn't perform the requested Segue, return false to cancel it.
            //return false
        }
        
        // If we make it this far, Perform the Segue and start the transition.
        return true
    }
    
    // We can override prepareForSegue in a UIViewController if we want to perform some
    // action before a Segue actually fires off. This is typically done to package up
    // some data that we wish to pass to the new UIViewControler that we're about to
    // move to.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "segueFromButtonAction" {
            
            print("Preparing for the segueFromButtonAction segue!")
            
            // If we need to, modify the next UIViewController.
            let nextVC = segue.destinationViewController as! GreenViewController
            
            nextVC.someText = "Action Segue"
            
        } else if segue.identifier == "segueFromViewController" {
            
            print("Preparing for the segueFromViewController segue!")
            
            // If we need to, modify the next UIViewController.
            let nextVC = segue.destinationViewController as! GreenViewController
            
            nextVC.someText = "Manual Segue"
        }
    }
}

