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
        
        Alamofire.request("http://jsonplaceholder.typicode.com/photos", parameters: nil).responseJSON { response in
            
            // The GET request for the JSON data has returned.
            //print(response.request)  // original URL request
            //print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let jsonString = response.result.value {
                
                let jsonArray = jsonString as! NSArray
                
                for arrayEntry in jsonArray {
                    
                    let photoDictionary = arrayEntry as! NSDictionary
                    
                    let thumbnailUrl = photoDictionary["thumbnailUrl"] as! String
                    let url = photoDictionary["url"] as! String
                    let title = photoDictionary["title"] as! String
                    
                    self.photoDataArray.append(PhotoData(thumbnailUrl: thumbnailUrl, url: url, title: title))
                }
                
                // Once we're done loading up the photoDataArray, force the table view to reload so
                // the cells get rebuilt using the data that we fetched from the test server.
                self.tableView.reloadData()
                
            } else {
                print("Failed to get a value from the response.")
            }
        }
        
        // Below is an example of how to pass URL parameters and set a HTTP header
        // for your Alamofire GET request:
        /*
        let parameters: Parameters = [
            "forceExtraction": "false",
            "url": "http://www.melskitchencafe.com/the-best-fudgy-brownies/"
        ]
        
        let headers: HTTPHeaders = [
            "X-Mashape-Key": "TIQVAXmshuSdonewXxzwkF3tp1daPkIjsnL1pX08PH"
        ]
        
        Alamofire.request("https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/extract", parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            // The GET request for the JSON data has returned.
            //print(response.request)  // original URL request
            //print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let jsonString = response.result.value {
                print("jsonString = \(jsonString)")
            } else {
                print("Failed to get a value from the response.")
            }
        }
        */
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
