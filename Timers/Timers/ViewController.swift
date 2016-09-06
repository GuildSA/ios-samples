//
//  ViewController.swift
//  Timers
//
//  Created by Kevin Harris on 1/31/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!

    var repeatingTimer = NSTimer()
    var delayedEventTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //
    // Functions for the Start and Stop buttons...
    //
    
    @IBAction func onTouchStart(sender: UIButton) {
        
        repeatingTimer = NSTimer(timeInterval: 1.0, target: self, selector: "count", userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(repeatingTimer, forMode: NSRunLoopCommonModes)
    }
    
    func count() {
        
        var currentCount:Int = Int(timeLabel.text!)!
        
        currentCount += 1
        
        timeLabel.text = String(currentCount)
    }

    @IBAction func onTouchStop(sender: UIButton) {
        
        repeatingTimer.invalidate()
        timeLabel.text = "0"
    }
    
    //
    // Functions for the Delayed Event button...
    //
    
    @IBAction func onTouchDelayedEvent(sender: UIButton) {
        
        delayedEventTimer = NSTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.delayedEvent), userInfo: nil, repeats: false)
        
        NSRunLoop.currentRunLoop().addTimer(delayedEventTimer, forMode: NSRunLoopCommonModes)
    }
    
    func delayedEvent() {
        
        let alertController = UIAlertController(title: "Delayed Event", message: "Hey, I waited 3 seconds!", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //
    // Functions for the Timer with Passed Object button...
    //
    
    @IBAction func onTouchTimerWithObject(sender: UIButton) {
        
        sender.enabled = false
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ViewController.resetButton(_:)), userInfo: ["theButtonTouched" :sender], repeats: false)
    }
    
    func resetButton(timer: NSTimer) {

        let userInfo = timer.userInfo as! Dictionary<String, AnyObject>
        
        let touchedbutton:UIButton = (userInfo["theButtonTouched"] as! UIButton)
        
        touchedbutton.enabled = true
        
        timer.invalidate()
    }
}

