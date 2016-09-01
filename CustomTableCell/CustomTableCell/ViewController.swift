//
//  ViewController.swift
//  CustomTableCell
//
//  Created by Kevin Harris on 1/25/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        
        return myData.count
    }

    // From UITableViewDataSource protocol.
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! MyTableViewCell
        
        let row = indexPath.row
        
        cell.myTextLabel.text = myData[row]
        
        return cell
    }
    
    // From UITableViewDelegate protocol.
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    // From UITableViewDelegate protocol.
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor.redColor()
    }
    
    // From UITableViewDelegate protocol.
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor.clearColor()
    }
    
    // From UITableViewDelegate protocol.
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor.grayColor()
    }
}

