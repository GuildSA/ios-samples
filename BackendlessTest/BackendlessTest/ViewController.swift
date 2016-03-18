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


    @IBAction func onTouchUpInsideCreateBtn(sender: UIButton) {
        
        print( "onTouchUpInsideCreateBtn called!" )
        
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
        
        backendless.userService.login( USER_NAME, password:PASSWORD,
            
            response: { ( user : BackendlessUser!) -> () in
                print("User logged in: \(user.objectId)")
            },
            
            error: { ( fault : Fault!) -> () in
                print("User failed to login: \(fault)")
            }
        )
    }
    
    @IBAction func onTouchUpInsideCreateCommentBtn(sender: UIButton) {
        
        print( "onTouchUpInsideCreateCommentBtn called!" )
        
        let comment = Comment()
        comment.message = "Hello, from iOS user!"
        comment.authorEmail = USER_NAME
        
        backendless.data.save( comment,
            
            response: { ( entity : AnyObject!) -> () in
                
                let comment = entity as! Comment
                
                print("Comment was saved: \(comment.objectId!), message: \(comment.message)")
            },
            
            error: { ( fault : Fault!) -> () in
                print("Comment failed to save: \(fault)")
            }
        )
    }
    
    @IBAction func onTouchUpInsideFetchCommentsBtn(sender: UIButton) {
      
        let dataStore = self.backendless.persistenceService.of(Comment.ofClass())
        
        dataStore.find(
            
            { ( comments : BackendlessCollection!) -> () in
                print("Comments have been fetched:")
                
                for comment in comments.data {
                    print("Comment: \(comment.objectId), message: \(comment.message)")
                }
            },
            
            error: { ( fault : Fault!) -> () in
                print("Comments were not fetched: \(fault)")
            }
        )
    }
}

