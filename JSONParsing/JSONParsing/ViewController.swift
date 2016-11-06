//
//  ViewController.swift
//  JSONParsing
//
//  Created by Kevin Harris on 4/27/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
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
    
    func readFileFromResources(fileName: String, fileType: String, encoding: String.Encoding = String.Encoding.utf8) -> String {
        
        let absoluteFilePath = Bundle.main.path(forResource: fileName, ofType: fileType)
        
        if let absoluteFilePath = absoluteFilePath {
            
            if let fileData = try? Data.init(contentsOf: URL(fileURLWithPath: absoluteFilePath)) {
                
                if let fileAsString = NSString(data: fileData, encoding: encoding.rawValue) {
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
        
        let jsonString = readFileFromResources(fileName: "example1", fileType: ".json")

        let jsonData: Data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)!

        let playerNamesArray = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSArray

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
        
        let jsonString = readFileFromResources(fileName: "example2", fileType: ".json")
        
        let jsonData: Data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let playerDataDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
        
        let name = playerDataDictionary.value(forKey: "name")
        
        print("name = \(name!)")
        
        let maps = playerDataDictionary["maps"] as! NSArray
        
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
        
        let jsonString = readFileFromResources(fileName: "example3", fileType: ".json")
        
        let jsonData: Data = jsonString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let dictionary = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! NSDictionary
        
        let weaponsDictionary = dictionary.value(forKey: "weapons") as! NSDictionary
        
        let swords = weaponsDictionary.value(forKey: "swords") as! NSArray
        
        for sword in swords {
            
            let swordDictionary = sword as! NSDictionary
            
            let name = swordDictionary["name"] as! String
            let damage = swordDictionary["damage"] as! Int
            
            print("name = \(name), damage = \(damage)")
        }
        
        let spears = weaponsDictionary.value(forKey: "spears") as! NSArray
        
        for spear in spears {
            
            let spearDictionary = spear as! NSDictionary
            
            let name = spearDictionary["name"] as! String
            let damage = spearDictionary["damage"] as! Int
            
            print("name = \(name), damage = \(damage)")
        }
    }
}

