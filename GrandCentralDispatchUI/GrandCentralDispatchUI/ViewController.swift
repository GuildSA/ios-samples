//
//  ViewController.swift
//  GrandCentralDispatchUI
//
//  Created by Kevin Harris on 1/31/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("!!! didReceiveMemoryWarning !!!")
    }
    
    func allocateAndConvertData() {
        
        // We're now going to create a huge amount work that would most likley 
        // stall the the Main UI thread.
        var myHugeArray = [String]()
        
        for _ in 0...10000 {
            myHugeArray.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        }
        
        for _ in 0...1000 {
            
            for i in 0..<(myHugeArray.count) {
                myHugeArray[i] = myHugeArray[i].lowercased()
            }
            
            for i in 0..<(myHugeArray.count) {
                myHugeArray[i] = myHugeArray[i].uppercased()
            }
        }
    }
    
    @IBAction func onAllocateMemory(_ sender: UIButton) {
        
        let startTime = Date()
        
        allocateAndConvertData()
        
        let endTime = Date()
        
        let elapsedTime: Double = endTime.timeIntervalSince(startTime) // Difference in seconds (double)
        
        let alert = UIAlertController(title: "Time Report",
                                      message: String(format: "Memory allocation and data conversion took %.2f seconds.", elapsedTime),
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onAllocateMemoryUsingGCD(_ sender: UIButton) {
        
        let startTime = Date()
        
        // This call to dispatch_async() is being used to off load some work onto a 
        // background worker thread so it won't slow down the Main UI thread.
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async { [unowned self] in
        
            self.allocateAndConvertData()
            
            // This call to dispatch_async() is being used to exucute some UI related code back
            // on the Main UI thread where our app started. Without this call to dispatch_async
            // our app would crash as soon as it tried to modify the UI in any way!
            DispatchQueue.main.async { [unowned self] in
                
                let endTime = Date()
                
                let elapsedTime: Double = endTime.timeIntervalSince(startTime) // Difference in seconds (double)

                let alert = UIAlertController(title: "Time Report",
                                              message: String(format: "Memory allocation and data conversion took %.2f seconds.", elapsedTime),
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

