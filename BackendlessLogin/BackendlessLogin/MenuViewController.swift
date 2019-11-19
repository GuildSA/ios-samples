//
//  MenuViewController.swift
//  BackendlessLogin
//
//  Created by Kevin Harris on 3/16/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    let backendless = Backendless.sharedInstance()!
    
    class Comment: NSObject {
        
        var objectId: String?
        var message: String?
        var authorEmail: String?
        var topicId: Int = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0 ? true: false
    }
    
    @IBAction func createCommentBtn(_ sender: UIButton) {

        print( "createCommentBtn called!" )
        
        var topicId: Int
        
        if randomBool() {
            topicId = 1
        } else {
            topicId = 2
        }
        
        let comment = Comment()
        comment.message = "Hello, from iOS user!"
        comment.authorEmail = backendless.userService.currentUser.email as String?
        comment.topicId = topicId
        
        backendless.data.save( comment,
            
            response: { (entity: Any?) -> Void in
                
                let comment = entity as! Comment
                
                print("Comment was saved: \(comment.objectId!), topicId: \(comment.topicId), message: \"\(comment.message!)\"")
            },
            
            error: { (fault: Fault?) -> Void in
                print("Comment failed to save: \(String(describing: fault))")
            }
        )
    }
    
    @IBAction func findAllCommentsBtn(_ sender: UIButton) {
      
        print( "findAllCommentsBtn called!" )
        
        let dataStore = backendless.persistenceService.of(Comment.ofClass())
        
        dataStore?.find(
            
            { (data: [Any]?) -> Void in

                let comments = data as! [Comment]
                
                print("Find attempt on all Comments has completed without error!")
                print("Number of Comments found = \(comments.count)")
                
                for comment in comments {
                    
                    print("Comment: \(comment.objectId!), topicId: \(comment.topicId), message: \"\(comment.message!)\"")
                }
            },
            
            error: { (fault: Fault?) -> Void in
                print("Comments were not fetched: \(String(describing: fault))")
            }
        )
    }
    
    @IBAction func querySomeCommentsBtn(_ sender: UIButton) {
        
        print( "queryCommentsBtn called!" )
        
        let dataStore = self.backendless.data.of(Comment.ofClass())
        
        let queryBuilder = DataQueryBuilder()
        queryBuilder?.setWhereClause("topicId = 1")
        
        // Note: If you actually know the objectId of the object you want, you can set it like so.
        //queryBuilder?.setWhereClause("objectId = 'D5134896-8270-EFD8-FFCB-EE27F38DA200'")
        
        // Find all the Comments where the topicId is equal to a certain number!
        // Once we find them - update or change the message on each comment found.
        dataStore?.find( queryBuilder,
                        
            response:{ (data: [Any]?) -> Void in
               
               let comments = data as! [Comment]
                
                print("Find attempt on Comments with a certain topicId has completed without error!")
                print("Number of Comments found = \(comments.count)")
                
                if comments.count > 0 {
                    
                    for comment in comments {
                        
                        print("Comment: \(comment.objectId!), topicId: \(comment.topicId), message: \"\(comment.message!)\"")
                    }
                    
                } else {
                    print("No Comments were fetched using the whereClause '\(String(describing: queryBuilder?.getWhereClause()))'")
                }
            },
                        
            error: { ( fault: Fault?) -> Void in
                print("Comments were not fetched: \(String(describing: fault))")
            }
        )
    }
    
    @IBAction func queryAndUpdateCommentsBtn(_ sender: UIButton) {
        
        print( "queryAndUpdateCommentsBtn called!" )

        let dataStore = self.backendless.data.of(Comment.ofClass())
        
        let queryBuilder = DataQueryBuilder()
        queryBuilder?.setWhereClause("topicId = 2")
        
        // Note: If you actually know the objectId of the object you want, you can set it like so.
        //queryBuilder?.setWhereClause("objectId = 'D5134896-8270-EFD8-FFCB-EE27F38DA200'")
        
        // Find all the Comments where the topicId is equal to a certain number!
        // Once we find them - update or change the message on each comment found.
        dataStore?.find( queryBuilder,
                         
             response:{ (data: [Any]?) -> Void in
                
                let comments = data as! [Comment]
                
                print("Find attempt on Comments with a certain topicId has completed without error!")
                print("Number of Comments found = \(comments.count)")
                
                if comments.count > 0 {
                    
                    for comment in comments {
                        
                        print("Comment: \(comment.objectId!), topicId: \(comment.topicId), message: \"\(comment.message!)\"")
                        
                        // Update or change the message for each comment we found.
                        comment.message = "I have been updated!!!!"
                        
                        self.backendless.data.save( comment,
                                                    
                            response: { (entity: Any?) -> Void in
                                
                                let comment = entity as! Comment
                                
                                print("Comment was updated: \(comment.objectId!), topicId: \(comment.topicId), message: \"\(comment.message!)\"")
                            },
                            
                            error: { (fault: Fault?) -> Void in
                                print("Comment failed to save: \(String(describing: fault))")
                            }
                        )
                    }
                    
                } else {
                    print("No Comments were fetched using the whereClause '\(String(describing: queryBuilder?.getWhereClause()))'")
                }
            },
         
            error: { ( fault: Fault?) -> Void in
                print("Comments were not fetched: \(String(describing: fault))")
            }
        )
    }
    
    @IBAction func removeAllCommentsBtn(_ sender: UIButton) {
        
        print( "removeAllCommentsBtn called!" )
        
        let dataStore = backendless.persistenceService.of(Comment.ofClass())
        
        // Find all the Comments!
        dataStore?.find(
            
            { (data: [Any]?) -> Void in

                let comments = data as! [Comment]
                
                print("Find attempt on all Comments has completed without error!")
                print("Number of Comments found = \(comments.count)")
                
                // Now, remove all the Comments we found - one by one!
                for comment in comments {
                    
                    print("Remove Comment: \(comment.objectId!)")
                    
                    self.backendless.data.remove(comment,
                                                 
                        response: { (entity: Any?) -> Void in
                            print("One Comment has been removed: \(String(describing: entity))")
                        },
                        
                        error: { (fault: Fault?) -> Void in
                            print("Server reported an error on attempted removal: \(String(describing: fault))")
                        }
                    )
                }
            },
            
            error: { ( fault: Fault?) -> Void in
                print("Comments were not fetched: \(String(describing: fault))")
            }
        )
    }
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        
        print( "logoutBtn called!" )
        
        BackendlessManager.sharedInstance.logoutUser(
            
            completion: {
                self.performSegue(withIdentifier: "gotoLoginFromMenu", sender: sender)
            },
            
            error: { message in
                print("User failed to log out: \(message)")
            })
    }
}

