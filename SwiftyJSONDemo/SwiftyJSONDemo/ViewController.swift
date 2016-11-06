//
//  ViewController.swift
//  SwiftyJSONDemo
//
//  Created by Kevin Harris on 4/27/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        parseJsonTest1()
        parseJsonTest2()
        parseJsonTest3()
        
        createJsonTest1()
        createJsonTest2()
        createJsonTest3()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readFileFromResources(_ fileName: String, fileType: String, encoding: String.Encoding = String.Encoding.utf8) -> String {
        
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
        // Located in: SwiftyJSONDemo/SwiftyJSONDemo/example1.json
        //
        // [ "Cloe", "Bob", "Jennifer", "Robert" ]
        
        let jsonString = readFileFromResources("example1", fileType: ".json")

        let json = JSON.parse(jsonString)
        
// NOTE: If we want more control over the string encoding we can convert the String to a
//       NSData first and then pass the NSDatat object into the JSON initializer.
//
//        let jsonData: NSData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
//        let json = JSON(data: jsonData)
        
        // Do this to get a single name by index.
        let playerName = json.arrayValue[3].stringValue
        
        print("playerName = \(playerName)")
        
        // Do this to for loop through all names.
        for name in json.arrayValue {
            
            print("name = \(name.stringValue)")
        }
        
    }
    
    func parseJsonTest2() {
        
        // Example 2:
        //
        // Located in: SwiftyJSONDemo/SwiftyJSONDemo/example2.json
        //
        // {
        //     "name": "The WarL0rd",
        //     "maps": [ 12, 23, 55 ]
        // }
        
        let jsonString = readFileFromResources("example2", fileType: ".json")
        
        let json = JSON.parse(jsonString)
        
        let name = json["name"].stringValue
        
        print("name = \(name)")
        
        // Do this to get a single map id by index.
        let mapId = json["maps"][0].intValue
        
        print("map id at index 0 = \(mapId)")
        
        // Do this to for loop through all map ids.
        for map in json["maps"].arrayValue {
            
            print("map = \(map.intValue)")
        }
    }
    
    func parseJsonTest3() {
        
        // Example 3:
        //
        // Located in: SwiftyJSONDemo/SwiftyJSONDemo/example3.json
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
        
        let json = JSON.parse(jsonString)
        
        for sword in json["weapons"]["swords"].arrayValue {
            
            let name = sword["name"].stringValue
            let damage = sword["damage"].intValue

            print("name = \(name), damage = \(damage)")
        }
        
        for spear in json["weapons"]["spears"].arrayValue {
            
            let name = spear["name"].stringValue
            let damage = spear["damage"].intValue
            
            print("name = \(name), damage = \(damage)")
        }
    }
    
    func createJsonTest1() {
        
        let namesArray = [ "Cloe", "Bob", "Jennifer", "Robert" ]
        
        //
        // Convert the Swift Array to JSON...
        //
        
        let namesJson = JSON(namesArray)
        let namesJsonString = namesJson.rawString(String.Encoding.utf8, options: [])
        
        print(namesJsonString!)
    }
    
    func createJsonTest2() {
        
        let playerDictionary: [String:Any] = [
            "name": "The WarL0rd",
            "maps": [ 12, 23, 55 ]
        ]

        //
        // Convert the Swift Dictionary to JSON...
        //
        
        let playerJson = JSON(playerDictionary)
        let playerJsonString = playerJson.rawString(String.Encoding.utf8, options: [])
        
        print(playerJsonString!)
    }
    
    func createJsonTest3() {
        
        // Create a Dictionary to hold everything...
        var rootDictionary = [String:[String:Any]]()

        // Create a Dictionary to hold weapons.
        var weaponsDictionary = [String:Any]()
        
        //
        // Create an Array to hold swords...
        //
        
        var swords = Array<[String:Any]>()
        
        var sword1 = [String:Any]()
        sword1["name"] = "Short Sword"
        sword1["damage"] = 25
        swords.append(sword1)
        
        var sword2 = [String:Any]()
        sword2["name"] = "Broad Sword"
        sword2["damage"] = 100
        swords.append(sword2)
        
        var sword3 = [String:Any]()
        sword3["name"] = "Skull Cleaver"
        sword3["damage"] = 150
        swords.append(sword3)

        // Add the swords Array to the weapons dictionary.
        weaponsDictionary["swords"] = swords
        
        //
        // Create an Array to hold spears...
        //
        
        var spears = Array<[String:Any]>()
        
        var spear1 = [String:Any]()
        spear1["name"] = "Wooden Spear"
        spear1["damage"] = 15
        spears.append(spear1)
        
        var spear2 = [String:Any]()
        spear2["name"] = "Iron Spear"
        spear2["damage"] = 20
        spears.append(spear2)
        
        // Add the spears Array to the weapons dictionary.
        weaponsDictionary["spears"] = spears

        // Finally, add the weapons Array to the root dictionary.
        rootDictionary["weapons"] = weaponsDictionary

        //
        // Convert the Swift Dictionaries and Arrays to JSON...
        //
        
        let weaponsJson = JSON(rootDictionary)
        let weaponsJsonString = weaponsJson.rawString(String.Encoding.utf8, options: [])
        
        print(weaponsJsonString!)
    }
}

