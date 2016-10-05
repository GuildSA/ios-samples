//
//  CloudDatabase.swift
//  SwinjectDemo
//
//  Created by Kevin Harris on 6/27/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import Foundation

class CloudDatabase {
    
    let httpClient: HttpClient
    var userDataCache: String = ""
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func getUserData(_ userId: String) -> String {
    
        // Pretend that we had to do some setup here to talk to our cloud database host.
    
        userDataCache = httpClient.sendGetRequest("https://cloudserver.com/" + userId);
        
        return userDataCache
    }
    
    func getUserDataCached() -> String {
    
        return userDataCache
    }
}
