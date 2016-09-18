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

    @IBAction func onSegueToGreenViewController(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segueToGreen", sender: sender)
    }
    
    // We can override prepareForSegue in a UIViewController if we want to perform some
    // action before a Segue actually fires off. This is typically done to package up
    // some data that we wish to pass to the new UIViewControler that we're about to
    // move to.
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "segueToGreen" {
            
            // Since we know that we're about to transition to the GreenViewController
            // we can use this moment to pass some data to it.
            let nextVC = segue.destination as! GreenViewController
            
            nextVC.someIncomingData = "RedViewController says hi!"
        }
    }
    
    @IBAction func unwindToRedViewController(_ segue: UIStoryboardSegue) {
        
        if segue.source.isKind(of: GreenViewController.self) {
            
            // Since we know that we're transitioning back from the GreenViewController
            // we can use this moment to retrieve some data from it.
            let prevVC = segue.source as! GreenViewController
            
            print("The view controller that is unwinding to us passed: '\(prevVC.someOutgoingData!)'")
        }
    }
}

