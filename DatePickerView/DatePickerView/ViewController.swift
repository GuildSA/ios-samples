//
//  ViewController.swift
//  DatePickerView
//
//  Created by Kevin Harris on 9/9/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        // The quickest way to see the date is to dump the date's description.
        print("Date: \(sender.date.description)")
        
        print("--------------------------------")
        
        // If want more control over the string's format, we can use a NSDateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let strDate = dateFormatter.string(from: sender.date)
        print("Date: \(strDate)")
        
        print("--------------------------------")
        
        // Or, if we want to compleltly pull the data apart, we can 
        // extract the time components using the calendar and date
        let calendar = sender.calendar
        let date = sender.date
        let components = calendar?.dateComponents([.month, .day, .year, .hour, .minute], from: date)
        
        let month = components?.month
        let day = components?.day
        let year = components?.year
        let hour = components?.hour
        let minute = components?.minute
        
        print("Month = \(month)")
        print("Day = \(day)")
        print("Year = \(year)")
        print("Hour = \(hour)")
        print("Minute = \(minute)")
    }
}

