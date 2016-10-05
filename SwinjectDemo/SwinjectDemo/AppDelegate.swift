//
//  AppDelegate.swift
//  SwinjectDemo
//
//  Created by Kevin Harris on 6/27/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?

    // Create a Swinject container that registers all the objects we will want to create
    // along with the details on how thier dependancies will be satisfied.
    let container = Container() { c in
        
        c.register(HttpClient.self) { _ in
            HttpClient()
        }
        
        // Note how we add '.inObjectScope(.Container)' to the register call
        // for CloudDatabase. This makes it a singelton.
        c.register(CloudDatabase.self) { r in
            CloudDatabase(httpClient: r.resolve(HttpClient.self)!)
        }.inObjectScope(.container)
        
        c.register(ViewController.self) { r in
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var controller = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController

            controller.cloudDatabase = r.resolve(CloudDatabase.self)
            
            return controller
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        navigationController = UINavigationController()
        
        // Here we use Swinject to instantiate or create the root view controller.
        // To do this, we use our contianer to resolve an instance of
        // ViewController with all of its dependencies injected by the container.
        let viewController: ViewController = container.resolve(ViewController.self)!
        self.navigationController!.pushViewController(viewController, animated: false)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = navigationController
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

