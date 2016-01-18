//
//  ViewController.swift
//  UISampler
//
//  Created by Kevin Harris on 1/18/16.
//  Copyright © 2016 guildsa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var aSwitch: UISwitch!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButtonTouchUpInside(sender: UIButton) {
        
        print( "onButtonTouchUpInside")
    }
    
// New developers often assume that they can hook up a UITextField's 
// value changed action like so, but this will not work. You must 
// listen to changes to a UITextField by implementing the 
// UITextFieldDelegate.
    
//    @IBAction func onTextFieldValueChanged(sender: UITextField) {
//        
//        print( "onTextFieldValueChanged = \(sender.text)")
//    }
    
    @IBAction func onSliderValueChanged(sender: UISlider) {
        
        let currentValue = Int(sender.value)

        print( "onSliderValueChanged = \(currentValue)")
    }
    
    @IBAction func onSwitchValueChanged(sender: UISwitch) {
        
        print( "onSwitchValueChanged = \(sender.on)")
    }

    @IBAction func onSegmentValueChagned(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
            case 0:
                print("First selected");
            
            case 1:
                print("Second Segment selected");
            
            default:
                break; 
        }
    }
    
    @IBAction func onStepperValueChanged(sender: UIStepper) {
        print( "onStepperValueChanged = \(sender.value)")
    }
    
    
    
    
    
    
    // The call-backs defined by UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("TextField did end editing method called")
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true;
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called: \(string)")
        return true;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("TextField should return method called")
        
        // Dismiss the iOS keyboard when the user taps the "return" button!
        textField.resignFirstResponder();
        
        return true;
    }
}

