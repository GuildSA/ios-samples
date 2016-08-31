//
//  SecondViewController.swift
//  CustomNavBar
//
//  Created by Kevin Harris on 1/18/16.
//  Copyright © 2016 guildsa. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a UIImage from our Save Button art.
        var itemButtonImage = UIImage(named: "save_btn")
        
        // Now, force our Save Button image to keep its original colors by setting its
        // rendering mode to AlwaysOriginal. This will keep iOS from converting it to white.
        itemButtonImage = itemButtonImage!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        // Finally, make Bar Buttom item on the Right-side use our Save Button Image
        // without defaulting it to white.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: itemButtonImage, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
//        // This sets the Back button text color for this View Controllers.
//        let navigationBar = self.navigationController!.navigationBar
//        navigationBar.tintColor = UIColor.whiteColor()
//        
//        // This sets the text in the middle of the Nav Bar for this View Controllers.
//        navigationItem.title = "Settings"
//        
//        // This sets the background image of the whole Nav Bar for this View Controllers.
//        let navBarBackgroundImage = UIImage(named: "Background Nav Bar")
//        navigationBar.setBackgroundImage(navBarBackgroundImage, forBarMetrics: .Default)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
