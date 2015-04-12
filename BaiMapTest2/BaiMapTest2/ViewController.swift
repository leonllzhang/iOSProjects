//
//  ViewController.swift
//  BaiMapTest2
//
//  Created by Leon Zhang on 15/4/8.
//  Copyright (c) 2015年 Leon Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,BMKMapViewDelegate{
    var mapview: BMKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapview = BMKMapView(frame: self.view.frame)
        self.view = mapview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

