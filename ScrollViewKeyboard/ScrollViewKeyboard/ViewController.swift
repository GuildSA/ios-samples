//
//  ViewController.swift
//  ScrollViewKeyboard
//
//  Created by Kevin Harris on 10/11/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

// This sample is based on this article:
// https://spin.atomicobject.com/2014/03/05/uiscrollview-autolayout-ios/

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    weak var activeField: UITextField?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Set observers on the UIKeyboardDidShow and UIKeyboardWillHide events.
        // This will allow us to manually scroll the UIScrollView if the keyboard
        // covers the currently active UITextField.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillBeHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        
        // Remove observers if this view controller is being destroyed.
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardDidShow(_ notification: Notification) {
        
        // Check if the activeField is non-nil and whether or not we can get access to the keyboard's size info.
        if let activeField = self.activeField, let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            // Use the keyboard's height to create new insets for our UIScrollView.
            // The insets add padding around the edges of the scroll view content.
            // This is typically done at the top and bottom so controllers and toolbars
            // don’t interfere with the content.
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            // Next, we'll get access to the frame of the root view and calculate what
            // its height would be if it was reduced or shortened by the keyboard's height.
            var shortenedViewFrame = self.view.frame
            shortenedViewFrame.size.height -= keyboardSize.size.height
            
            // Lastly, if the shortened view frame does not contain the UITextField that
            // is currently active, the active UITextField is NOT visible and we will
            // need to scroll the UIScrollView up till the UITextField does become visible.
            if !shortenedViewFrame.contains(activeField.frame.origin) {
                
                // This call will scroll so rect is just visible (based on nearest edges).
                // Nothing will happen if rect completely visible.
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(_ notification: Notification) {
        
        // Move the UIScrollView back to its normal position.
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func generate(_ sender: UIButton) {
        
        print("Generate Grumpy Cat Meme!")
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard!
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.activeField = nil
    }
}
