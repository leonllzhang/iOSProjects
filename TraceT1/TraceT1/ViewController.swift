//
//  ViewController.swift
//  TraceT1
//
//  Created by Leon Zhang on 15/4/13.
//  Copyright (c) 2015年 Leon Zhang. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var btnzoom: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapview.showsUserLocation = true
    }

    @IBAction func ZoomIn(sender: UIBarButtonItem) {
        let userlocation = mapview.userLocation
        let region = MKCoordinateRegionMakeWithDistance(userlocation.location.coordinate, 200,200)
        
        mapview.setRegion(region, animated: true)
        
    }
    @IBAction func changemapType(sender: UIBarButtonItem) {
        if mapview.mapType == MKMapType.Standard {
            mapview.mapType = MKMapType.Satellite
        }
        else    {
            mapview.mapType = MKMapType.Standard
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

