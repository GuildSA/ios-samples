//
//  ViewController.swift
//  TableViewStutter
//
//  Created by Kevin Harris on 1/31/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

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
        
        loadJSONData()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadJSONData() {

        if let url = URL(string: "http://jsonplaceholder.typicode.com/photos") {
            
            do {
                
                let data = try Data(contentsOf: url, options: [])
                
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                
                for arrayEntry in jsonArray {
                    
                    let photoDictionary = arrayEntry as! NSDictionary
                    
                    let thumbnailUrl = photoDictionary["thumbnailUrl"] as! String
                    let url = photoDictionary["url"] as! String
                    let title = photoDictionary["title"] as! String
                    
                    self.photoDataArray.append(PhotoData(thumbnailUrl: thumbnailUrl, url: url, title: title))
                }
                
                // Once we're done loading up the photoDataArray, force the table view to reload so
                // the cells get rebuilt using the data that we fetched from the test server.
                tableView.reloadData()
                
            } catch {
                print("NSData or NSJSONSerialization Error: \(error)")
            }
            
        } else {
            print("NSURL Error")
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
        
        if let url = URL(string: thumbnaillUrl) {
            
            do {
                
                let data = try Data(contentsOf: url, options: [])
                
                // We got the image data! Use it to create a UIImage for our cell's
                // UIImageView. Then, stop the activity spinner.
                cell.myImageView.image = UIImage(data: data)
                cell.activityIndicator.stopAnimating()
                
            } catch {
                print("NSData Error: \(error)")
            }
            
        } else {
            print("NSURL Error")
        }
        
        return cell
    }
}

