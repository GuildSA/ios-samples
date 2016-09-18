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

    var repeatingTimer = Timer()
    var delayedEventTimer = Timer()
    
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
    
    @IBAction func onTouchStart(_ sender: UIButton) {
        
        repeatingTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        
        RunLoop.current.add(repeatingTimer, forMode: RunLoopMode.commonModes)
    }
    
    func count() {
        
        var currentCount:Int = Int(timeLabel.text!)!
        
        currentCount += 1
        
        timeLabel.text = String(currentCount)
    }

    @IBAction func onTouchStop(_ sender: UIButton) {
        
        repeatingTimer.invalidate()
        timeLabel.text = "0"
    }
    
    //
    // Functions for the Delayed Event button...
    //
    
    @IBAction func onTouchDelayedEvent(_ sender: UIButton) {
        
        delayedEventTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(ViewController.delayedEvent), userInfo: nil, repeats: false)
        
        RunLoop.current.add(delayedEventTimer, forMode: RunLoopMode.commonModes)
    }
    
    func delayedEvent() {
        
        let alertController = UIAlertController(title: "Delayed Event", message: "Hey, I waited 3 seconds!", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //
    // Functions for the Timer with Passed Object button...
    //
    
    @IBAction func onTouchTimerWithObject(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ViewController.resetButton(_:)), userInfo: ["theButtonTouched" :sender], repeats: false)
    }
    
    func resetButton(_ timer: Timer) {

        let userInfo = timer.userInfo as! Dictionary<String, AnyObject>
        
        let touchedbutton:UIButton = (userInfo["theButtonTouched"] as! UIButton)
        
        touchedbutton.isEnabled = true
        
        timer.invalidate()
    }
}

