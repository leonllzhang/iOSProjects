//
//  ViewController.swift
//  GDMap
//
//  Created by Leon Zhang on 15/3/27.
//  Copyright (c) 2015年 Leon Zhang. All rights reserved.
//

import UIKit
let APIKey = "24dddfebab0ddcf0a8ffb7575360a1f1"
class ViewController: UIViewController, MAMapViewDelegate,AMapSearchDelegate{

    var mapView : MAMapView?
    var search:AMapSearchAPI?
    var currentLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 配置用户Key
        MAMapServices.sharedServices().apiKey = APIKey
        // 初始化MAMapView
        initMapView()
        initSearch()
        
    }
    func initMapView(){
        
        mapView = MAMapView(frame: self.view.bounds)
        
        mapView!.delegate = self
        
        self.view.addSubview(mapView!)
        
        let compassX = mapView?.compassOrigin.x
        
        let scaleX = mapView?.scaleOrigin.x
        //设置地图类型
        mapView?.mapType = UInt( MAMapTypeStandard)
        mapView!.showTraffic = true
        
        
        //设置指南针和比例尺的位置
        mapView?.compassOrigin = CGPointMake(compassX!, 21)
        
        mapView?.scaleOrigin = CGPointMake(scaleX!, 21)
        
        // 开启定位
        mapView!.showsUserLocation = true
        
        // 设置跟随定位模式，将定位点设置成地图中心点
        mapView!.userTrackingMode = MAUserTrackingModeFollow
        
        //mapview 加 图层
        self.mapView?.centerCoordinate = CLLocationCoordinate2DMake(39.910695, 116.372830)
        self.mapView?.zoomLevel = 19
        self.mapView?.zoomEnabled = true
        //MAOverlay overl =
        self.mapView?.addOverlay(<#overlay: MAOverlay!#>)
        
    }
    
    // 初始化 AMapSearchAPI
    func initSearch(){
        search = AMapSearchAPI(searchKey: APIKey, delegate: self);
    }
    func constructOverlay(floor : Int)-> MATileOverlay
    {
        var urltemplate = "http://sdkdemo.amap.com:8080/tileserver/Tile?x={x}&y={y}&z={z}&f=\(floor)";
        //initwithurl 方法不知道该怎么用swift 实现
        MATileOverlay tileoverlay =
        tileoverlay
        
    }
    
    // 逆地理编码
    func reverseGeocoding(){
        
        let coordinate = currentLocation?.coordinate
        
        // 构造 AMapReGeocodeSearchRequest 对象，配置查询参数（中心点坐标）
        let regeo: AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
        
        regeo.location = AMapGeoPoint.locationWithLatitude(CGFloat(coordinate!.latitude), longitude: CGFloat(coordinate!.longitude))
        
        println("regeo :\(regeo)")
        
        // 进行逆地理编码查询
        self.search!.AMapReGoecodeSearch(regeo)
        
    }
    
    // 定位回调
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            currentLocation = userLocation.location
        }
    }
    
    // 点击Annoation回调
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        // 若点击的是定位标注，则执行逆地理编码
        if view.annotation.isKindOfClass(MAUserLocation){
            reverseGeocoding()
        }
    }
    
    // 逆地理编码回调
    func onReGeocodeSearchDone(request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        println("request :\(request)")
        println("response :\(response)")
        
        if (response.regeocode != nil) {
            
            var title = response.regeocode.addressComponent.city
            
            var length: Int{
                return countElements(title)
            }
            
            if (length == 0){
                title = response.regeocode.addressComponent.province
            }
            //给定位标注的title和subtitle赋值，在气泡中显示定位点的地址信息
            mapView?.userLocation.title = title
            mapView?.userLocation.subtitle = response.regeocode.formattedAddress
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

