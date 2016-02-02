//
//  ViewController.swift
//  GrandCentralDispatch
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
    
    @IBAction func onTouchComputePrimes(sender: UIButton) {
        
        print(primesUpTo(100))
        //print(primesUpTo(50000))
    }
    
    /// @param numbers must be an array of sequential numbers, not smaller than 2
    func sieve(numbers: [UInt]) -> [UInt] {
        
        if numbers.isEmpty { return [] }
        let p = numbers[0]
        assert(p > 1, "Numbers must start at 2 or higher!")
        let rest = numbers[1..<numbers.count]
        return [p] + sieve(rest.filter { $0 % p > 0 })
    }
    
    func primesUpTo(max: UInt) -> [UInt] {
        
        return [1] + sieve(Array(2...max))
    }
    
    @IBAction func onTouchLoadURLData(sender: UIButton) {
        
        loadDataFromURL()
    }
    
    func loadDataFromURL() {
        
        // This call to dispatch_async() is being used to push our code that attempts to load
        // some data over HTTP into a background thread.
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [unowned self] in
            
            // Everything inside this closure will be executed on a new backgrond thread, which
            // will allow the main thread that processes input and draws the UI to keep working.
            
            if let url = NSURL(string: "http://jsonplaceholder.typicode.com/posts") {
                
                if let data = try? NSData(contentsOfURL: url, options: []) {
                    
                    do {
                        let jsonArray = try NSJSONSerialization.JSONObjectWithData(data,
                            options:NSJSONReadingOptions.MutableContainers ) as! NSMutableArray
                        
                        print(jsonArray)
                        
                    } catch {
                        self.showError()
                    }
                    
                } else {
                    self.showError()
                }
                
            } else {
                self.showError()
            }
        }
    }
    
    func showError() {
        
        // This call to dispatch_async() is being used to exucute some UI related code back 
        // on the Main UI thread where our app started. Without this call to dispatch_async
        // our app would crash as soon as it tried to modify the UI in any way!
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            
            let alert = UIAlertController(title: "Loading Error",
                message: "There was a problem loading the URL!", preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("!!! didReceiveMemoryWarning !!!")
    }

}

