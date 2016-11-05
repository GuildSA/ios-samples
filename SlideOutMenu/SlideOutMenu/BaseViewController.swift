//
//  BaseViewController.swift
//  SlideOutMenu
//
//  Created by Kevin Harris on 7/5/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSlideMenuButtonToNav()
    }
    
    private func addSlideMenuButtonToNav() {
        
        let slideMenuBtn = UIButton(type: UIButtonType.system)
        slideMenuBtn.setImage(UIImage(named: "menu"), for: UIControlState())
        slideMenuBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        slideMenuBtn.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControlEvents.touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: slideMenuBtn)
        
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }

    func onSlideMenuButtonPressed(_ sender: UIButton) {
        
        let mainScreen = UIScreen.main
        
        if sender.tag == 1 {
            
            // The MenuViewController has already been slid out - so hide it by sliding it back in!
            
            sender.tag = 0;
            
            if let viewMenuBack = view.subviews.last {
            
                UIView.animate(withDuration: 0.4, animations: {
                    
                        var frameMenu : CGRect = viewMenuBack.frame
                        frameMenu.origin.x = -mainScreen.bounds.size.width
                        viewMenuBack.frame = frameMenu
                        viewMenuBack.layoutIfNeeded()
                        viewMenuBack.backgroundColor = UIColor.clear
                    
                    }, completion: { (finished) -> Void in
                        
                        // Once the MenuViewController has been slid back in - remove it!
                        viewMenuBack.removeFromSuperview()
                    })
            }
            
            return
        }
        
        // There is no MenuViewController, so create a new MenuViewController add 
        // it to the current view and slide it out.
        
        sender.tag = 1
        
        let menuVC = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuVC.slideMenuBtn = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChildViewController(menuVC)
        menuVC.view.layoutIfNeeded()
        
        menuVC.view.frame = CGRect(x: -mainScreen.bounds.size.width, y: 0, width: mainScreen.bounds.size.width, height: mainScreen.bounds.size.height);
        
        UIView.animate(withDuration: 0.4, animations: {
            
                menuVC.view.frame = CGRect(x: 0, y: 0, width: mainScreen.bounds.size.width, height: mainScreen.bounds.size.height);
            
            }, completion: nil)
    }
}

extension BaseViewController: SlideMenuDelegate {
    
    func slideMenuViewControllerRequestedWithName(_ viewControllerName: String) {
        
        let topViewController = self.navigationController!.topViewController!
        let destViewController = self.storyboard!.instantiateViewController(withIdentifier: viewControllerName)
        
        // Do not set a new view controller if it's the one that is already set.
        if topViewController.restorationIdentifier! != destViewController.restorationIdentifier! {
            self.navigationController!.setViewControllers([destViewController], animated: true)
        }
    }
}
