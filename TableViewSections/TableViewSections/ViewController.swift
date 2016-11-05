//
//  ViewController.swift
//  TableViewSections
//
//  Created by Kevin Harris on 9/1/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let sectionTitles = [
        "Section 1: Numbers",
        "Section 2: Letters",
    ]
    
    let dataForSection1 = [
        "1",
        "2",
        "3",
        "4",
        "5"
    ]
    
    let dataForSection2 = [
        "A",
        "B",
        "C",
        "D",
        "E"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return dataForSection1.count
        } else if section == 1 {
            return dataForSection2.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as UITableViewCell
        
        if (indexPath as NSIndexPath).section == 0 {
            cell.textLabel?.text = dataForSection1[(indexPath as NSIndexPath).row]
        } else if (indexPath as NSIndexPath).section == 1 {
            cell.textLabel?.text = dataForSection2[(indexPath as NSIndexPath).row]
        }
        
        return cell
    }
}
