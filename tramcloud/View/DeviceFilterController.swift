//
//  DeviceFilterController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/12.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Closures
import HandyJSON
import AttributedLib
class DeviceFilterController: TramUIViewController,DeviceFilterView {
    
    
    var tag:Int!
    var top2height:CGFloat? = 160
    var totalTimeView:UIView!
    var intervalTimeView:UIView!
    var lineView:UIView!
    var lineBoxView:UIView!
    var deviceView:UIView!
    var lineCollectionView:UICollectionView!
    var deviceCollectionView:UICollectionView!
    var totalTimeButtons = [UIButton]()
    var intervalTimeButtons = [UIButton]()
    var lineButtons = [UIButton]()
    var deviceButtons = [UIButton]()
    var deviceFilterPresenter:DeviceFilterPresenter!
    var baseView:UIView!
    var lines = Array<LineDetailModel>()
    var devices = Array<AppDropDownModel>()
    fileprivate var deviceFilterResult = DeviceFilterResult()
    weak var valueBackDelegate : ValueBackDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择条件"
        let rightButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(SubmitSelect))
        rightButton.image = UIImage(named:"icon_sure")
        rightButton.tintColor = UIColor.white
        rightButton.width = -100
        self.navigationItem.rightBarButtonItems = [rightButton]
        let LinesStr = UserDefaultUtil.getNormalUserDefault("lines") as! String
        if(LinesStr != ""){
            lines = (JSONDeserializer<LineModel>.deserializeFrom(json:LinesStr)?.Lines)!
        }
        print(tag)
        if(tag == 1){
            top2height = 0
        }
        self.initView()
        self.FilterView()
        if(deviceFilterPresenter == nil)
        {
            deviceFilterPresenter = DeviceFilterPresenter(self.view,self)
        }
        if(LinesStr == ""){
            deviceFilterPresenter.GetLines(userInfo.Id!, userInfo.DepartmentId!)
        }
    }
    func FilterView(){
        if(tag == 1){
            totalTimeView.isHidden = true
            intervalTimeView.isHidden = true
            deviceView.isHidden = true
        }
        else if (tag == 2){
            totalTimeView.isHidden = false
            intervalTimeView.isHidden = false
            deviceView.isHidden = false
        }
    }
    var width:CGFloat = 0
    func initView(){
        self.view.autoresizingMask = .flexibleHeight
        self.view.backgroundColor = UIColor(patternImage:UIImage(named:"organization_bg")!)
        let height = bounds.height - statusHeight
        let padding = bounds.width*0.0284
        baseView = UIKitUtil.CreateUiView(self.view, x: padding, y: padding, width: bounds.width-(padding*2), height: height-(padding*2), backgroundColor: "")
        width = bounds.width-(padding*2)
        let baseHeight = height-(padding*2)
        totalTimeView = UIKitUtil.CreateUiView(baseView, x: 0, y: 0, width: width, height: 80, backgroundColor: "")
        let totalTimeLabel = UIKitUtil.CreateUILable(totalTimeView, text: "监控时间", x: 0, y: 0, width: width, height: 30, textColor: "ffffff", textSize: 14, textAlign: .left)
        let linev = UIKitUtil.CreateUiView(totalTimeView, x: 0, y: 30, width: width, height: 1, backgroundColor: "dedede")
        let bwidth = width * 0.1869
        let bmarg = (width-(bwidth*5))/4
        var x1:CGFloat = 0
        for i in 0..<5{
            if(i != 0){
                x1 = CGFloat(i)*(bwidth+bmarg)
            }
            var button:UIButton = UIKitUtil.CreateUiButton(totalTimeView, text: String(i+1)+"分钟", x: x1, y: 38, width: bwidth, height: 35, textColor: "ffffff", textSize: 13, tag: i)
            button.addTarget(self, action: #selector(totalTimeTap(_:)), for: .touchUpInside)
            button.backgroundColor = UIColor.hexStringToColor(hexString: "415077")
            totalTimeButtons.append(button)
        }
        intervalTimeView = UIKitUtil.CreateUiView(baseView, x: 0, y: 82, width: width, height: 80, backgroundColor: "")
        let intervalLabel = UIKitUtil.CreateUILable(intervalTimeView, text: "间隔时间", x: 0, y: 0, width: width, height: 30, textColor: "ffffff", textSize: 14, textAlign: .left)
        let linev1 = UIKitUtil.CreateUiView(intervalTimeView, x: 0, y: 30, width: width, height: 1, backgroundColor: "dedede")
        let iwidth = width*0.2338
        let imarg = (width-(iwidth*4))/3
        var x2:CGFloat = 0
        for j in 0..<4{
            if(j != 0 ){
                x2 = CGFloat(j)*(iwidth+imarg)
            }
            var m:Int = 3
            if(j > 0){
                m = 5*j
            }
            var button:UIButton = UIKitUtil.CreateUiButton(intervalTimeView, text: String(m)+"秒", x: x2, y: 38, width: iwidth, height: 35, textColor: "ffffff", textSize: 13, tag: j)
            button.addTarget(self, action: #selector(intervalTap(_:)), for: .touchUpInside)
            button.backgroundColor = UIColor.hexStringToColor(hexString: "415077")
            intervalTimeButtons.append(button)
        }
        let collectionViewHeight = (baseHeight - 162) / 2 - 31
        lineView = UIKitUtil.CreateUiView(baseView, x: 0, y: top2height!+2, width: width, height: collectionViewHeight, backgroundColor: "")
        let lineLabel = UIKitUtil.CreateUILable(lineView, text: "线路选择", x: 0, y: 0, width: width, height: 30, textColor: "ffffff", textSize: 14, textAlign: .left)
        let line3 = UIKitUtil.CreateUiView(lineView, x: 0, y: 30, width: width, height: 1, backgroundColor: "dedede")
        lineBoxView = UIKitUtil.CreateUiView(lineView, x: 0, y: 35, width: width, height: collectionViewHeight-20, backgroundColor: "")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: width * 0.1869, height: 35)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        lineCollectionView = UICollectionView.init(frame:CGRect(x:0,y:0,width:Int(width),height:Int(collectionViewHeight-20)),collectionViewLayout:flowLayout)
        lineCollectionView.register(DeviceFilterViewCell.self, forCellWithReuseIdentifier: "cell")
        lineCollectionView.backgroundColor = UIColor.clear
        lineCollectionView.tag = 1
        lineCollectionView.bounces = false
        lineBoxView.addSubview(lineCollectionView)
        lineCollectionView.dataSource = self
        lineCollectionView.delegate = self
        self.lineCollectionView.reloadData()
        deviceView = UIKitUtil.CreateUiView(baseView, x: 0, y: top2height!+20+collectionViewHeight, width: width, height: collectionViewHeight, backgroundColor: "")
        let deviceLabel = UIKitUtil.CreateUILable(deviceView, text: "设备选择", x: 0, y: 0, width: width, height: 30, textColor: "ffffff", textSize: 14, textAlign: .left)
        let line4 = UIKitUtil.CreateUiView(deviceView, x: 0, y: 30, width: width, height: 1, backgroundColor: "dedede")
        let flowLayout2 = UICollectionViewFlowLayout()
        flowLayout2.minimumLineSpacing = 4
        flowLayout2.minimumInteritemSpacing = 0
        flowLayout2.itemSize = CGSize(width: width * 0.1869, height: 35)
        flowLayout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        deviceCollectionView = UICollectionView.init(frame:CGRect(x:0,y:35,width:Int(width),height:Int(collectionViewHeight-20)),collectionViewLayout:flowLayout2)
        deviceCollectionView.register(DeviceViewCell.self, forCellWithReuseIdentifier: "cell1")
        deviceCollectionView.backgroundColor = UIColor.clear
        deviceCollectionView.tag = 2
        deviceView.addSubview(deviceCollectionView)
        deviceCollectionView.dataSource = self
        deviceCollectionView.delegate = self
        self.deviceCollectionView.reloadData()
    }
    
}

extension DeviceFilterController{
  
    func getLines(_ data: [LineDetailModel]) {
        self.lines = data
        var lineModel = LineModel()
        lineModel.Lines = data
        UserDefaultUtil.setNormalDefault("lines", lineModel.toJSONString(prettyPrint: true))
        self.lineCollectionView.reloadData()
    }
    
    func getDevices(_ data: [AppDropDownModel]) {
        self.devices = data;
        self.deviceCollectionView.reloadData()
    }
}

extension DeviceFilterController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.tag == 1){
            return lines.count
        }
        else if(collectionView.tag == 2)
        {
            return devices.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentity = "cell"
        if(collectionView.tag == 1){
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentity, for: indexPath) as? DeviceFilterViewCell
            cell?.txtLabel.setTitle(lines[indexPath.row].Name, for: .normal)
            cell?.txtLabel.tag = lines[indexPath.row].Id!
            cell?.txtLabel.addTarget(self, action: #selector(TapBtn(_:)), for: .touchUpInside)
            return cell!
        }else{
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? DeviceViewCell
            cell?.txtLabel.setTitle(devices[indexPath.row].Name, for: .normal)
            cell?.txtLabel.tag = devices[indexPath.row].Id!
            if(devices[indexPath.row].IsOnline)!{
                cell?.txtLabel.backgroundColor = UIColor.hexStringToColor(hexString: "415077")
                cell?.txtLabel.addTarget(self, action: #selector(DeviceTap(_:)), for: .touchUpInside)
            }else{
                cell?.txtLabel.backgroundColor = UIColor.hexStringToColor(hexString: "8a8a8a")
                cell?.txtLabel.removeTarget(self, action: #selector(DeviceTap(_:)), for: .touchUpInside)
            }
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.hexStringToColor(hexString: "415077")
    }
    
    @objc func totalTimeTap(_ sender:UIButton){
       deviceFilterResult.totalTime = sender.tag + 1
    }
    
    @objc func SubmitSelect(){
        if(tag == 1){
            if(deviceFilterResult.lineId == 0){
                Toast.fail(with: "请选择线路")
                return
            }
        }
        if(tag == 2){
            if(deviceFilterResult.totalTime == 0){
                Toast.fail(with: "请选择监控时间")
                return
            }
            if(deviceFilterResult.intervalTime == 0){
                Toast.fail(with: "请选择间隔时间")
                return
            }
            if(deviceFilterResult.deviceId == 0){
                Toast.fail(with: "请选择设备")
                return
            }
        }
        
        if(tag == 3){
            if(deviceFilterResult.deviceId == 0){
                Toast.fail(with: "请选择设备")
                return
            }
        }
        if let delegate = self.valueBackDelegate{
            delegate.ValueBack(type: tag, value: deviceFilterResult)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func intervalTap(_ sender:UIButton){
        let tag:Int = sender.tag
        if(tag == 0){
            deviceFilterResult.intervalTime = 3
        }
        else{
            deviceFilterResult.intervalTime = sender.tag * 5
        }
    }
    
    @objc func TapBtn(_ sender:UIButton){
        if(tag == 2){
            deviceFilterPresenter.GetDevicesByLines(sender.tag)
        }
        let lineModel = self.getLineModel(sender.tag)
        deviceFilterResult.lineId = lineModel.Id
        deviceFilterResult.lineName = lineModel.Name
        if(tag == 1){
            UserDefaultUtil.setNormalDefault("lineId", lineModel.Id)
        }
        
    }
    @objc func DeviceTap(_ sender:UIButton){
        let deviceModel = self.getDeviceModel(sender.tag)
        deviceFilterResult.deviceId = deviceModel.Id
        deviceFilterResult.deviceName = deviceModel.Name
        UserDefaultUtil.setNormalDefault("DefaultDevice", deviceModel.toJSONString(prettyPrint: true))
    }
    
    func getLineModel(_ lineId:Int) -> LineDetailModel{
        var lineModel:LineDetailModel!
        for i in 0..<lines.count{
            if(lines[i].Id == lineId){
                lineModel = lines[i]
            }
        }
        return lineModel
    }
    
    func getDeviceModel(_ deviceId:Int) -> AppDropDownModel{
        var deviceModel:AppDropDownModel!
        for i in 0..<devices.count{
            if(devices[i].Id == deviceId){
                deviceModel = devices[i]
            }
        }
        return deviceModel
    }
}
