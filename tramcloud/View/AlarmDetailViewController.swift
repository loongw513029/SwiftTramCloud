//
//  AlarmDetailViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
import Kingfisher
class AlarmDetailViewController: TramUIViewController {
    
    var alarmModel:AlarmDetailModel!
    var imageView1:UIButton!
    var imageView2:UIButton!
    var imageView3:UIButton!
    var deviceCode:UILabel!
    var busNumber:UILabel!
    var lineName:UILabel!
    var organzationName:UILabel!
    var AlarmName:UILabel!
    var AlarmTime:UILabel!
    var HostImageArr:[String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.loadData()
    }
    
    func initView(){
        let height = bounds.height - AppDelegate().StatusHeight - (self.navigationController?.navigationBar.frame.size.height)!
        let baseView = UIKitUtil.CreateUiView(self.view, x: 0, y: 0, width: bounds.width, height: height, backgroundColor: "dedede")
        let imageLayout = UIKitUtil.CreateUiView(baseView, x: 10, y: 10, width: bounds.width-20, height: 110, backgroundColor: "dedede")
        let imgWidth = (bounds.width-20-10)/3
        imageView1 = UIKitUtil.CreateUIImageButton(imageLayout, text: "", x: 0, y: 0, width: imgWidth, height: 100, textColor: "ffffff", textSize: 13, tag: 0, backgroundImageName: "", isShowText: false, selector: #selector(Handle(_:)), target: self)
        imageView2 = UIKitUtil.CreateUIImageButton(imageLayout, text: "", x: imgWidth+5, y: 0, width: imgWidth, height: 100, textColor: "ffffff", textSize: 13, tag: 1, backgroundImageName: "", isShowText: false, selector: #selector(Handle(_:)), target: self)
        imageView3 = UIKitUtil.CreateUIImageButton(imageLayout, text: "", x: (imgWidth+5)*2, y: 0, width: imgWidth, height: 100, textColor: "ffffff", textSize: 13, tag: 2, backgroundImageName: "", isShowText: false, selector: #selector(Handle(_:)), target: self)
        let view1 = UIKitUtil.CreateUiView(baseView, x: 0, y: 110, width: bounds.width, height: 40, backgroundColor: "ffffff")
        let label1 = UIKitUtil.CreateUILable(view1, text: "设备编号", x: 10, y: 0, width: 100, height: 40, textColor: "000000", textSize: 14, textAlign: .left)
        deviceCode = UIKitUtil.CreateUILable(view1, text: "", x: bounds.width-140, y: 0, width: 130, height: 40, textColor: "000000", textSize: 14, textAlign: .right)
        UIKitUtil.CreateUiView(baseView, x: 0, y: 150, width: bounds.width, height: 1, backgroundColor: "dedede")
        let view2 = UIKitUtil.CreateUiView(baseView, x: 0, y: 151, width: bounds.width, height: 40, backgroundColor: "ffffff")
        let label2 = UIKitUtil.CreateUILable(view2, text: "车牌号", x: 10, y: 0, width: 100, height: 40, textColor: "000000", textSize: 14, textAlign: .left)
        busNumber = UIKitUtil.CreateUILable(view2, text: "", x: bounds.width-140, y: 0, width: 130, height: 40, textColor: "000000", textSize: 14, textAlign: .right)
        UIKitUtil.CreateUiView(baseView, x: 0, y: 191, width: bounds.width, height: 1, backgroundColor: "dedede")
        let view3 = UIKitUtil.CreateUiView(baseView, x: 0, y: 192, width: bounds.width, height: 40, backgroundColor: "ffffff")
        let label3 = UIKitUtil.CreateUILable(view3, text: "线路名称", x: 10, y: 0, width: 100, height: 40, textColor: "000000", textSize: 14, textAlign: .left)
        lineName = UIKitUtil.CreateUILable(view3, text: "", x: bounds.width-140, y: 0, width: 130, height: 40, textColor: "000000", textSize: 14, textAlign: .right)
        UIKitUtil.CreateUiView(baseView, x: 0, y: 232, width: bounds.width, height: 1, backgroundColor: "dedede")
        let view4 = UIKitUtil.CreateUiView(baseView, x: 0, y: 233, width: bounds.width, height: 40, backgroundColor: "ffffff")
        let label4 = UIKitUtil.CreateUILable(view4, text: "所属机构", x: 10, y: 0, width: 100, height: 40, textColor: "000000", textSize: 14, textAlign: .left)
        organzationName = UIKitUtil.CreateUILable(view4, text: "", x: bounds.width-140, y: 0, width: 130, height: 40, textColor: "000000", textSize: 14, textAlign: .right)
        UIKitUtil.CreateUiView(baseView, x: 0, y: 273, width: bounds.width, height: 1, backgroundColor: "dedede")
        let view5 = UIKitUtil.CreateUiView(baseView, x: 0, y: 274, width: bounds.width, height: 40, backgroundColor: "ffffff")
        let label5 = UIKitUtil.CreateUILable(view5, text: "报警类型", x: 10, y: 0, width: 100, height: 40, textColor: "000000", textSize: 14, textAlign: .left)
        AlarmName = UIKitUtil.CreateUILable(view5, text: "", x: bounds.width-140, y: 0, width: 130, height: 40, textColor: "000000", textSize: 14, textAlign: .right)
        UIKitUtil.CreateUiView(baseView, x: 0, y: 314, width: bounds.width, height: 1, backgroundColor: "dedede")
        let view6 = UIKitUtil.CreateUiView(baseView, x: 0, y: 315, width: bounds.width, height: 40, backgroundColor: "ffffff")
        let label6 = UIKitUtil.CreateUILable(view6, text: "报警时间", x: 10, y: 0, width: 100, height: 40, textColor: "000000", textSize: 14, textAlign: .left)
        AlarmTime = UIKitUtil.CreateUILable(view6, text: "", x: bounds.width-140, y: 0, width: 130, height: 40, textColor: "000000", textSize: 14, textAlign: .right)
    }
}
extension AlarmDetailViewController{
    
    func loadData(){
        var imageArr = [String]()
        imageArr = alarmModel.AlarmValue.components(separatedBy: ",")
        HostImageArr.append(AppDelegate().BaseUrl+imageArr[0])
        HostImageArr.append(AppDelegate().BaseUrl+imageArr[1])
        let resource1 = ImageResource(downloadURL: URL(string: HostImageArr[0])!)
        let resource2 = ImageResource(downloadURL: URL(string: HostImageArr[1])!)
        imageView1.kf.setBackgroundImage(with: resource1, for: .normal)
        imageView2.kf.setBackgroundImage(with: resource2, for: .normal)
        imageView3.isHidden = true
        deviceCode.text = alarmModel.DeviceCode
        busNumber.text = alarmModel.BusNumber
        lineName.text = alarmModel.LineName
        organzationName.text = alarmModel.DepartmentName
        AlarmName.text = alarmModel.AlramName
        AlarmTime.text = alarmModel.UpdateTime
        
    }
    
    @objc func Handle(_ sender:UIButton){
        //图片索引
        let index = sender.tag
        //进入图片全屏展示
        let previewVC = ImagePreviewVC(images: self.HostImageArr, index: index)
        previewVC.title = "图片预览"
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(previewVC, animated: true)
    }
}
