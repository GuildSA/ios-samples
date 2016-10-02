//
//  AppDelegate.swift
//  LocalNotifications
//
//  Created by Kevin Harris on 10/2/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

// https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/WhatAreRemoteNotif.html

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // If our app wants to use notifications, we must ask for permission.
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        
        return true
    }

    // When our app receives a notification, this method of the AppDelegate will be called.
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("The method: 'application:didReceive notification' was called!")
        
        print("title = \(notification.alertTitle!)")
        print("body = \(notification.alertBody!)")
        print("user info =\(notification.userInfo!)")
        
        // Here's an example of sending an internal message to another part of our app.
        // Please note: The use of NotificationCenter to send messages is a separate
        // feature and is not related to using Local Notifications. In other words,
        // you can use the NotificationCenter to send notifications within your app even
        // if your app doesn't use or create UILocalNotification(s). Now, with that said,
        // using the NotificationCenter to notify parts of the app about the firing of a
        // Local Notification is fairly common pattern.
        
        let uuid = (notification.userInfo?["UUID"])!
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "handleNotification"), object: self, userInfo: ["UUID": uuid])
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

