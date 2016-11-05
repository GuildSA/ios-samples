//
//  ViewController.swift
//  Keyboard
//
//  Created by Kevin Harris on 1/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

    @IBAction func onTouchUpInsideDone(_ sender: UIButton) {
        
        // Dismiss the keyboard
        myTextView.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {

    // Method gets called when the textfield editing will start
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldBeginEditing")
        
        return true
    }
    
    // Method gets called when the textfield editing started already
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("textFieldDidBeginEditing")
    }
    
    // Method gets called when the textfield editing will end
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldEndEditing")
        
        return true
    }
    
    // Method gets called when typing every single character (or whole words if the user selects an auto completion)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("textField:shouldChangeCharactersInRange = \(string)")
        
        return true
    }
    
    // Method gets called when the textfield editing ended already
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print("textFieldDidEndEditing")
    }
    
    // Method gets called when the keyboard return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        
        myTextField.resignFirstResponder()
        
        return true
    }
}

extension ViewController: UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        print("textViewShouldBeginEditing")
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        print("textViewDidBeginEditing")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        print("textViewDidEndEditing")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        print("textViewDidChange")
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
        print("textViewDidChangeSelection")
        
        print("selectedRange = \(textView.selectedRange)")
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        print("textViewDidChangeSelection")
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldClear")
        
        return true
    }
}

