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
        
        
        // If you present a UIViewController via a modal segue you can 
        // test which class the presenting view controller belonged to like so:
        
        let thePresenter = self.presentingViewController
        
        if (thePresenter?.isKind(of: RedViewController.self))! {
            print("It's the RedViewController")
        } else {
            print("It's something else!")
        }
        
//        // If however your view controller was presented via a UINavigationController
//        // then the above isn’t going to work. Instead you need to check which view 
//        // controller was on the navigation stack previously.
//        let count = self.navigationController?.viewControllers.count
//        
//        let thePresenter: UIViewController? = count! >= 2 ? self.navigationController?.viewControllers[count!-2] : nil
//        
//        if (thePresenter?.isKind(of: RedViewController.self))! {
//            print("It's the RedViewController")
//        } else {
//            print("It's something else!")
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToRedViewController(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
}
