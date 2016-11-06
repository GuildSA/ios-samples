//
//  FourthViewController.swift
//  TabBarPlusNav
//
//  Created by Kevin Harris on 6/23/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // The call to popToRootViewControllerAnimated will trigger this
        // call, so this is our opportunity to switch tabs.
        
        // If our view controller wants to manually switch the
        // tabBarController to another tab, it can set the selectedIndex
        // on the tabBarController like so to force the switch.
        self.tabBarController?.selectedIndex = 0;
    }
    
    @IBAction func onTouchUpInsideJumpToTab(_ sender: UIButton) {
        
        // Since we are planning on abruptly leaving a tab that is using a
        // navigationController to manage view controllers, we might want
        // to rewind the navigationController back to the beginning so
        // when a user taps on this tab again, they'll start the UI flow
        // over for this tab. This may or may not be important depending
        // on you situation.
        
        // If you want to go back to the previous view controller, do this.
        //self.navigationController?.popViewControllerAnimated(false)
        
        // If you want to go ALL the way back to the root view controller, do this?
        _ = self.navigationController?.popToRootViewController(animated: false)
    }
}
