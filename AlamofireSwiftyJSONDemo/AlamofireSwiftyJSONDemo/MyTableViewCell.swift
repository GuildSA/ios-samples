//
//  MyTableViewCell.swift
//  AlamofireSwiftyJSONDemo
//
//  Created by Kevin Harris on 1/31/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var myTextLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
