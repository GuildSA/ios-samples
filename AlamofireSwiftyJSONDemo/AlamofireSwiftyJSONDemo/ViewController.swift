//
//  ViewController.swift
//  AlamofireSwiftyJSONDemo
//
//  Created by Kevin Harris on 1/31/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// This sample uses Alamofire, an HTTP networking library written in Swift, to
// asynchronously pulled down some JSON data that lists a bunch of test photos.
// We then use Alamofire again to load each of those images asynchronously into
// an UIIMageView of our custom cell type called, MyTableViewCell.
// https://github.com/Alamofire/Alamofire

// Once this sample pulls down the JSON data using Alamofire, we will then use
// another library called SwiftyJSON to parse the JSON.
// https://github.com/SwiftyJSON/SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Instead storing the raw JSON data and re-parsing it every time we
    // need to be build a new table view cell, we will parse it once and
    // store the data for each photo as an array of PhotoData structs.
    struct PhotoData {
        
        var thumbnailUrl: String
        var url: String
        var title: String
    }
    
    var photoDataArray = [PhotoData]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // As soon as our view controller loads, use Alamofire to get the JSON data that
        // describes all the test photos that we can load.
        loadJSONData()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSONData() {
        
        // Fake Online REST API for Testing and Prototyping
        //http://jsonplaceholder.typicode.com/
        
        Alamofire.request("http://jsonplaceholder.typicode.com/photos", parameters: nil).responseString { response in
            
            // The GET request for the JSON data has returned.
            
            //print(response.request)  // original URL request
            //print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let jsonString = response.result.value {
                
                let json = JSON.parse(jsonString)
                
                for arrayEntry in json.arrayValue {

                    let thumbnailUrl = arrayEntry["thumbnailUrl"].stringValue
                    let url = arrayEntry["url"].stringValue
                    let title = arrayEntry["title"].stringValue

                    self.photoDataArray.append(PhotoData(thumbnailUrl: thumbnailUrl, url: url, title: title))
                }
                
                // Once we're done loading up the photoDataArray, force the table view to reload so
                // the cells get rebuilt using the data that we fetched from the test server.
                self.tableView.reloadData()
                
            } else {
                print("Failed to get a value from the response.")
            }
        }
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return photoDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        let row = (indexPath as NSIndexPath).row
        
        cell.myTextLabel.text = photoDataArray[row].title
        
        cell.myImageView.image = nil
        cell.activityIndicator.isHidden = false
        cell.activityIndicator.startAnimating()
        
        let thumbnaillUrl = photoDataArray[row].thumbnailUrl
        
        Alamofire.request(thumbnaillUrl).response { response in
            
            if response.error == nil {
                
                // We got the image data! Use it to create a UIImage for our cell's
                // UIImageView. Then, stop the activity spinner.
                cell.myImageView.image = UIImage(data: response.data!)
                cell.activityIndicator.stopAnimating()
                
            } else {
                print("Failed to load image from URL \(response.request) with error \(response.error)")
            }
        }
        
        return cell
    }
}


