//
//  ViewController.swift
//  OperationQueue
//
//  Created by Kevin Harris on 2/1/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mySharedValue = 0
    
    var lock = NSLock()
    
    var queue = Foundation.OperationQueue()
    
    
    class MyCustomOperation : Operation {
        
        var vc: ViewController
        
        init(vc: ViewController) {
            self.vc = vc
        }
        
        override func start() {
            super.start()
        }
        
        override func main() {
            
            //vc.unsafeValueIncrement()
            vc.safeValueIncrement()
            
            print("NSOperation over.")
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //
        // As soon as the view loads, we'll start two operations using NSOperationQueue:
        //
        
        launchOperation1()
        launchOperation2()
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
    
    // It's also possible to lock access to a variable by using calls to
    // objc_sync_enter and objc_sync_exit where you pass in some instance
    // object to lock on. Here's a version of function above which uses
    // objc_sync_enter and objc_sync_exit instead of a NSLock:
    //    func incrementValue1000() {
    //
    //        for _ in 0..<1000 {
    //
    //            objc_sync_enter(self)
    //
    //            let v = value + 1
    //            print("value = \(v)")
    //            value = v
    //
    //            objc_sync_exit(self)
    //        }
    //    }
    
    func launchOperation1() {
        
        let myCustomOperation1 = MyCustomOperation(vc: self)
        
        queue.addOperation(myCustomOperation1)
    }
    
    func launchOperation2() {
        
        let myCustomOperation2 = MyCustomOperation(vc: self)
        
        queue.addOperation(myCustomOperation2)
    }
}

