//
//  SettingsViewController.swift
//  CustomNavBarCode
//
//  Created by Kevin Harris on 9/30/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // This sets the text in the middle of the Nav Bar for this View Controllers.
        self.navigationItem.title = "Settings"
        
        
        //
        // Set a custom image on the Left Side Bar Buttom item.
        //
        
        // Create a UIImage from our save button art.
        var saveBtnImage = UIImage(named: "save_btn")
        
        // Now, force our image to keep its original colors by setting its rendering mode 
        // to AlwaysOriginal. This will keep iOS from converting it to white.
        saveBtnImage = saveBtnImage!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let rightbarBtnItem = UIBarButtonItem(image: saveBtnImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(rightBarBtnItemPressed(_:)))
        
        // Finally, make Bar Buttom item on the Right-side use our Save Button Image
        // without defaulting it to white.
        self.navigationItem.rightBarButtonItem = rightbarBtnItem
        
        
        //
        // Set a custom image on the Right Side Bar Buttom item.
        //
        
        // Create a UIImage from our back button art.
        var backBtnImage = UIImage(named: "back_btn")
        
        // Now, force our image to keep its original colors by setting its rendering mode
        // to AlwaysOriginal. This will keep iOS from converting it to white.
        backBtnImage = backBtnImage!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        let leftbarBtnItem = UIBarButtonItem(image: backBtnImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftBarBtnItemPressed(_:)))
        
        // Finally, make Bar Buttom item on the Left-side use our Back Button Image
        // without defaulting it to white.
        self.navigationItem.leftBarButtonItem = leftbarBtnItem
        
        
//        // Some developers do not create a UIBarButtonItem with a custom image but instead they create
//        // a UIBarButtonItem that holds a UIButton and then they modify the button
//        
//        //
//        // Create a UIButton and then use it to set the Right Side Bar Buttom item.
//        //
//        
//        // Create a UIImage from our back button art.
//        let backBtnImage = UIImage(named: "back_btn")
//        
//        let leftBtn = UIButton()
//        leftBtn.setImage(backBtnImage, forState: .Normal)
//        leftBtn.frame = CGRectMake(0, 0, 70, 30)
//        leftBtn.addTarget(self, action: #selector(leftBtnPressed(_:)), forControlEvents: .TouchUpInside)
//    
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        
        

//        // This sets the Back button text color for this View Controllers.
//        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
//        // This sets the background image of the whole Nav Bar for this View Controllers.
//        let navBarBackgroundImage = UIImage(named: "nav_bg")
//        self.navigationController?.navigationBar.setBackgroundImage(navBarBackgroundImage, forBarMetrics: .Default)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func rightBarBtnItemPressed(_ sender: UIBarButtonItem) {
        
        print("Save something!")
    }

    func leftBarBtnItemPressed(_ sender: UIBarButtonItem) {
        
        // This will not work here!
        //dismissViewControllerAnimated(true, completion: nil)
        
        // Since we're using a UINavigationController we will call
        // popViewControllerAnimated to dismiss the UIViewController
        // at the top of the stack.
        _ = self.navigationController?.popViewController(animated: true)
    }

    func leftBtnPressed(_ sender: UIButton!) {
        
        // This will not work here!
        //dismissViewControllerAnimated(true, completion: nil)
        
        // Since we're using a UINavigationController we will call
        // popViewControllerAnimated to dismiss the UIViewController
        // at the top of the stack.
        _ = self.navigationController?.popViewController(animated: true)
    }
}
