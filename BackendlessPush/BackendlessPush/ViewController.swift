//
//  ViewController.swift
//  BackendlessPush
//
//  Created by Kevin Harris on 10/3/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Don't forget to replace the App's ID and Secret Key in AppDelegate with YOUR own
    // from YOUR Backendless Dashboard!
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    let backendless = Backendless.sharedInstance()!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        backendless.messaging.pushReceiver = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkForBackendlessSetup() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.APP_ID == "<replace-with-your-app-id>" || appDelegate.SECRET_KEY == "<replace-with-your-secret-key>" {
            
            let alertController = UIAlertController(title: "Backendless Error",
                                                    message: "To use this sample you must register with Backendless, create an app, and replace the APP_ID and SECRET_KEY in the AppDelegate with the values from your app's settings.",
                                                    preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func triggerPushFromAppBtn(_ sender: UIButton) {
        
        checkForBackendlessSetup()
        
        let publishHeaders = [
            "publisher_name": "App",
            "ios-badge": "1",
            "ios-sound": "default"
            //"android-content-text": "Content text",
            //"android-content-title": "Title",
            //"android-ticker-text": "Ticker text"
        ]
        
        let publishOptions = PublishOptions()
        publishOptions.assignHeaders(publishHeaders)
        
        let deliveryOptions = DeliveryOptions()
        deliveryOptions.pushPolicy(PUSH_ONLY)
        deliveryOptions.pushBroadcast(FOR_ANDROID.rawValue|FOR_IOS.rawValue)
        
        // If you know the Device ID, we could send the push to just that one device.
        //deliveryOptions.addSinglecast("A44ECEC0-B48F-4B5C-81C8-CF97ED5B59B4")
        
        backendless.messaging.publish(
            "default", // Which channel to target!
            message: "Push triggered by app!",
            publishOptions: publishOptions,
            deliveryOptions: deliveryOptions,
            response: {(status: MessageStatus?) -> () in
                print("Message has been sent: \(status!)")
            },
            error: { (fault : Fault?) -> () in
                print("Server reported an error: \(fault)")
        })
    }
}

extension ViewController: IBEPushReceiver {

    public func didReceiveRemoteNotification(_ notification: String!, headers: [AnyHashable : Any]!) {
        
        print("Received Message: \(notification!)")
        
        let publisherName = headers["publisher_name"] ?? "nil"
        let iosBadge = headers["ios-badge"] ?? "nil"
        let iosSound = headers["ios-sound"] ?? "nil"
        
        print("publisher_name = \(publisherName)")
        print("ios-badge = \(iosBadge)")
        print("ios-sound = \(iosSound)")
        //print("android-content-text = \(headers["android-content-text"]!)")
        //print("android-content-title = \(headers["android-content-title"]!)")
        //print("android-ticker-text = \(headers["android-ticker-text"]!)")
        
        let alertController = UIAlertController(title: "Push Notification",
                                                message: "Our app received a Remote Push Notification! Here's our opportunity to do something special based on it.\n\nPush Data:\n\nnotification = \(notification!)\npublisher_name = \(publisherName)\nios-badge = \(iosBadge)\nios-sound = \(iosSound)",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func didRegisterForRemoteNotifications(withDeviceId deviceId: String!, fault: Fault!) {
        
        if fault == nil {
            print("didRegisterForRemoteNotificationsWithDeviceId: \(deviceId!)")
        } else {
            print("didRegisterForRemoteNotificationsWithDeviceId: \(fault)")
        }
    }
    
    public func didFailToRegisterForRemoteNotificationsWithError(_ err: Error!) {
        
        print("didFailToRegisterForRemoteNotificationsWithError: \(err)")
    }
}


