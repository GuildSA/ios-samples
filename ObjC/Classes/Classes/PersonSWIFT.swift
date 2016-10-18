//
//  PersonSWIFT.swift
//  Classes
//
//  Created by Kevin Harris on 10/17/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class PersonSWIFT : NSObject {

    var name: String
    var age: Int
    
    override init() {
        
        print("New PersonSWIFT Initialized with default values!")
        
        self.name = "Swifty Junior"
        self.age = 2
    }
    
    init(name: String, age: Int) {
        
        print("New PersonSWIFT Initialized with custom values!")
        
        self.name = name
        self.age = age
    }
    
    deinit {
        
        // If required, perform deinitialization here!
        print("PersonSWIFT Deinitialized!")
    }
}
