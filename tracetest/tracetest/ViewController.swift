//
//  ViewController.swift
//  tracetest
//
//  Created by Leon Zhang on 15/4/2.
//  Copyright (c) 2015年 Leon Zhang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var thelabel: UILabel!
    @IBOutlet weak var textinput: UITextField!
    @IBOutlet weak var theButton: UIButton!
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        map.delegate = self
        map.mapType = MKMapType.Standard
        map.showsUserLocation = true
    }
    
    func createannotaionforresult(annotationName: String, coordinate : CLLocationCoordinate2D ){
        
        var point = MKPointAnnotation()
        point.title = annotationName
        point.coordinate = coordinate//CLLocationCoordinate2DMake(coorX, coorY)
        map.addAnnotation(point)
        
    }

    
    @IBAction func btnclick(sender: UIButton) {
        //map
        var searchtext = textinput.text;
        var searchrequest = MKLocalSearchRequest()
        searchrequest.naturalLanguageQuery = searchtext
        var search = MKLocalSearch(request: searchrequest)
        search.startWithCompletionHandler {
            ( response: MKLocalSearchResponse!, error: NSError!) -> Void in
            for item in response.mapItems{
                println(item.name)
                var item = item as MKMapItem
                var coordinate = item.placemark.coordinate
                self.createannotaionforresult(item.name, coordinate: coordinate)
            }
        }
        //map.
        
        
            }
    
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        thelabel.text = "\(locations[0])"
        myLocations.append(locations[0] as CLLocation)
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: map.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        
        map.setRegion(newRegion, animated: true)
        
        if(myLocations.count > 1){
            var sourceIndex = myLocations.count - 1
            var destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destinationIndex].coordinate
            var a = [c1,c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            map.addOverlay(polyline)
            
//            let annotation = MKPointAnnotation()
//            annotation.title = "test"
//            annotation.setCoordinate(c1)
//            map.addAnnotation(annotation)
        }
        
        
    }
    func mapView(mapView: MKMapView!,rendererForOverlay overlay:MKOverlay!) -> MKOverlayRenderer!{
        if overlay is MKPolyline {
            var polylineRender = MKPolylineRenderer(overlay: overlay)
            polylineRender.strokeColor = UIColor.blueColor()
            polylineRender.lineWidth = 5
            return polylineRender
            
        }
        return nil
    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

