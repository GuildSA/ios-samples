//
//  ViewController.swift
//  PickerView
//
//  Created by Kevin Harris on 1/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var colorPickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIPickerView!
    
    var pickerColors = ["White", "Red", "Green", "Blue", "Purple", "Orange", "Brown"];
    
    var pickerDates = [
        ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
        ["1", "2", "3", "4" , "5", "6" , "7", "8" , "9", "10" , "11", "12" , "13", "14" , "15",
        "16" , "17", "18", "19", "20" , "21", "22" , "23", "24" , "25", "26" , "27", "28" , "29", "30" , "31"],
        ["2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025"]];
    
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
        
        if(pickerView == colorPickerView) {
            return 1
        } else if(pickerView == datePickerView) {
            return 3
        }
        
        return 1
    }
    
    // From the UIPickerViewDataSource protocol.
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == colorPickerView) {
            return pickerColors.count
        } else if(pickerView == datePickerView) {
            return pickerDates[component].count
        }
        
        return 0
    }
    
    // From the UIPickerViewDataSource protocol.
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == colorPickerView) {
            return pickerColors[row]
        } else if(pickerView == datePickerView) {
            return pickerDates[component][row]
        }
        
        return ""
    }
    
    // From the UIPickerViewDelegate protocol.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if(pickerView == colorPickerView) {

            if(row == 0) {
                self.view.backgroundColor = UIColor.whiteColor()
            } else if(row == 1) {
                self.view.backgroundColor = UIColor.redColor()
            } else if(row == 2) {
                self.view.backgroundColor = UIColor.greenColor()
            } else if(row == 3) {
                self.view.backgroundColor = UIColor.blueColor()
            } else if(row == 4) {
                self.view.backgroundColor = UIColor.purpleColor()
            } else if(row == 5) {
                self.view.backgroundColor = UIColor.orangeColor()
            } else if(row == 6) {
                self.view.backgroundColor = UIColor.brownColor()
            } else {
                self.view.backgroundColor = UIColor.lightGrayColor()
            }
            
        } else if(pickerView == datePickerView) {
            
            print("\(pickerDates[component][row])")
        }
    }
}

