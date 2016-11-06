//
//  ViewController.swift
//  WebView
//
//  Created by Kevin Harris on 1/27/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Don't forget, we had to add this to the project's Info.plist to
        // load anything at all!
        //  <key>NSAppTransportSecurity</key>
        //    <dict>
        //        <key>NSAllowsArbitraryLoads</key>
        //    <true/>
        //  </dict>
        
        let url = URL (string: "http://www.google.com/");
        let requestObj = URLRequest(url: url!);
        webView.loadRequest(requestObj);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBackBarButton(_ sender: UIBarButtonItem) {
        
        print("Going Back!")
        
        webView.goBack()
    }
    
    @IBAction func onForwardBarButton(_ sender: UIBarButtonItem) {
        
        print("Going Forward!")
        
        webView.goForward()
    }
    
    @IBAction func onLocalHTMLBarButton(_ sender: UIBarButtonItem) {
        
        print("Loading Local HTML!")
        
        let localfilePath = Bundle.main.url(forResource: "local_web_page", withExtension: "html");
        let myRequest = URLRequest(url: localfilePath!);
        webView.loadRequest(myRequest);
    }
}

