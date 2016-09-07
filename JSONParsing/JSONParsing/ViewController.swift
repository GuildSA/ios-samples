//
//  ViewController.swift
//  JSONParsing
//
//  Created by Kevin Harris on 4/27/16.
//  Copyright © 2016 guildsa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        parseJsonTest1()
        parseJsonTest2()
        parseJsonTest3()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readFileFromResources(fileName: String, fileType: String, encoding: NSStringEncoding = NSUTF8StringEncoding) -> String {
        
        let absoluteFilePath = NSBundle.mainBundle().pathForResource(fileName, ofType: fileType)
        
        if let absoluteFilePath = absoluteFilePath {
            
            if let fileData = NSData.init(contentsOfFile: absoluteFilePath) {
                
                if let fileAsString = NSString(data: fileData, encoding: encoding) {
                    return fileAsString as String
                } else {
                    print("readFileFromResources failed on: \(fileName). Failed to convert data to String!")
                    return  ""
                }
                
            } else {
                print("readFileFromResources failed on: \(fileName). Failed to load any data!")
                return  ""
            }
        }

        print("readFileFromResources failed on: \(fileName). File does not exist!")
        return  ""
    }
    
    func parseJsonTest1() {

        // Example 1:
        //
        // Located in: JsonParsing/JsonParsing/example1.json
        //
        // [ "Cloe", "Bob", "Jennifer", "Robert" ]
        
        let jsonString = readFileFromResources("example1", fileType: ".json")

        let jsonData: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!

        let playerNamesArray = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! NSArray

        for playerName in playerNamesArray {
            
            let playerName = playerName as! String
            
            print("\(playerName)")
        }
    }
    
    func parseJsonTest2() {
        
        // Example 2:
        //
        // Located in: JsonParsing/JsonParsing/example2.json
        //
        // {
        //     "name": "The WarL0rd",
        //     "maps": [ 12, 23, 55 ]
        // }
        
        let jsonString = readFileFromResources("example2", fileType: ".json")
        
        let jsonData: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        
        let playerDataDictionary = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! NSDictionary
        
        let name = playerDataDictionary.valueForKey("name")
        
        print("name = \(name!)")
        
        let maps = playerDataDictionary.valueForKey("maps") as! NSArray
        
        for map in maps {
            
            let map = map as! Int
            
            print("map = \(map)")
        }
    }
    
    func parseJsonTest3() {
        
        // Example 3:
        //
        // Located in: JsonParsing/JsonParsing/example3.json
        //
        // {
        //     "weapons": {
        //         "swords": [
        //             {
        //                 "name": "Short Sword",
        //                 "damage": 25
        //             },
        //             {
        //                 "name": "Broad Sword",
        //                 "damage": 100
        //             },
        //             {
        //                 "name": "Skull Cleaver",
        //                 "damage": 150
        //             }
        //         ],
        //         "spears": [
        //             {
        //                 "name": "Wooden Spear",
        //                 "damage": 15
        //             },
        //             {
        //                 "name": "Iron Spear",
        //                 "damage": 20
        //             }
        //         ]
        //     }
        // }
        
        let jsonString = readFileFromResources("example3", fileType: ".json")
        
        let jsonData: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
        
        let dictionary = try! NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! NSDictionary
        
        let weaponsDictionary = dictionary.valueForKey("weapons") as! NSDictionary
        
        let swords = weaponsDictionary.valueForKey("swords") as! NSArray
        
        for sword in swords {
            
            let name = sword.valueForKey("name") as! String
            let damage = sword.valueForKey("damage") as! Int
            
            print("name = \(name), damage = \(damage)")
        }
        
        let spears = weaponsDictionary.valueForKey("spears") as! NSArray
        
        for spear in spears {
            
            let name = spear.valueForKey("name") as! String
            let damage = spear.valueForKey("damage") as! Int
            
            print("name = \(name), damage = \(damage)")
        }
        
// NOTE: Some deveolpers might cast spear to a NSDictionary so they can 
// pass the key name into [] insted of using valueForKey().
//        for spear in spears {
//            
//            let spear = spear as! NSDictionary
//            
//            let name = spear["name"] as! String
//            let damage = spear["damage"] as! Int
//            
//            print("name = \(name), damage = \(damage)")
//        }
    }
}

