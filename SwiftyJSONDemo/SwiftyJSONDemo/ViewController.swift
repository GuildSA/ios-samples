//
//  ViewController.swift
//  SwiftyJSONDemo
//
//  Created by Kevin Harris on 4/27/16.
//  Copyright © 2016 guildsa. All rights reserved.
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
}

