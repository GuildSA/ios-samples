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
    
    @IBAction func touchUpInsideRead(_ sender: UIButton) {
        
        let defaults = Foundation.UserDefaults.standard
        
        //
        // This first example simply retrieves our user's info back
        // from NSUserDefaults as a series of key/value pairs.
        //
        
        if let name = defaults.string(forKey: "NAME") {
            print("NAME = \(name)")
        } else {
            print("NAME has never been set!")
        }
        
        
        let age = defaults.integer(forKey: "AGE")
        print("AGE = \(age)")
        
        
        if let phoneNumber = defaults.string(forKey: "PHONE_NUMBER") {
            print("PHONE_NUMBER = \(phoneNumber)")
        } else {
            print("PHONE_NUMBER has never been set!")
        }
        
        
        if let homeTown = defaults.string(forKey: "HOME_TOWN") {
            print("HOME_TOWN = \(homeTown)")
        } else {
            print("HOME_TOWN has never been set!")
        }
        
        
        let signedIntoFacebook = defaults.bool(forKey: "SIGNED_INTO_FACEBOOK")
        print("SIGNED_INTO_FACEBOOK = \(signedIntoFacebook)")
        
        
        let searchTermsData = defaults.object(forKey: "SEARCH_TERMS") as? Data
        
        if let searchTermsData = searchTermsData {
            
            let searchTermsArray = NSKeyedUnarchiver.unarchiveObject(with: searchTermsData) as? [String]
            
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
        
        if let data = defaults.object(forKey: "USER") as? Data {
            let user = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            
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
    
    @IBAction func touchUpInsideWrite(_ sender: UIButton) {
        
        let defaults = Foundation.UserDefaults.standard
        
        //
        // This first example simply writes our user's info out to
        // NSUserDefaults as a series of key/value pairs.
        //
        
        defaults.set("Mark", forKey: "NAME")
        defaults.set(24, forKey: "AGE")
        defaults.set("555-123-4567", forKey: "PHONE_NUMBER")
        defaults.set("Dallas", forKey: "HOME_TOWN")
        defaults.set(true, forKey: "SIGNED_INTO_FACEBOOK")
        
        let searchTermsArray = ["Irish Pubs", "Concerts Frisco", "Coffee Shops"]
        let searchTermsData = NSKeyedArchiver.archivedData(withRootObject: searchTermsArray)
        defaults.set(searchTermsData, forKey: "SEARCH_TERMS")
        
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
        
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        defaults.set(data, forKey: "USER")
        
        defaults.synchronize()
    }
}

