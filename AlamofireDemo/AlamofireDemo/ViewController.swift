//
//  ViewController.swift
//  AlamofireDemo
//
//  Created by Kevin Harris on 1/31/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import Alamofire

// This sample uses Alamofire, an HTTP networking library written in Swift, to
// asynchronously pulled down some JSON data that lists a bunch of test photos.
// We then use Alamofire again to load each of those images asynchronously into
// an UIIMageView of our custom cell type called, MyTableViewCell.
// https://github.com/Alamofire/Alamofire

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
        
        // As soon as our view controller loads, use Alamofire to get the JSON data that
        // describes all the test photos that we can load.
        
        // Fake Online REST API for Testing and Prototyping
        //http://jsonplaceholder.typicode.com/
        
        Alamofire.request(.GET, "http://jsonplaceholder.typicode.com/photos", parameters: nil)
            .responseJSON { response in
                
                // The GET request for the JSON data has returned.
                
                //print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    
                    //print("JSON: \(JSON)")
                    //print("JSON[0] = \(JSON[0])")
                    
                    let jsonArray = (JSON as? NSMutableArray)!
                    
                    for arrayEntry in jsonArray {
                        
                        let photoDictionary = arrayEntry as! NSDictionary
                        
                        let thumbnailUrl:String = photoDictionary["thumbnailUrl"] as! String
                        let url:String = photoDictionary["url"] as! String
                        let title:String = photoDictionary["title"] as! String
                        
                        self.photoDataArray.append(PhotoData(thumbnailUrl:thumbnailUrl, url:url, title:title))
                    }
                    
                    // Once we're done loading up the photoDataArray, force the table view to reload so
                    // the cells get rebuilt using the data that we fetched from the test server.
                    self.tableView!.reloadData()
                }
        }
        
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
        
        Alamofire.request(.GET, thumbnaillUrl).response { (request, response, data, error) in
            
            //print(request)
            //print(response)
            //print(data)
            //print(error)
            
            if(error == nil) {
                
                // We got the image data! Use it to create a UIImage for our cell's
                // UIImageView. Then, stop the activity spinner.
                cell.myImageView.image = UIImage(data: data!, scale:1)
                cell.activityIndicator.stopAnimating()
                
            } else {
                
                print("Failed to load image from URL \(request) with error \(error)")
            }
        }
        
        return cell
    }
}
