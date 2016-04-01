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
        
        guard let name = decoder.decodeObjectForKey("name") as? String,
            let phoneNumber = decoder.decodeObjectForKey("phoneNumber") as? String,
            let homeTown = decoder.decodeObjectForKey("homeTown") as? String,
            let searchTerms = decoder.decodeObjectForKey("searchTerms") as? [String]
            else { return nil }
        
        self.init(
            name: name,
            age: decoder.decodeIntegerForKey("age"),
            phoneNumber: phoneNumber,
            homeTown: homeTown,
            signedIntoFacebook: decoder.decodeBoolForKey("signedIntoFacebook"),
            searchTerms: searchTerms
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeInt(Int32(self.age), forKey: "age")
        coder.encodeObject(self.phoneNumber, forKey: "phoneNumber")
        coder.encodeObject(self.homeTown, forKey: "homeTown")
        coder.encodeBool(self.signedIntoFacebook, forKey: "signedIntoFacebook")
        coder.encodeObject(self.searchTerms, forKey: "searchTerms")
    }
}
