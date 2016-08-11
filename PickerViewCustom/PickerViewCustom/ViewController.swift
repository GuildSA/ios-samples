//
//  ViewController.swift
//  PickerViewCustom
//
//  Created by Kevin Harris on 8/11/16.
//  Copyright © 2016 Kevin Harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerData = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
    
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
        
        return pickerData.count
    }
    
    // From the UIPickerViewDataSource protocol.
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
    }
    
    // From the UIPickerViewDelegate protocol.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("\(pickerData[row])")
    }
    
    // This method will get called when the UIPickerView creates its UILabels.
    // This is our opportunity to modify or customize the UILabels.
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var pickerLabel = view as! UILabel!
        
        if pickerLabel == nil {
            
            // If pickerLabel is nil, no UIView is available to recycle, so create a new one!
            pickerLabel = UILabel()
            
            // Programmaticly set the label's background!
            let hue = CGFloat(row)/CGFloat(pickerData.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        
        let titleData = pickerData[row]
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .Center
        
        return pickerLabel
    }
}


