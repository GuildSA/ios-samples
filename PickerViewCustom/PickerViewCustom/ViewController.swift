//
//  ViewController.swift
//  PickerViewCustom
//
//  Created by Kevin Harris on 8/11/16.
//  Copyright © 2016 Kevin Harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pickerData = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIPickerViewDataSource  {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print("\(pickerData[row])")
    }
    
    // This method will get called when the UIPickerView creates its UILabels.
    // This is our opportunity to modify or customize the UILabels.
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel : UILabel
        
        if let label = view as? UILabel {
            
            pickerLabel = label
            
        } else {
            
            // If view is nil, no UIView is available to recycle, so create a new one!
            pickerLabel = UILabel()

            // Programmaticly set the label's background!
            let hue = CGFloat(row)/CGFloat(pickerData.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        
        let titleData = pickerData[row]

        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.black])

        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
}


