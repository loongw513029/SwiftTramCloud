//
//  File.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import UIKit
class MapViewController: TramUIViewController,MAMapViewDelegate,AMapLocationManagerDelegate {
    
    var mapView:MAMapView!
    var locationManager:AMapLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomNavigationBar("车辆定位", false, true, false, "N130", 1, 3)
        self.view.backgroundColor = UIColor.hexStringToColor(hexString: "ffffff")
        initView()
        
    }
    //let longitude = location?.coordinate.longitude
    //let latitude = location?.coordinate.latitude
    
    //let coordinate = CLLocationCoordinate2D.init(latitude:latitude!,longitude:longitude!)
    //let overlay = MACircle(center:coordinate,radius:5000.0)
    //self?.mapView!.add(overlay)
    func initView(){
        mapView = MAMapView(frame:self.view.bounds)
        mapView!.delegate = self
        self.view.addSubview(mapView)
        locationManager = AMapLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.locationTimeout = 10
        locationManager.reGeocodeTimeout = 10
        locationManager.requestLocation(withReGeocode: false,
                                        completionBlock: {[weak self](location:CLLocation?,reGeocode:AMapLocationReGeocode?,error:Error?) in
            if let error = error{
                let error = error as NSError
                if error.code == AMapLocationErrorCode.locateFailed.rawValue{
                    return
                }else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                || error.code == AMapLocationErrorCode.timeOut.rawValue
                || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                || error.code == AMapLocationErrorCode.badURL.rawValue
                || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue{
                }else{
                    DispatchQueue.main.async {
                        let longitude = location?.coordinate.longitude
                        let latitude = location?.coordinate.latitude
                        let coordinate = CLLocationCoordinate2D.init(latitude:latitude!,longitude:longitude!)
                        let overlay = MACircle(center:coordinate,radius:5000.0)
                        self?.mapView!.add(overlay)
                    }
                }
            }
            if let location = location{
                
            }
            if let reGeocode = reGeocode{
                
            }
        })
        
    }
}
