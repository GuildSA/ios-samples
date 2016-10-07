//
//  BackendlessManager.swift
//  BackendlessLogin
//
//  Created by Kevin Harris on 9/26/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import Foundation

// The BackendlessManager class is a Singleton that wraps up all the 
// state and functionality related to Backendless.

class BackendlessManager {
    
    // This gives access to the one and only instance.
    static let sharedInstance = BackendlessManager()
    
    // This prevents others from using the default '()' initializer for this class.
    private init() {}
    
    
    let backendless = Backendless.sharedInstance()!
    
    let VERSION_NUM = "v1"
    
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Replace these with YOUR App's ID and Secret Key from YOUR Backendless Dashboard!
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    let APP_ID = "<replace-with-your-app-id>"
    let SECRET_KEY = "<replace-with-your-secret-key>"
    
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // For Facebook login to work, open the project's info.plist and replace the string
    // "REPLACE_WITH_YOUR_APP_ID" with YOUR App's ID from YOUR Backendless Dashboard!
    // Below is an example of what you're looking for in the project's info.plist:
    /*
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>backendlessREPLACE_WITH_YOUR_APP_ID</string>
            </array>
        </dict>
    </array>
    */
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    func initApp() {
    
        // First, init Backendless!
        backendless.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        backendless.userService.setStayLoggedIn(true)
    }
    
    func isUserLoggedIn() -> Bool {
        
        let isValidUser = backendless.userService.isValidUserToken()
        
        if isValidUser != nil && isValidUser != 0 {
            return true
        } else {
            return false
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping () -> (), error: @escaping (String) -> ()) {
    
        let user: BackendlessUser = BackendlessUser()
        user.email = email as NSString!
        user.password = password as NSString!
        
        backendless.userService.registering( user,
                                              
            response: { (user: BackendlessUser?) -> Void in
            
                print("User was registered: \(user?.objectId)")
                completion()
            },
          
            error: { (fault: Fault?) -> Void in
                print("User failed to register: \(fault)")
                error((fault?.message)!)
            }
        )
    }
    
    func loginUser(email: String, password: String, completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        backendless.userService.login( email, password: password,
                                        
            response: { (user: BackendlessUser?) -> Void in
                print("User logged in: \(user!.objectId)")
                completion()
            },
            
            error: { (fault: Fault?) -> Void in
                print("User failed to login: \(fault)")
                error((fault?.message)!)
            })
    }
    
    func loginViaFacebook(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        backendless.userService.easyLogin(
            
            withFacebookFieldsMapping: ["email":"email"], permissions: ["email"],
            
            response: {(result : NSNumber?) -> () in
                print ("Result: \(result)")
                completion()
            },
            
            error: { (fault : Fault?) -> () in
                print("Server reported an error: \(fault)")
                error((fault?.message)!)
        })
    }
    
    func handleOpen(open url: URL, completion: @escaping () -> (), error: @escaping () -> ()) {
        
        print("handleOpen: url scheme = \(url.scheme)")

        let user = backendless.userService.handleOpen(url)
        
        if user != nil {
            print("handleOpen: user = \(user)")
            completion()
        } else {
            error()
        }
    }
    
    func logoutUser(completion: @escaping () -> (), error: @escaping (String) -> ()) {
        
        // First, check if the user is actually logged in.
        if isUserLoggedIn() {
            
            // If they are currently logged in - go ahead and log them out!
            
            backendless.userService.logout( { (user: Any!) -> Void in
                    print("User logged out!")
                    completion()
                },
                                            
                error: { (fault: Fault?) -> Void in
                    print("User failed to log out: \(fault)")
                    error((fault?.message)!)
                })
            
        } else {
            
            print("User is already logged out!");
            completion()
        }
    }
}
