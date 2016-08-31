//
//  AppDelegate.swift
//  CustomNavBar
//
//  Created by Kevin Harris on 1/11/16.
//  Copyright © 2016 guildsa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        // This sets the background image of the whole Nav Bar for all View Controllers!
        let navBarBackgroundImage = UIImage(named: "bg_nav")
        UINavigationBar.appearance().setBackgroundImage(navBarBackgroundImage, forBarMetrics: .Default)
        
        // This sets the background image of the Back Button for all View Controllers!
        let buttonBackgroundImage: UIImage = UIImage(named: "back_btn")!
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(buttonBackgroundImage, forState: .Normal, barMetrics: .Default)
        
        
//        // This sets the background color of the whole Nav Bar for all View Controllers!
//        UINavigationBar.appearance().barTintColor = UIColor.blueColor()
//        
//        // This sets the color of the Title text for all View Controllers.
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.redColor()]
//        
//        // This sets the color of Bar Buton text for all View Controllers.
//        UIBarButtonItem.appearance().tintColor = UIColor.greenColor()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

