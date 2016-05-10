//
//  MainViewController.swift
//  RunningMan
//
//  Created by zz on 5/5/16.
//  Copyright © 2016 Group16. All rights reserved.
//


import UIKit
import CoreLocation
import MapKit
import HealthKit

class MainViewController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate	{
    
    @IBOutlet weak var mapTrack: MKMapView!
    @IBOutlet weak var timeLabel: UILabel!
  //  @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var setButton : UIBarButtonItem!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    var tiemPeriod:String = "";
    var locationManager:CLLocationManager!
    var myLocations:[CLLocation] = []
    var currentTime = NSDate()
    var healthStep:Double = 0
    var healthMile:Double = 0
    var userLatitude:Double = 0
    var userLongtitude:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapTrack.delegate = self
        mapTrack.mapType = MKMapType(rawValue: 0)!
        mapTrack.showsUserLocation = true
        mapTrack.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        // theLabel.text = "1321321"
        stopButton.hidden = true
        
        
        
        
       
    
    }
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        if let oldLocationNew = oldLocation as CLLocation?{
            let oldCoordinates = oldLocationNew.coordinate
            let newCoordinates = newLocation.coordinate
            userLatitude = oldCoordinates.latitude
            userLongtitude  = oldCoordinates.longitude
            //print(userLatitude ,  userLongtitude )
            var area = [oldCoordinates, newCoordinates]
            var polyline = MKPolyline(coordinates: &area, count: area.count)
            mapTrack.addOverlay(polyline)
        }
        annotateMap(newLocation.coordinate)
    }
    
    func addCurrentLocation(){
         let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/updatePositionInfo.action?userAccount=\(ApplicationSession.loginedUserId)&latitude=\(userLatitude)&longitude=\(userLongtitude)"
        NetworkTool.networkTool.urlRequest(url, function: addCurrentLocationCallBack)
    }
    
    func addCurrentLocationCallBack(result : String){
        
        
    }
    
    @IBAction func showNearPerson(){
        addCurrentLocation()
        let url = "http://" + NetworkTool.serverIP + "/IOSApp/mobile/getPeopleNearby.action?userAccount=\(ApplicationSession.loginedUserId)"
        NetworkTool.networkTool.urlRequest(url, function: showNearPersonCallBcak)

    }
    
    func showNearPersonCallBcak(result: String){
        print(result)
        let data = result.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        do{
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            for item in (jsonData as! NSMutableArray){
                let userAccount : String = (item as! NSDictionary).valueForKey("account") as! String
                let latitude = (item as! NSDictionary).valueForKey("latitude") as! String
                let longitude = (item as! NSDictionary).valueForKey("longitude") as! String
                
                let latDou:Double = (latitude as NSString).doubleValue
                let longDou:Double = (longitude as NSString).doubleValue
                
                let coordinate = CLLocationCoordinate2DMake(latDou, longDou)
                let myHomePin = MKPointAnnotation()
                myHomePin.coordinate = coordinate
                myHomePin.title = userAccount
                self.mapTrack.addAnnotation(myHomePin)
            }

        } catch {
            print("convert json string to array error")
        }
    }
    
    func annotateMap(newCoordinate: CLLocationCoordinate2D){
        let latDelta:CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let myLocation:CLLocationCoordinate2D = newCoordinate
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, theSpan)
        self.mapTrack.setRegion(theRegion, animated: true)
        self.mapTrack.mapType = MKMapType.Standard
        
       
        
       
    }
    /*
     func mapView(mapView: MKMapView, viewForOverlay overlay: MKOverlay) -> MKOverlayView {
     
     if overlay is MKPolyline {
     }
     return nil
     
     }
     */
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }
    
    
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        timeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        tiemPeriod = "\(strMinutes):\(strSeconds):\(strFraction)"
    }

    
    @IBAction func start(sender: AnyObject) {
        let aSelector : Selector = "updateTime"
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        startButton.hidden = true
        stopButton.hidden = false
        timer = NSTimer()
        // t = NSDate()
    }

    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
        startButton.hidden = false
        stopButton.hidden = true

        var stepOfString:String = "";
        HealthManager().recentSteps(currentTime){steps, error in
            self.healthStep = steps
        }
        
        if(healthStep == 0.0){
            HealthManager().recentSteps(currentTime){steps, error in
                self.healthStep = steps
            }
        }
        
        
        stepOfString = String(format:"%.1f", healthStep)
        //aLabel.text = "\(stepOfString)"
        
        
//        var mileOfString:String = "";
//        
//        self.testFunction(currentTime, function: getValue)
//        
//        mileOfString = String(format: "%.1f",healthMile)
//        bLabel.text = mileOfString
//        //timer = nil
        
        
        SqlConnection().createSteps(ApplicationSession.loginedUserId,date: "123",step: stepOfString,timeperiod: tiemPeriod)
    }
    
    func testFunction(currentTime : NSDate, function : (Double) -> ()){
        HealthManager().recentMiles(currentTime){miles, error in
            function(miles)
        }
    }
    
    func getValue(result : Double){
        self.healthMile = result
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func setting(sender : AnyObject){
//        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("UserInfoViewController"))!, animated: true, completion: nil)
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
