//
//  ViewController.swift
//  MultipleStoryboards
//
//  Created by Kevin Harris on 7/18/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onNextViewController(_ sender: UIButton) {
        
        // Load the second storyboard by name.
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        
        // Use the new storyboard to instantiate a certain UIViewController by name.
        let controller = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as UIViewController
        
        //self.presentViewController(controller, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
