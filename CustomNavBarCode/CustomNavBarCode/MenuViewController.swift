//
//  MenuViewController.swift
//  CustomNavBarCode
//
//  Created by Kevin Harris on 9/30/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // This sets the text in the middle of the Nav Bar for this View Controllers.
        self.navigationItem.title = "Menu"
        
        // This sets the Back button text color for this View Controllers.
        self.navigationController!.navigationBar.tintColor = UIColor.red
        
//        // This sets the background image of the whole Nav Bar for this View Controllers.
//        let navBarBackgroundImage = UIImage(named: "nav_bg")
//        self.navigationController?.navigationBar.setBackgroundImage(navBarBackgroundImage, forBarMetrics: .Default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
