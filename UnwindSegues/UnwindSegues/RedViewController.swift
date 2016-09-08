//
//  RedViewController.swift
//  UnwindSegues
//
//  Created by Kevin Harris on 8/29/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

// https://www.youtube.com/watch?v=akmPXZ4hDuU&list=PLOU2XLYxmsIKGQekfmV0Qk52qLG5LU2jO&index=8

import UIKit

class RedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onSegueToGreenViewController(sender: UIButton) {
        
        performSegueWithIdentifier("segueToGreen", sender: sender)
    }
    
    // We can override prepareForSegue in a UIViewController if we want to perform some
    // action before a Segue actually fires off. This is typically done to package up
    // some data that we wish to pass to the new UIViewControler that we're about to
    // move to.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "segueToGreen" {
            
            // Since we know that we're about to transition to the GreenViewController
            // we can use this moment to pass some data to it.
            let nextVC = segue.destinationViewController as! GreenViewController
            
            nextVC.someIncomingData = "RedViewController says hi!"
        }
    }
    
    @IBAction func unwindToRedViewController(segue: UIStoryboardSegue) {
        
        if segue.sourceViewController.isKindOfClass(GreenViewController) {
            
            // Since we know that we're transitioning back from the GreenViewController
            // we can use this moment to retrieve some data from it.
            let prevVC = segue.sourceViewController as! GreenViewController
            
            print("The view controller that is unwinding to us passed: '\(prevVC.someOutgoingData!)'")
        }
    }
}

