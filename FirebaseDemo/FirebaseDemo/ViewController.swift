//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by Kevin Harris on 9/24/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Don't forget to add a server-side Authentication provider for "Email/Password"
    // to YOUR app's Authentication settings in the Firebase Dashboard! Otherwise,
    // you'll be unable to create new users using an email and password.
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    let EMAIL = "ios_user@gmail.com"
    let PASSWORD = "password"
    
    var databaseRef: DatabaseReference!
    var commentsHandle: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.databaseRef = Database.database().reference()
        
        self.commentsHandle = self.databaseRef.child("comments").observe(.childAdded, with: { (snapshot) -> Void in
            
            let comment = snapshot.value as! [String: Any]
            
            let topicId = comment["topicId"] as! Int
            let authorEmail = comment["authorEmail"] as? String
            let message = comment["message"] as? String
            let timeStamp = comment["timeStamp"] as! Int
            
            let dateFromTimestamp = Date.init(timeIntervalSince1970: Double(timeStamp)/1000.0)
            
            print("Comment: \(snapshot.key), topicId: \(topicId), authorEmail: \"\(authorEmail!)\", message: \"\(message!)\", timeStamp: \(dateFromTimestamp)")
        })
    }
    
    deinit {
        self.databaseRef.child("comments").removeObserver(withHandle: self.commentsHandle)
    }
    
    @IBAction func createUserBtn(_ sender: UIButton) {
        
        print( "createUserBtn called!" )
        
        // In a real app, this is where we would send the user to a register screen to collect their
        // user name and password for registering a new user. For testing purposes, we will simply
        // register a test user using a hard coded user name and password.
        if let user = Auth.auth().currentUser {
            
            print("User is already logged: \(user.debugDescription)");
            
        } else {
            
            Auth.auth().createUser(withEmail: EMAIL, password: PASSWORD) { (user, error) in
                
                if let error = error {
                    
                    print("User failed creation: \(error.localizedDescription)")
                    return
                }
                
                print("User was created: \(user.debugDescription)")
            }
        }
    }
    
    @IBAction func signInUserBtn(_ sender: UIButton) {
        
        print( "signInUserBtn called!" )
        
        if let user = Auth.auth().currentUser {

            print("User is already logged: \(user.debugDescription)");
            
        } else {
            
            Auth.auth().signIn(withEmail: EMAIL, password: PASSWORD) { (user, error) in
                
                if let error = error {
                    
                    print("User failed to login: \(error.localizedDescription)")
                    return
                }
                
                print("User logged in: \(user.debugDescription)")
            }
        }
    }
    
    @IBAction func createUserDataBtn(_ sender: UIButton) {
        
        print( "createUserDataBtn called!" )
        
        if let user = Auth.auth().currentUser {
            
            let data: [String:Any] = [
                "name": "John Doe",
                "address": "6170 Research Rd.",
                "city": "Frisco",
                "state": "TX",
                "zip": "75025"]
            
            self.databaseRef.child("users/\(user.uid)").setValue(data)
        }
    }
    
    @IBAction func updateUserDataBtn(_ sender: UIButton) {
        
        print( "updateUserDataBtn called!" )
        
        if let user = Auth.auth().currentUser {
            
            self.databaseRef.child("users/\(user.uid)/name").setValue("Agent Smith")
        }
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
        
        let data: [String:Any] = [
            "topicId": topicId,
            "message": "Hello, from iOS user!",
            "authorEmail": EMAIL,
            "timeStamp": [".sv": "timestamp"]] // The server will replace this with a timestamp based on the server's time.
        
        self.databaseRef.child("comments").childByAutoId().setValue(data)
    }
    
    @IBAction func findAllCommentsBtn(_ sender: UIButton) {
      
        print( "findAllCommentsBtn called!" )
        
        self.databaseRef.child("comments").observeSingleEvent(of: .value, with: { (snapshot) in
            
            print("Call to observeSingleEvent on 'comments' has completed without error!")
            print("Number of comments found = \(snapshot.childrenCount)")
            
            for child in snapshot.children {
                
                let singleSnapshot = child as! DataSnapshot
                
                let comment = singleSnapshot.value as! [String: Any]
                
                let topicId = comment["topicId"] as! Int
                let authorEmail = comment["authorEmail"] as? String
                let message = comment["message"] as? String
                let timeStamp = comment["timeStamp"] as! Int
                
                let dateFromTimestamp = Date.init(timeIntervalSince1970: Double(timeStamp)/1000.0)
                
                print("Comment: \(snapshot.key), topicId: \(topicId), authorEmail: \"\(authorEmail!)\", message: \"\(message!)\", timeStamp: \(dateFromTimestamp)")
            }

        }) { (error) in
            
            print("Comments were not fetched: \(error.localizedDescription)")
        }
    }
    
    @IBAction func querySomeCommentsBtn(_ sender: UIButton) {
        
        print( "queryCommentsBtn called!" )
        
        // Find all the comments where the topicId is equal to 1!
        let commentsQuery = self.databaseRef.child("comments").queryOrdered(byChild: "topicId").queryEqual(toValue: 1)

        commentsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            
            print("Call to queryOrdered on 'comments' has completed without error!")
            print("Number of comments found = \(snapshot.childrenCount)")
            
            if snapshot.childrenCount == 0 {
                return
            }

            for child in snapshot.children {
                
                let singleSnapshot = child as! DataSnapshot
                
                let comment = singleSnapshot.value as! [String: Any]
                
                let topicId = comment["topicId"] as! Int
                let authorEmail = comment["authorEmail"] as? String
                let message = comment["message"] as? String
                let timeStamp = comment["timeStamp"] as! Int
                
                let dateFromTimestamp = Date.init(timeIntervalSince1970: Double(timeStamp)/1000.0)
                
                print("Comment: \(snapshot.key), topicId: \(topicId), authorEmail: \"\(authorEmail!)\", message: \"\(message!)\", timeStamp: \(dateFromTimestamp)")
            }
            
        }) { (error) in
            
            print("Comments were not fetched: \(error.localizedDescription)")
        }
    }
    
    @IBAction func queryAndUpdateCommentsBtn(_ sender: UIButton) {
        
        print( "queryAndUpdateCommentsBtn called!" )

        // Find all the comments where the topicId is equal to 2!
        // Once we find them - update or change the message on each comment found.
        let commentsQuery = self.databaseRef.child("comments").queryOrdered(byChild: "topicId").queryEqual(toValue: 2)
        
        commentsQuery.observeSingleEvent(of: .value, with: { (snapshot) in
            
            print("Call to queryOrdered on 'comments' has completed without error!")
            print("Number of comments found = \(snapshot.childrenCount)")
            
            if snapshot.childrenCount == 0 {
                return
            }
            
            for child in snapshot.children {
                
                let singleSnapshot = child as! DataSnapshot
                
                self.databaseRef.child("comments/\(singleSnapshot.key)/message").setValue("I have been updated!!!!")
            }
            
        }) { (error) in
            
            print("Comments were not fetched: \(error.localizedDescription)")
        }
    }
    
    @IBAction func removeAllCommentsBtn(_ sender: UIButton) {
        
        print( "removeAllCommentsBtn called!" )
        
        // Find all the Comments!
        self.databaseRef.child("comments").observeSingleEvent(of: .value, with: { (snapshot) in
            
            print("Call to observeSingleEvent on 'comments' has completed without error!")
            print("Number of comments found = \(snapshot.childrenCount)")
            
            if snapshot.childrenCount == 0 {
                return
            }
            
            // Now, remove all the comments we found - one by one!
            for child in snapshot.children {
                
                let singleSnapshot = child as! DataSnapshot
                
                self.databaseRef.child("comments").child(singleSnapshot.key).removeValue()
            }
            
        }) { (error) in
            
            print("Comments were not fetched: \(error.localizedDescription)")
        }
    }
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        
        print( "logoutBtn called!" )
        
        let firebaseAuth = Auth.auth()
        
        do {
            
            try firebaseAuth.signOut()
            
            print("User logged out!")
            
        } catch let signOutError as NSError {
            
            print ("User failed to log out: \(signOutError.localizedDescription)")
        }
    }
}

