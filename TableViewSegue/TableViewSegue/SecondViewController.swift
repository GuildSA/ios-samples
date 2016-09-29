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
        
        
//        // If you present a UIViewController via a modal segue you can
//        // test which class the presenting view controller belonged to like so:
//
//        let thePresenter = self.presentingViewController
//
//        if (thePresenter?.isKind(of: ViewController.self))! {
//            print("It's the ViewController")
//        } else {
//            print("It's something else!")
//        }

        // If however your view controller was presented via a UINavigationController
        // then the above isn’t going to work. Instead you need to check which view
        // controller was on the navigation stack previously.
        let count = self.navigationController?.viewControllers.count

        let thePresenter: UIViewController? = count! >= 2 ? self.navigationController?.viewControllers[count!-2] : nil

        if (thePresenter?.isKind(of: ViewController.self))! {
            print("It's the ViewController")
        } else {
            print("It's something else!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
