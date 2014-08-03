//
//  ViewController.swift
//  omni
//
//  Created by Michael Farinacci on 8/2/14.
//  Copyright (c) 2014 omni. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var Webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadAddressURL()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadAddressURL() {
        // Load url in Webview object
        var url = NSURL(string:"http://www.google.com/")
        var req = NSURLRequest(URL:url)
        Webview.loadRequest(req)
    }


}

