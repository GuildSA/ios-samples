//
//  ViewController.swift
//  NSURLSession
//
//  Created by Kevin Harris on 1/31/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Instead storing the raw JSON data and re-parsing it every time we
    // need to be build a new table view cell, we will parse it once and
    // store the data for each photo as an array of PhotoData structs.
    struct PhotoData {
        
        var thumbnailUrl:String
        var url:String
        var title:String
    }
    
    var photoDataArray: Array<PhotoData> = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let url = NSURL(string: "http://jsonplaceholder.typicode.com/photos")!

//        let urlConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
//        urlConfig.timeoutIntervalForRequest = 10
//        urlConfig.timeoutIntervalForResource = 10
//        let session = NSURLSession(configuration: urlConfig)

        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) {(data, response, error) in
            
            if error == nil {
                
                if let data = try? NSData(contentsOfURL: url, options: []) {
                    
                    do {
                        
                        let jsonArray =
                            try NSJSONSerialization.JSONObjectWithData(data,
                                                                       options:NSJSONReadingOptions.MutableContainers ) as! NSMutableArray
                        
                        //print(jsonArray)
                        //let jsonArray = (JSON as? NSMutableArray)!
                        
                        for arrayEntry in jsonArray {
                            
                            let photoDictionary = arrayEntry as! NSDictionary
                            
                            let thumbnailUrl:String = photoDictionary["thumbnailUrl"] as! String
                            let url:String = photoDictionary["url"] as! String
                            let title:String = photoDictionary["title"] as! String
                            
                            self.photoDataArray.append(PhotoData(thumbnailUrl:thumbnailUrl, url:url, title:title))
                        }
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            // Once we're done loading up the photoDataArray, force the table view to reload so
                            // the cells get rebuilt using the data that we fetched from the test server.
                            self.tableView!.reloadData()
                        }
                        
                    } catch {
                        print("Error!")
                    }
                    
                } else {
                    print("Error!")
                }
                
            }  else {
                print("Error!")
            }
        }

        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // From UITableViewDataSource protocol.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    // From UITableViewDataSource protocol.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photoDataArray.count
    }
    
    // From UITableViewDataSource protocol.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("My Cell", forIndexPath: indexPath) as! MyTableViewCell
        
        let row = indexPath.row
        
        cell.myTextLabel.text = photoDataArray[row].title
        
        cell.myImageView.image = nil
        cell.activityIndicator.hidden = false
        cell.activityIndicator.startAnimating()
        
        let thumbnaillUrl = photoDataArray[row].thumbnailUrl
        
        let url = NSURL(string: thumbnaillUrl)!
        
//        let urlConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
//        urlConfig.timeoutIntervalForRequest = 10
//        urlConfig.timeoutIntervalForResource = 10
//        let session = NSURLSession(configuration: urlConfig)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) {(data, response, error) in
            
            if error == nil {
                
                if let data = try? NSData(contentsOfURL: url, options: []) {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        // We got the image data! Use it to create a UIImage for our cell's
                        // UIImageView. Then, stop the activity spinner.
                        cell.myImageView.image = UIImage(data: data, scale:1)
                        cell.activityIndicator.stopAnimating()
                    }
                    
                } else {
                    print("Error!")
                }
                
            }  else {
                print("Error!")
            }
        }
        
        task.resume()
        
        return cell
    }
}

