//
//  NextViewController.swift
//  SwinjectDemo
//
//  Created by Kevin Harris on 6/28/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    var cloudDatabase: CloudDatabase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let userData = cloudDatabase!.getUserDataCached();
        print("getUserDataCached returned: \(userData)");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
