//
//  User.swift
//  UserDefaults
//
//  Created by Kevin Harris on 4/1/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import Foundation

// If our User class implements the NSCoding protocol, our objects
// of this type can be stored into NSUserDefaults using the 
// NSKeyedArchiver like other complex types such as Arrays.
class User: NSObject, NSCoding {
    
    var name: String
    var age: Int
    var phoneNumber: String
    var homeTown: String
    var signedIntoFacebook: Bool
    var searchTerms: [String]

    // Memberwise initializer
    init(name: String, age: Int, phoneNumber: String, homeTown: String, signedIntoFacebook: Bool, searchTerms: [String]) {
        
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
        self.homeTown = homeTown
        self.signedIntoFacebook = signedIntoFacebook
        self.searchTerms = searchTerms
    }
    
    required convenience init?(coder decoder: NSCoder) {
        
        guard let name = decoder.decodeObject(forKey: "name") as? String,
            let phoneNumber = decoder.decodeObject(forKey: "phoneNumber") as? String,
            let homeTown = decoder.decodeObject(forKey: "homeTown") as? String,
            let searchTerms = decoder.decodeObject(forKey: "searchTerms") as? [String]
            else { return nil }
        
        self.init(
            name: name,
            age: decoder.decodeInteger(forKey: "age"),
            phoneNumber: phoneNumber,
            homeTown: homeTown,
            signedIntoFacebook: decoder.decodeBool(forKey: "signedIntoFacebook"),
            searchTerms: searchTerms
        )
    }
    
    func encode(with coder: NSCoder) {
        
        coder.encode(self.name, forKey: "name")
        coder.encodeCInt(Int32(self.age), forKey: "age")
        coder.encode(self.phoneNumber, forKey: "phoneNumber")
        coder.encode(self.homeTown, forKey: "homeTown")
        coder.encode(self.signedIntoFacebook, forKey: "signedIntoFacebook")
        coder.encode(self.searchTerms, forKey: "searchTerms")
    }
}
