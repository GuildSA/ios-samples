//
//  ViewController.swift
//  BackendlessImageUpload
//
//  Created by Kevin Harris on 9/22/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Don't forget to replace the App's ID and Secret Key in AppDelegate with YOUR own
    // from YOUR Backendless Dashboard!
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    let EMAIL = "ios_user@gmail.com" // Doubles as User Name
    let PASSWORD = "password"
    
    let backendless = Backendless.sharedInstance()!
    
    var fullSizeUrl: String?
    var thumbnailUrl: String?

    @IBOutlet weak var uploadSpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    @IBOutlet weak var downloadFullSizeBtn: UIButton!
    @IBOutlet weak var fullSizeImageView: UIImageView!
    @IBOutlet weak var fullSizeSpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var downloadThumbnailBtn: UIButton!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var thumbnailSpinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        uploadSpinner.isHidden = true
        fullSizeSpinner.isHidden = true
        thumbnailSpinner.isHidden = true
        
        let isValidUser = backendless.userService.isValidUserToken()
        if isValidUser != nil && isValidUser != 0 {
            uploadBtn.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkForBackendlessSetup() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.APP_ID == "<replace-with-your-app-id>" || appDelegate.SECRET_KEY == "<replace-with-your-secret-key>" {
            
            let alertController = UIAlertController(title: "Backendless Error",
                                                    message: "To use this sample you must register with Backendless, create an app, and replace the APP_ID and SECRET_KEY in the AppDelegate with the values from your app's settings.",
                                                    preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        
        checkForBackendlessSetup()
        
        print( "registerBtn called!" )
        
        // In a real app, this where we would send the user to a register screen to collect their
        // user name and password for registering a new user. For testing purposes, we will simply
        // register a test user using a hard coded user name and password.
        let user: BackendlessUser = BackendlessUser()
        user.email = EMAIL as NSString!
        user.password = PASSWORD as NSString!
        
        backendless.userService.registering( user,
            
            response: { (user: BackendlessUser?) -> Void in
                print("User was registered: \(user?.objectId)")
            },
            
            error: { (fault: Fault?) -> Void in
                print("User failed to register: \(fault)")
            }
        )
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        
        checkForBackendlessSetup()
        
        print( "loginBtn called!" )
        
        // First, check if the user is already logged in. If they are, we don't need to
        // ask them to login again.
        let isValidUser = backendless.userService.isValidUserToken()
        
        if isValidUser != nil && isValidUser != 0 {
            
            // The user has a valid user token so we know for sure the user is already logged!
            print("User is already logged: \(isValidUser?.boolValue)");
            
        } else {
            
            // If we were unable to find a valid user token, the user is not logged in and they'll
            // need to login. In a real app, this where we would send the user to a login screen to
            // collect their user name and password for the login attempt. For testing purposes,
            // we will simply login a test user using a hard coded user name and password.
            
            // Please note for a user to stay logged in, we had to make a call to
            // backendless.userService.setStayLoggedIn(true) and pass true.
            // This asks that the user should stay logged in by storing or caching the user's login
            // information so future logins can be skipped next time the user launches the app.
            // For this sample this call was made in the AppDelegate in didFinishLaunchingWithOptions.
            
            backendless.userService.login( EMAIL, password: PASSWORD,
                
                response: { (user: BackendlessUser?) -> Void in
                    print("User logged in: \(user!.objectId)")
                    
                    self.uploadBtn.isEnabled = true
                },
                
                error: { (fault: Fault?) -> Void in
                    print("User failed to login: \(fault)")
                }
            )
        }
    }
    
    @IBAction func uploadImageBtn(_ sender: UIButton) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func downloadFullSizeImageBtn(_ sender: UIButton) {
        
        fullSizeSpinner.isHidden = false
        fullSizeSpinner.startAnimating()
        
        let url = URL(string: fullSizeUrl!)!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    let data = try Data(contentsOf: url, options: [])
                    
                    DispatchQueue.main.async {
                        
                        // We got the image data! Use it to create a UIImage for our cell's
                        // UIImageView.
                        self.fullSizeImageView.image = UIImage(data: data)
                        
                        self.fullSizeSpinner.startAnimating()
                        self.fullSizeSpinner.isHidden = true
                    }
                    
                } catch {
                    print("NSData Error: \(error)")
                }
                
            } else {
                print("NSURLSession Error: \(error)")
            }
        })
        
        task.resume()
    }
    
    @IBAction func downloadThumbnailImageBtn(_ sender: UIButton) {
        
        thumbnailSpinner.isHidden = false
        thumbnailSpinner.startAnimating()
        
        let url = URL(string: thumbnailUrl!)!
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    let data = try Data(contentsOf: url, options: [])
                    
                    DispatchQueue.main.async {
                        
                        // We got the image data! Use it to create a UIImage for our cell's
                        // UIImageView.
                        self.thumbnailImageView.image = UIImage(data: data)
                        
                        self.thumbnailSpinner.startAnimating()
                        self.thumbnailSpinner.isHidden = true
                    }
                    
                } catch {
                    print("NSData Error: \(error)")
                }
                
            } else {
                print("NSURLSession Error: \(error)")
            }
        })
        
        task.resume()
    }
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        
        checkForBackendlessSetup()
        
        print( "logoutBtn called!" )
        
        // First, check if the user is actually logged in.
        let isValidUser = backendless.userService.isValidUserToken()
        
        if isValidUser != nil && isValidUser != 0 {
            
            // If they are currently logged in - go ahead and log them out!
            
            backendless.userService.logout( { (user: Any!) -> Void in
                    print("User logged out!")
                },
                                           
                error: { (fault: Fault?) -> Void in
                    print("User failed to log out: \(fault)")
                }
            )
            
        } else {
            
            // If we were unable to find a valid user token, the user is already logged out.
            
            print("User is already logged out: \(isValidUser?.boolValue)");
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        uploadSpinner.isHidden = false
        uploadSpinner.startAnimating()
        
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let fullSizeImage = info[UIImagePickerControllerOriginalImage] as! UIImage

        let uuid = NSUUID().uuidString
        //print("\(uuid)")
        
        //
        // Upload thumbnail image
        //

        let size = fullSizeImage.size.applying(CGAffineTransform(scaleX: 0.5, y: 0.5))
        let hasAlpha = false
        let scale: CGFloat = 0.1
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        fullSizeImage.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let thumbnailImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let thumbnailData = UIImageJPEGRepresentation(thumbnailImage!, 1.0);
        
        backendless.fileService.upload(
            "photos/\(backendless.userService.currentUser.objectId!)/thumb_\(uuid).jpg",
            content: thumbnailData,
            overwrite:true,
            response: { (uploadedFile: BackendlessFile?) -> Void in
                print("Thumbnail image uploaded: \(uploadedFile?.fileURL)")

                self.thumbnailUrl = (uploadedFile?.fileURL)!
                
                self.downloadThumbnailBtn.isEnabled = true
            },
            
            error: { (fault: Fault?) -> Void in
                print("Server reported an error: \(fault)")
        })

        //
        // Upload full size image
        //
        
        let fullSizeData = UIImageJPEGRepresentation(fullSizeImage, 0.2);
        
        backendless.fileService.upload(
            "photos/\(backendless.userService.currentUser.objectId!)/full_\(uuid).jpg",
            content: fullSizeData,
            overwrite:true,
            response: { (uploadedFile: BackendlessFile?) -> Void in
                print("Full size image uploaded to: \(uploadedFile?.fileURL)")
                
                self.fullSizeUrl = (uploadedFile?.fileURL)!
                
                self.downloadFullSizeBtn.isEnabled = true
                
                self.uploadSpinner.stopAnimating()
                self.uploadSpinner.isHidden = true
            },
            
            error: { (fault: Fault?) -> Void in
                print("Server reported an error: \(fault)")
        })
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}

