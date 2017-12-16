//
//  File.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import UIKit
class MapViewController: TramUIViewController{
    
    var mapView:MAMapView!
    var mapPresenter:MapPresenter!
    /// 点标记坐标数组
    var annotationLocations = [CLLocation]()
    /// 点标记名称数组
    var annotationNames = [String]()
    /// 点标记图标
    var logos = [UIImage]()
    ///旋转角度
    var rorates = [CGFloat]()
    var timer:Timer!
    var intervalTime:Int = 0
    var totalTime:Int = 1
    var NowSecondTime:Int = 0
    var deviceCode:String = ""
    var nowTime:String = ""
    var popView:PopActionSheet!
    var valueBackDelegate:ValueBackDelegate!
    var annotation:MAPointAnnotation!
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultDeviceInfo = GetDefaultDevice()
        
        CustomNavigationBar("车辆定位", false, true, false, "N130", 1, 3,2)
        self.view.backgroundColor = UIColor.hexStringToColor(hexString: "ffffff")
        deviceCode = defaultDeviceInfo.Name!
        initView()
        if(popView == nil){
            popView = PopActionSheet(title: "SmileLive", cancelButtonTitle: "取消", buttonTitles: ["1", "2", "3"])
        }
        if(self.mapPresenter == nil){
            self.mapPresenter = MapPresenter(self.view,self)
        }
    }
    //页面隐藏
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.endTimer()
    }
    //页面显示
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadData()
    }
    func initView(){
        mapView = MAMapView(frame:self.view.bounds)
        mapView!.delegate = self
        self.view.addSubview(mapView)
        
    }
    
   
}
//网络请求
extension MapViewController:MapView{
    
    func reloadData(){
        if(deviceCode == ""){
            Toast.fail(with: "当前无在线设备")
        }else{
            mapPresenter.GetDataState(self.deviceCode)
        }
    }
    
    func GetMapResults(_ data: MapModel) {
        self.mapView.removeAnnotation(self.annotation)
        self.annotationLocations = [CLLocation]()
        self.annotationNames = [String]()
        self.logos = [UIImage]()
        let maps = data.Maps!
        for i in 0..<maps.count{
            let location = maps[i].Location?.components(separatedBy: ",")
            self.annotationLocations.append(CLLocation(latitude: Double(location![1])!, longitude: Double(location![0])!))
            self.annotationNames.append(maps[i].Code)
            self.logos.append(UIImage(named:maps[i].iconclass!)!)
            self.rorates.append(CGFloat(maps[i].Rotate!))
            self.annotation = MAPointAnnotation()
            /// 添加点标记的坐标和标题
            self.annotation.coordinate = self.annotationLocations[i].coordinate
            self.annotation.title = self.annotationNames.last
            self.mapView.addAnnotation(self.annotation)
            self.mapView.centerCoordinate = (self.annotationLocations.last?.coordinate)!
            self.mapView.setZoomLevel(14, animated: true)
        }
    }
    
    func GetMapState(_ onlineState: DataStateModel) {
        if(onlineState.gpsstate){
            self.nowTime = DateUtil.GetNowDateString()
            self.startTimer()
        }else{
            Toast.fail(with: "该车辆Gps不在线")
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.intervalTime), target: self, selector: #selector(HandTimerEvent), userInfo: nil, repeats: true)
        timer.fire()
    }
    func endTimer(){
        if(timer != nil){
            timer.invalidate()
            timer = nil
            Toast.show(with: "监控结束")
            self.NowSecondTime = 0
        }
    }
    @objc func HandTimerEvent(){
        if(self.NowSecondTime >= (self.totalTime * 60)){
            self.endTimer()
            self.NowSecondTime = 0
        }else{
            self.NowSecondTime += self.intervalTime
            if(self.mapPresenter == nil){
                self.mapPresenter = MapPresenter(self.view,self)
            }
            print(self.NowSecondTime)
            self.mapPresenter.GetMapResults(self.deviceCode, self.nowTime)
        }
    }
    
}

extension MapViewController : MAMapViewDelegate{
    // MARK: - 标注代理方法
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKind(of: MAPointAnnotation.self){
            let annotationIdentifier = "locationIentifier"
            var poiAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MAPinAnnotationView
            if poiAnnotationView == nil{
                poiAnnotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            }
            /// logos最后一个元素就是每次戳点所对应的图标
            poiAnnotationView!.image = logos.last
            poiAnnotationView!.animatesDrop = false
            //poiAnnotationView!.rotate(toAngle: self.rorates.last!, ofType: AngleUnit)
            poiAnnotationView!.canShowCallout = true
            return poiAnnotationView
        }
        return nil
    }
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        popView.show()
    }
}
//接收回传参数
extension MapViewController:ValueBackDelegate{
    
    func ValueBack(type: Int, value: AnyObject) {       
        let model = value as? DeviceFilterResult
        CustomNavigationBar("车辆定位", false, true, false, (model?.deviceName)!, (model?.totalTime)!, (model?.intervalTime)!, 2)
        self.deviceCode = (model?.deviceName)!
        self.totalTime = (model?.totalTime)!
        self.intervalTime = (model?.intervalTime)!
    }
}
