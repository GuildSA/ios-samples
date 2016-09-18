//
//  SecondViewController.swift
//  RetainCycle
//
//  Created by Kevin Harris on 7/5/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

// http://www.thomashanning.com/a-trick-to-discover-retain-cycles/

class SecondViewController: UIViewController, ModelObjectDelegate {

    var modelObject: ModelObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        modelObject = ModelObject()
        modelObject!.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDismissView(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
        print("SecondViewController dismissed!")
    }
    
    deinit {
        print("SecondViewController deinit!")
    }
}
