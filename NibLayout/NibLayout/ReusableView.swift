//
//  ReusableView.swift
//  NibLayout
//
//  Created by Kevin Harris on 1/15/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ReusableView: UIView {
    
    @IBOutlet var view: UIView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("ReusableView", owner: self, options: nil)
        
        self.addSubview(view)
    }

    @IBAction func onTouchBtn(_ sender: UIButton) {
        print("Button touched!")
    }
}
