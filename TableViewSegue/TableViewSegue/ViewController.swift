//
//  ViewController.swift
//  TableViewSegue
//
//  Created by Kevin Harris on 1/25/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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

    // We can override this method in UIViewController if we want to perform some
    // logic before a Segue actually fires off.
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "mySegue" {
            
            print("Preparing for mySegue!")
            
            // Ask the table view what row is currenlty selected.
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            
            print("User selected section: \((indexPath as NSIndexPath).section), row: \((indexPath as NSIndexPath).row)")
            
            let secondVC = segue.destination as! SecondViewController
            
            // Pass some data to the next View Controller by setting one or more of
            // its properties.
            secondVC.textData = myData[(indexPath as NSIndexPath).row]
        }
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //print("Building a UITableViewCell for \(indexPath.row)")
        
        // Our Custom Cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = myData[(indexPath as NSIndexPath).row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("User selected section: \((indexPath as NSIndexPath).section), row: \((indexPath as NSIndexPath).row)")
        
        // The user has tapped or selected a row in our table view - manually fire our
        // named Segue.
        performSegue(withIdentifier: "mySegue", sender: tableView)
    }
}
