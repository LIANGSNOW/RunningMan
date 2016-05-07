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

class MainViewController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate	{
    
    @IBOutlet weak var mapTrack: MKMapView!
    @IBOutlet weak var theLabel: UILabel!

    var locationManager:CLLocationManager!
    var myLocations:[CLLocation] = []
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
        

    }
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        if let oldLocationNew = oldLocation as CLLocation?{
            let oldCoordinates = oldLocationNew.coordinate
            let newCoordinates = newLocation.coordinate
            var area = [oldCoordinates, newCoordinates]
            var polyline = MKPolyline(coordinates: &area, count: area.count)
            mapTrack.addOverlay(polyline)
        }
        annotateMap(newLocation.coordinate)
    }
  
    
    func annotateMap(newCoordinate: CLLocationCoordinate2D){
        let latDelta:CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let myLocation:CLLocationCoordinate2D = newCoordinate
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, theSpan)
        self.mapTrack.setRegion(theRegion, animated: true)
        self.mapTrack.mapType = MKMapType.Standard
        
       /* let myHomePin = MKPointAnnotation()
        myHomePin.coordinate = newCoordinate
        myHomePin.title = "I am here"
        self.mapTrack.addAnnotation(myHomePin)*/
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
 


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setting(sender : AnyObject){
        self.presentViewController((storyboard?.instantiateViewControllerWithIdentifier("UserInfoViewController"))!, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
