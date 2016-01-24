//
//  SecondViewController.swift
//  TestTableView
//
//  Created by Kevin Harris on 1/20/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var textData:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textLabel.text = textData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
