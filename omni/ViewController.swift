//
//  ViewController.swift
//  omni
//
//  Created by Michael Farinacci on 8/2/14.
//  Copyright (c) 2014 omni. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    
    @IBOutlet weak var Webview: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initLocationManager()
        loadAddressURL()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        sleep(5)
        var location:CLLocation = locations[locations.count-1] as CLLocation
        println(location.coordinate.latitude)
        println(location.coordinate.longitude)
    }
    
    func loadAddressURL() {
        // Load url in Webview object
        var url = NSURL(string:"http://www.google.com/")
        var req = NSURLRequest(URL:url)
        Webview.loadRequest(req)
    }


}

