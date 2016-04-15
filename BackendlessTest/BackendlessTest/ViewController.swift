//
//  ViewController.swift
//  BackendlessTest
//
//  Created by Kevin Harris on 3/16/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let USER_NAME = "ios_user@gmail.com"
    let PASSWORD = "password"
    
    let backendless = Backendless.sharedInstance()
    
    class Comment: NSObject {
        
        var objectId: String?
        var message: String?
        var authorEmail: String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTouchUpInsideRegisterBtn(sender: UIButton) {
        
        print( "onTouchUpInsideRegisterBtn called!" )
        
        // In a real app, this where we would send the user to a register screen to collect their
        // user name and password for registering a new user. For testing purposes, we will simply
        // register a test user using a hard coded user name and password.
        let user: BackendlessUser = BackendlessUser()
        user.email = USER_NAME
        user.password = PASSWORD
        
        backendless.userService.registering( user,
            
            response: { ( registeredUser : BackendlessUser!) -> () in
                print("User was registered: \(registeredUser.objectId)")
            },
            
            error: { ( fault : Fault!) -> () in
                print("User failed to register: \(fault)")
            }
        )
    }
    
    @IBAction func onTouchUpInsideLoginBtn(sender: UIButton) {
        
        print( "onTouchUpInsideLoginBtn called!" )
        
        // First, check if the user is already logged in. If they are, we don't need to
        // ask them to login again.
        let isValidUser = backendless.userService.isValidUserToken()
        
        if(isValidUser != nil && isValidUser != 0) {
            
            // The user has a valid user token so we know for sure the user is already logged!
            print("User is already logged: \(isValidUser.boolValue)");
            
        } else {
            
            // If we were unable to find a valid user token, the user is not logged and they'll
            // need to login. In a real app, this where we would send the user to a login screen to
            // collect their user name and password for the login attempt. For testing purposes,
            // we will simply login a test user using a hard coded user name and password.
            
            // Please note for a user to stay logged in, we had to make a call to
            // backendless.userService.setStayLoggedIn(true) and pass true.
            // This asks that the user should stay logged in by storing or caching the user's login
            // information so future logins can be skipped next time the user launches the app.
            // For this sample this call was made in the AppDelegate in didFinishLaunchingWithOptions.
            
            backendless.userService.login( USER_NAME, password:PASSWORD,
                
                response: { ( user : BackendlessUser!) -> () in
                    print("User logged in: \(user.objectId)")
                },
                
                error: { ( fault : Fault!) -> () in
                    print("User failed to login: \(fault)")
                }
            )
        }
    }
    
    @IBAction func onTouchUpInsideCreateCommentBtn(sender: UIButton) {
        
        print( "onTouchUpInsideCreateCommentBtn called!" )
        
        let comment = Comment()
        comment.message = "Hello, from iOS user!"
        comment.authorEmail = USER_NAME
        
        backendless.data.save( comment,
            
            response: { ( entity : AnyObject!) -> () in
                
                let comment = entity as! Comment
                
                print("Comment was saved: \(comment.objectId!), message: \(comment.message!)")
            },
            
            error: { ( fault : Fault!) -> () in
                print("Comment failed to save: \(fault)")
            }
        )
    }
    
    @IBAction func onTouchUpInsideFetchCommentsBtn(sender: UIButton) {
      
        print( "onTouchUpInsideFetchCommentsBtn called!" )
        
        let dataStore = self.backendless.persistenceService.of(Comment.ofClass())
        
        dataStore.find(
            
            { ( comments : BackendlessCollection!) -> () in
                print("Comments have been fetched:")
                
                for comment in comments.data {
                    
                    let comment = comment as! Comment
                    
                    print("Comment: \(comment.objectId!), message: \(comment.message!)")
                }
            },
            
            error: { ( fault : Fault!) -> () in
                print("Comments were not fetched: \(fault)")
            }
        )
    }
}

