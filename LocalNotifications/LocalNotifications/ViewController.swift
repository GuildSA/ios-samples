//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Kevin Harris on 10/2/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var uuid = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This view controller wants to observe or listen for a notification called: "handleNotification".
        // This notification is not the same thing as a Local Notification. It is triggerd by our call to 
        // NotificationCenter.default.post which is in the AppDelegate.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reactToNotification), name: NSNotification.Name(rawValue: "handleNotification"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reactToNotification(notification: NSNotification) {
        
        print("The method reactToNotification was called!")
        
        let alertController = UIAlertController(title: "Notification",
                                                    message: "Our app received a Local Notification! Here's our opportunity to do something special based on the Local Notification that we received.\n\nUUID:\n\n\((notification.userInfo?["UUID"])!)",
                                                    preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func scheduleLocalNotification(_ sender: UIButton) {
        
        // Create a unique ID for our new Local Notification just in case we want to ID it later.
        // This is optional but sometimes very handy!
        uuid = UUID().uuidString
        
        // Create a new Local Notification.
        
        let notification = UILocalNotification()
        notification.alertTitle = "Something Happened"
        notification.alertBody = "Hey, our app wants to notify you of something!"
        notification.fireDate = Date().addingTimeInterval(10.0) // For testing purposes, have the notification fire in 10 seconds.
        notification.soundName = UILocalNotificationDefaultSoundName // Play default sound.
        notification.userInfo = ["UUID": uuid] // Add the unique identifier to the userInfo of the notification so we can ID it later.
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    @IBAction func removeLocalNotification(_ sender: UIButton) {
        
        // Get all the Local Notifications set by our app.
        let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
        
        guard scheduledNotifications != nil else {
            
            // Nothing to remove - just return.
            return
        }
        
        // Loop through all the Local Notifications and attempt to find the one to remove.
        for notification in scheduledNotifications! {
            
            if notification.userInfo!["UUID"] as! String == uuid {
                UIApplication.shared.cancelLocalNotification(notification)
                break
            }
        }
    }
}

