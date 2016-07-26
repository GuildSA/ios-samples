//
//  ViewController.swift
//  MultipleStoryboards
//
//  Created by Kevin Harris on 7/18/16.
//  Copyright © 2016 guildsa. All rights reserved.
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

    @IBAction func onNextViewController(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Second", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("SecondViewController") as UIViewController
        
        //self.presentViewController(controller, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

