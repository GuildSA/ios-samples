//
//  SettingsViewController.swift
//  CustomNavBar
//
//  Created by Kevin Harris on 1/18/16.
//  Copyright © 2016 guildsa. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtn(sender: UIButton) {
        
        // This will not work here!
        //dismissViewControllerAnimated(true, completion: nil)
        
        // Since we're using a UINavigationController we will call
        // popViewControllerAnimated to dismiss the UIViewController
        // at the top of the stack.
        self.navigationController?.popViewControllerAnimated(true)
    }
}
