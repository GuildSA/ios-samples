//
//  ViewController.swift
//  UserDefaults
//
//  Created by Kevin Harris on 1/26/16.
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

    @IBAction func touchUpInsideRead(sender: UIButton) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let age = defaults.integerForKey("AGE")
        print("AGE = \(age)")
        
        
        let signedIntoFacebook = defaults.boolForKey("SIGNED_INTO_FACEBOOK")
        print("SIGNED_INTO_FACEBOOK = \(signedIntoFacebook)")
        
        
        if let homeTown = defaults.stringForKey("HOME_TOWN") {
            print("HOME_TOWN = \(homeTown)")
        } else {
            print("HOME_TOWN has never been set!")
        }
        
        
        if let phoneNumber = defaults.stringForKey("PHONE_NUMBER") {
            print("PHONE_NUMBER = \(phoneNumber)")
        } else {
            print("PHONE_NUMBER has never been set!")
        }
        
        
        let searchTermsData = defaults.objectForKey("SEARCH_TERMS") as? NSData
        
        if let searchTermsData = searchTermsData {
            
            let searchTermsArray = NSKeyedUnarchiver.unarchiveObjectWithData(searchTermsData) as? [String]
            
            if let searchTermsArray = searchTermsArray {
                
                for searchTerm in searchTermsArray {
                    
                    print(searchTerm)
                }
            }
            
        } else {
            print("SEARCH_TERMS has never been set!")
        }
    }
    
    @IBAction func touchUpInsideWrite(sender: UIButton) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(24, forKey: "AGE")
        
        defaults.setObject(true, forKey: "SIGNED_INTO_FACEBOOK")
        
        defaults.setObject("Dallas", forKey: "HOME_TOWN")
        
        defaults.setObject("555-123-4567", forKey: "PHONE_NUMBER")

        let searchTermsArray = ["Irish Pubs", "Concerts Frisco", "Coffee Shops"]
        let searchTermsData = NSKeyedArchiver.archivedDataWithRootObject(searchTermsArray)
        defaults.setObject(searchTermsData, forKey: "SEARCH_TERMS")
        
        defaults.synchronize()
    }
}

