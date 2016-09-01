//
//  ViewController.swift
//  TableView
//
//  Created by Kevin Harris on 1/25/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let myData = [
        "Some data 1",
        "Some data 2",
        "Some data 3",
        "Some data 4",
        "Some data 5",
        "Some data 6",
        "Some data 7",
        "Some data 8",
        "Some data 9",
        "Some data 10",
        "Some data 11",
        "Some data 12",
        "Some data 13",
        "Some data 14",
        "Some data 15",
        "Some data 16",
        "Some data 17",
        "Some data 18",
        "Some data 19",
        "Some data 20"
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // This sample sets the dataSource and delegate in the StoryBoard, but you may
        // see some code samples where they're set here in code like so.
        //tableView.delegate = self
        //tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // From UITableViewDataSource protocol.
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // We only have one section in our table view.
        return 1
    }
    
    // From UITableViewDataSource protocol.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The number of rows we want for out table view is directly related to
        // the number of data entries we have in our data array.
        return myData.count
    }
    
    // From UITableViewDataSource protocol.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // This will try to reuse a cell if one can be found. If not, a new cell will be created.
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        
        // Find out what index or row we're building for and use that to fetch the corresponding data.
        let row = indexPath.row
        
        cell.textLabel?.text = myData[row]
        
        // Finally, return the cell so it can be placed into the table view.
        return cell
    }
}
