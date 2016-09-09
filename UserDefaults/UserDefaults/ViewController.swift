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
        
        //
        // This first example simply retrieves our user's info back
        // from NSUserDefaults as a series of key/value pairs.
        //
        
        if let name = defaults.stringForKey("NAME") {
            print("NAME = \(name)")
        } else {
            print("NAME has never been set!")
        }
        
        
        let age = defaults.integerForKey("AGE")
        print("AGE = \(age)")
        
        
        if let phoneNumber = defaults.stringForKey("PHONE_NUMBER") {
            print("PHONE_NUMBER = \(phoneNumber)")
        } else {
            print("PHONE_NUMBER has never been set!")
        }
        
        
        if let homeTown = defaults.stringForKey("HOME_TOWN") {
            print("HOME_TOWN = \(homeTown)")
        } else {
            print("HOME_TOWN has never been set!")
        }
        
        
        let signedIntoFacebook = defaults.boolForKey("SIGNED_INTO_FACEBOOK")
        print("SIGNED_INTO_FACEBOOK = \(signedIntoFacebook)")
        
        
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
        
        //
        // This second example retrieves our user's info back
        // from NSUserDefaults as a single User object stored
        // under a single key/value pair.
        //
        // Keep in mind that this will not work for our custom User
        // class unless it implements the NSCoding protocol.
        //
        
        if let data = defaults.objectForKey("USER") as? NSData {
            let user = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! User
            
            print("user.name = \(user.name)")
            print("user.age = \(user.age)")
            print("user.phoneNumber = \(user.phoneNumber)")
            print("user.homeTown = \(user.homeTown)")
            print("user.signedIntoFacebook = \(user.signedIntoFacebook)")
            
            for searchTerm in user.searchTerms {
                print(searchTerm)
            }
        }
    }
    
    @IBAction func touchUpInsideWrite(sender: UIButton) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //
        // This first example simply writes our user's info out to
        // NSUserDefaults as a series of key/value pairs.
        //
        
        defaults.setObject("Mark", forKey: "NAME")
        defaults.setObject(24, forKey: "AGE")
        defaults.setObject("555-123-4567", forKey: "PHONE_NUMBER")
        defaults.setObject("Dallas", forKey: "HOME_TOWN")
        defaults.setObject(true, forKey: "SIGNED_INTO_FACEBOOK")
        
        let searchTermsArray = ["Irish Pubs", "Concerts Frisco", "Coffee Shops"]
        let searchTermsData = NSKeyedArchiver.archivedDataWithRootObject(searchTermsArray)
        defaults.setObject(searchTermsData, forKey: "SEARCH_TERMS")
        
        //
        // This second example stores our user's info in an instance
        // of a User object and then we write out this object to
        // NSUserDefaults under just a single key/value pair.
        //
        // Keep in mind that this will not work for our custom User
        // class unless it implements the NSCoding protocol.
        //
        
        let user = User(name: "Jennifer",
                        age: 31,
                        phoneNumber: "555-123-0001",
                        homeTown: "Plano",
                        signedIntoFacebook: true,
                        searchTerms: ["Book Store", "Starbucks", "Sushi"])
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        defaults.setObject(data, forKey: "USER")
        
        defaults.synchronize()
    }
}

