//
//  GreenViewController.swift
//  Segues
//
//  Created by Kevin Harris on 8/29/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class GreenViewController: UIViewController {

    // Whoever launches the GreenViewController can pass some data to it by
    // setting this var.
    var someText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("The GreenViewController was launched via a '\(someText!)'!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToRedViewController(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
