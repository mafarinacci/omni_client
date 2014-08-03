//
//  ViewController.swift
//  omni
//
//  Created by Michael Farinacci on 8/2/14.
//  Copyright (c) 2014 omni. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, NSURLConnectionDelegate {

    let locationManager:CLLocationManager = CLLocationManager()
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var lat:String = "0"
    var lon:String = "0"

    @IBOutlet weak var Webview: UIWebView!
    lazy var data = NSMutableData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initLocationManager()
        startConnection()
        //self.becomeFirstResponder()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func canBecomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent!) {
        if motion == UIEventSubtype.MotionShake {
            self.reloadInputViews()
            startConnection()
        }
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
        var location:CLLocation = locations[locations.count-1] as CLLocation
        var gpslatitude:String = NSString(format: "%f",location.coordinate.latitude as Double)
        var gpslongitude:String = NSString(format: "%f",location.coordinate.longitude as Double)
        //println(gpslatitude)
        lat = gpslatitude
        //println(gpslongitude)
        lon = gpslongitude
        //locationManager.stopUpdatingLocation()
    }

    func startConnection() {
        let urlPath: String = "http://omni-ychacks-km5aai4bwp.elasticbeanstalk.com/geo?lat=" + lat + "&lon=" + lon
        println(urlPath)
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        //var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        //connection.start()
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            var geoURL:String = jsonResult["url"] as String
            self.loadAddressURL(geoURL)
            }
        task.resume()
        }

    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }

    func loadAddressURL(url:String) {
        // Load url in Webview object
        var reqURL = NSURL(string:url)
        var req = NSURLRequest(URL:reqURL)
        Webview.loadRequest(req)
    }

}

