//
//  ViewController.swift
//  Keyboard
//
//  Created by Kevin Harris on 1/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //
    // UITextFieldDelegate
    //
    
    // Method gets called when the textfield editing will start
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        print("textFieldShouldBeginEditing")
        
        return true
    }
    
    // Method gets called when the textfield editing started already
    func textFieldDidBeginEditing(textField: UITextField) {
        
        print("textFieldDidBeginEditing")
    }
    
    // Method gets called when the textfield editing will end
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        
        print("textFieldShouldEndEditing")
        
        return true
    }
    
    // Method gets called when typing every single character (or whole words if the user selects an auto completion)
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        print("textField:shouldChangeCharactersInRange = \(string)")
        
        return true
    }
    
    // Method gets called when the textfield editing ended already
    func textFieldDidEndEditing(textField: UITextField) {
        
        print("textFieldDidEndEditing")
    }
    
    // Method gets called when the keyboard return key pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        
        myTextField.resignFirstResponder()
        
        return true
    }
    
    //
    // UITextViewDelegate
    //
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        print("textViewShouldBeginEditing")
        
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        print("textViewDidBeginEditing")
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        print("textViewDidEndEditing")
    }
    
    func textViewDidChange(textView: UITextView) {
        
        print("textViewDidChange")
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        
        print("textViewDidChangeSelection")
        
        print("selectedRange = \(textView.selectedRange)")
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        
        print("textViewDidChangeSelection")
        
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {

        print("textFieldShouldClear")

        return true
    }
    
    @IBAction func onTouchUpInsideDone(sender: UIButton) {
        
        // Dismiss the keyboard
        myTextView.resignFirstResponder()
    }

}

