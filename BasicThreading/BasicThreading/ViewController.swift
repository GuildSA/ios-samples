//
//  ViewController.swift
//  BasicThreading
//
//  Created by Kevin Harris on 2/1/16.
//  Copyright © 2016 guildsa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var value = 0
    var lock = NSLock()
    
    var queue = NSOperationQueue()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        //
        // As soon as the view loads, we'll start two threads:
        //
        
        // The first thread will be created and launched by using NSThread.
        testNSThread()
        
        // The second thread will be created by declaring a custom NSOperation
        // instance and launching it via a NSOperationQueue
        testNSOperationQueue()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The job of this test function is to simply increment value 1000 times.
    func incrementValue1000() {
        
        for _ in 0..<1000 {
            
            lock.lock()
            
            let v = value + 1
            print("value = \(v)")
            value = v
            
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
    
    func testNSThread() {
        
        let myThread = NSThread(target:self, selector:#selector(threadMain(_:)), object:self)
        myThread.start()
        
        // If you don't need access to the thread instance, you can call
        // NSThread.detachNewThreadSelector instead.
        //NSThread.detachNewThreadSelector("threadMain:", toTarget:self, withObject:self)
    }
    
    func threadMain(sender: ViewController) {
        
        sender.incrementValue1000()
        
        print("NSThread over.")
    }
    
    func testNSOperationQueue() {
        
        let myCustomOperation = MyCustomOperation(vc: self)
        
        queue.addOperation(myCustomOperation)
    }
    
    class MyCustomOperation : NSOperation {
        
        var vc:ViewController
        
        init(vc:ViewController) {
            self.vc = vc
        }
        
        override func start() {
            super.start()
        }
        
        override func main() {
            
            vc.incrementValue1000()
            
            print("NSOperation over.")
        }
    }
}

