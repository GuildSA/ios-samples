//
//  ViewController.swift
//  PickerViewMultiWheel
//
//  Created by Kevin Harris on 1/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerDates = [
        
        ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        
        ["1", "2", "3", "4" , "5", "6" , "7", "8" , "9", "10" , "11", "12" , "13", "14",
            "15", "16" , "17", "18", "19", "20" , "21", "22" , "23", "24" , "25", "26",
            "27", "28" , "29", "30" , "31"],
        
        ["2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // From the UIPickerViewDataSource protocol.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
    }
    
    // From the UIPickerViewDataSource protocol.
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerDates[component].count
    }
    
    // From the UIPickerViewDataSource protocol.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerDates[component][row]
    }
    
    // From the UIPickerViewDelegate protocol.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        print("\(pickerDates[component][row])")
    }
}

