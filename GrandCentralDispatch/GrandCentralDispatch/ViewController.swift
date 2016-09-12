//
//  ViewController.swift
//  GrandCentralDispatch
//
//  Created by Kevin Harris on 1/31/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mySharedValue = 0
    
    var lock = NSLock()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        // As soon as the view loads, we'll create two async dispatches using
        // Grand Central Dispatch.
        //
        
        dispatchAsync1()
        dispatchAsync2()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The job of this test function is to demonstrate the NON-thread-safe
    // way to modify some shared data.
    func unsafeValueIncrement() {
        
        for _ in 0..<1000 {
            
            let v = mySharedValue + 1
            print("mySharedValue = \(v)")
            mySharedValue = v
        }
    }
    
    // The job of this test function is to demonstrate the thread-safe
    // way to modify some shared data.
    func safeValueIncrement() {
        
        for _ in 0..<1000 {
            
            lock.lock()
            
            let v = mySharedValue + 1
            print("mySharedValue = \(v)")
            mySharedValue = v
            
            lock.unlock()
        }
    }
    
    // Notes on calling dispatch_async and dispatch_get_global_queue:
    
    // QOS_CLASS_USER_INTERACTIVE: The user interactive class represents tasks
    // that need to be done immediately in order to provide a nice user experience.
    // Use it for UI updates, event handling and small workloads that require
    // low latency. The total amount of work done in this class during the
    // execution of your app should be small.
    
    // QOS_CLASS_USER_INITIATED: The user initiated class represents tasks that
    // are initiated from the UI and can be performed asynchronously. It should
    // be used when the user is waiting for immediate results, and for tasks
    // required to continue user interaction.
    
    // QOS_CLASS_UTILITY: The utility class represents long-running tasks, typically
    // with a user-visible progress indicator. Use it for computations, I/O,
    // networking, continuous data feeds and similar tasks. This class is designed
    // to be energy efficient.
    
    // QOS_CLASS_BACKGROUND: The background class represents tasks that the user
    // is not directly aware of. Use it for prefetching, maintenance, and other
    // tasks that don’t require user interaction and aren’t time-sensitive.
    
    // While the dispatch_get_global_queue() takes 2 parameters, the second one
    // is always 0. Apple might make use of that second parameter in the future,
    // but for now just put a 0 there. And the usage of [unowned self] in the
    // closure is to avoid strong reference cycles.
    
    func dispatchAsync1() {
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self] in
            
            // Everything inside this closure will be executed on a new background thread.
            
            //self.unsafeValueIncrement()
            self.safeValueIncrement()
            
            print("dispatchAsync1 over.")
        }
    }
    
    func dispatchAsync2() {
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self] in
            
            // Everything inside this closure will be executed on a new background thread.
            
            //self.unsafeValueIncrement()
            self.safeValueIncrement()
            
            print("dispatchAsync2 over.")
            
        }
    }
}

