//
//  ViewController.swift
//  WebView
//
//  Created by Kevin Harris on 1/27/16.
//  Copyright © 2016 guildsa. All rights reserved.
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
        
        let url = NSURL (string: "http://www.google.com/");
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBackBarButton(sender: UIBarButtonItem) {
        
        print("Going Back!")
        
        webView.goBack()
    }
    
    @IBAction func onForwardBarButton(sender: UIBarButtonItem) {
        
        print("Going Forward!")
        
        webView.goForward()
    }
    
    @IBAction func onLocalHTMLBarButton(sender: UIBarButtonItem) {
        
        print("Loading Local HTML!")
        
        let localfilePath = NSBundle.mainBundle().URLForResource("local_web_page", withExtension: "html");
        let myRequest = NSURLRequest(URL: localfilePath!);
        webView.loadRequest(myRequest);
    }
}

