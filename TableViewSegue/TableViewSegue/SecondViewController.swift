//
//  SecondViewController.swift
//  TestTableView
//
//  Created by Kevin Harris on 1/25/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var textData:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Once the view loads, use the String value stored in textData to
        // to set the view's label text as proof that we actually got the 
        // data passed to us from the other view controller.
        textLabel.text = textData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
