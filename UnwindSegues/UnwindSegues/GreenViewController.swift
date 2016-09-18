//
//  GreenViewController.swift
//  UnwindSegues
//
//  Created by Kevin Harris on 8/29/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {

    // Whoever launches the GreenViewController can pass some data to it by
    // setting this var.
    var someIncomingData: String?
    
    // When we unwind back to the RedViewController, the RedViewController
    // can access this var to get some data from the GreenViewController
    // prior to its cleanup.
    var someOutgoingData: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("The view controller that launched us passed: '\(someIncomingData!)'!")
    }

    @IBAction func onDismissToRedViewControllerBtn(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onUnwindToRedViewControllerBtn(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "unwindToRedVC", sender: self)
    }
    
    // We can override prepareForSegue in a UIViewController if we want to perform some
    // action before a Segue actually fires off. This is typically done to package up
    // some data that we wish to pass to the new UIViewControler that we're about to
    // move to.
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "unwindToRedVC" {
            
            // Since we know that we're about to transition back to the RedViewController
            // we can use this moment to set some data on ourselves so the RedViewController
            // can retrieve it later.
            someOutgoingData = "GreenViewController says bye-bye!"
        }
    }
}
