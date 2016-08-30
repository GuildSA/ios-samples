//
//  ModalViewController.swift
//  NavController
//
//  Created by Kevin Harris on 1/12/16.
//  Copyright © 2016 guildsa. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchUpInsideDismiss(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: {
            print("ModalViewController was dismissed!");
        })
    }
}