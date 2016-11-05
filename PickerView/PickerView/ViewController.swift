//
//  ViewController.swift
//  PickerView
//
//  Created by Kevin Harris on 1/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pickerColors = ["White", "Red", "Green", "Blue", "Purple", "Orange", "Brown", "Yellow"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerColors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerColors[row]
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch row {
            case 0: self.view.backgroundColor = UIColor.white
            case 1: self.view.backgroundColor = UIColor.red
            case 2: self.view.backgroundColor = UIColor.green
            case 3: self.view.backgroundColor = UIColor.blue
            case 4: self.view.backgroundColor = UIColor.purple
            case 5: self.view.backgroundColor = UIColor.orange
            case 6: self.view.backgroundColor = UIColor.brown
            case 7: self.view.backgroundColor = UIColor.yellow
            default: self.view.backgroundColor = UIColor.lightGray
        }
    }
}

