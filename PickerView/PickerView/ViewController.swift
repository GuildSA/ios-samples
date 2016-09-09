//
//  ViewController.swift
//  PickerView
//
//  Created by Kevin Harris on 1/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickerColors = ["White", "Red", "Green", "Blue", "Purple", "Orange", "Brown", "Yellow"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // From the UIPickerViewDataSource protocol.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    // From the UIPickerViewDataSource protocol.
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerColors.count
    }
    
    // From the UIPickerViewDataSource protocol.
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerColors[row]
    }
    
    // From the UIPickerViewDelegate protocol.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        switch row {
            case 0: self.view.backgroundColor = UIColor.whiteColor()
            case 1: self.view.backgroundColor = UIColor.redColor()
            case 2: self.view.backgroundColor = UIColor.greenColor()
            case 3: self.view.backgroundColor = UIColor.blueColor()
            case 4: self.view.backgroundColor = UIColor.purpleColor()
            case 5: self.view.backgroundColor = UIColor.orangeColor()
            case 6: self.view.backgroundColor = UIColor.brownColor()
            case 7: self.view.backgroundColor = UIColor.yellowColor()
            default: self.view.backgroundColor = UIColor.lightGrayColor()
        }
    }
}

