//
//  HomeViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import UIKit
class HomeViewController: TramUIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "车辆云管理"
        self.view.backgroundColor=UIColor.hexStringToColor(hexString: "f2f2f2")
        self.InitView()
        let rightButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        rightButton.image = UIImage(named:"ic_more")
        rightButton.tintColor = UIColor.white
        // 添加左侧、右侧按钮
        self.navigationItem.setRightBarButton(rightButton, animated: false)
        showBackButton()
    }
    func InitView(){
        print(bounds.height)
        let chartView = UIKitUtil.CreateUiView(self.view,x: 0, y: 0, width: bounds.width, height: bounds.height*0.32, backgroundColor: "0b9bee")
        self.view.addSubview(chartView)
        //中间车辆总数，在线数量，线路条数，异常行为
        let navNumberView=UIKitUtil.CreateUiView(self.view,x:0,y:bounds.height*0.32,width:bounds.width,height:bounds.height*0.13,backgroundColor:"ffffff")
        let labelWidth = bounds.width/4-1
        let labelHeight = bounds.height*0.13
        let carnoView=UIKitUtil.CreateUiView(navNumberView, x:0,y:0,width:labelWidth,height:labelHeight, backgroundColor: "ffffff")
        let carnoLabel=UIKitUtil.CreateUILable(carnoView, text: "车辆台数", x:0,y:15,width:labelWidth,height:20, textColor: "00000", textSize: 13, textAlign: .center)
        let carnotext=UIKitUtil.CreateUiButton(carnoView, text: "0", x:0,y:35,width:labelWidth,height:labelHeight-35, textColor: "0b9bee", textSize: 14, tag: 1)
        UIKitUtil.CreateUiView(navNumberView, x: labelWidth, y: 10, width: 1, height: labelHeight-20, backgroundColor: "dedede")
   
        carnotext.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        let onlineView=UIKitUtil.CreateUiView(navNumberView, x:labelWidth+1,y:0,width:labelWidth,height:labelHeight, backgroundColor: "ffffff")
        let onlineLabel=UIKitUtil.CreateUILable(onlineView, text: "在线台数", x:0,y:15,width:labelWidth,height:20, textColor: "00000", textSize:13,textAlign: .center)
        let onlinetext=UIKitUtil.CreateUiButton(onlineView, text: "0", x:0,y:35,width:labelWidth,height:labelHeight-35, textColor: "0b9bee", textSize: 14, tag: 2)
        onlinetext.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        UIKitUtil.CreateUiView(navNumberView, x: labelWidth*2, y: 10, width: 1, height: labelHeight-20, backgroundColor: "dedede")
        
        let lineView=UIKitUtil.CreateUiView(navNumberView, x:labelWidth*2+2,y:0,width:labelWidth,height:labelHeight, backgroundColor: "ffffff")
        let lineLabel=UIKitUtil.CreateUILable(lineView, text: "线路条数", x:0,y:15,width:labelWidth,height:20, textColor: "00000", textSize: 13, textAlign: .center)
        let linetext=UIKitUtil.CreateUiButton(lineView, text: "0", x:0,y:35,width:labelWidth,height:labelHeight-35, textColor: "0b9bee", textSize: 14, tag: 3)
        UIKitUtil.CreateUiView(navNumberView, x: labelWidth*3, y: 10, width: 1, height: labelHeight-20, backgroundColor: "dedede")
        linetext.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        
        let ycView=UIKitUtil.CreateUiView(navNumberView, x:labelWidth*3+3,y:0,width:labelWidth,height:labelHeight, backgroundColor: "ffffff")
        let ycLabel=UIKitUtil.CreateUILable(ycView, text: "异常行为", x:0,y:15,width:labelWidth,height:20, textColor: "00000", textSize: 13, textAlign: .center)
        let yctext=UIKitUtil.CreateUiButton(ycView, text: "0", x:0,y:35,width:labelWidth,height:labelHeight-35, textColor: "0b9bee", textSize: 14, tag: 4)
        yctext.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        self.view.addSubview(navNumberView)
        //统计分析，设备巡检，设备维修，车辆报警
        let bottomheight=bounds.height-bounds.height*0.47-UIApplication.shared.statusBarFrame.height-(self.navigationController?.navigationBar.frame.height)!-70
        let bottomView=UIKitUtil.CreateUiView(self.view, x: 0, y: bounds.height*0.47, width: bounds.width, height: bottomheight,backgroundColor: "ffffff")
        let bottomwidth=bounds.width/3-1
        let imgWidth:CGFloat=45,imgHeight:CGFloat=45
        let imgx=(bottomwidth - imgWidth)/2
        let texty:CGFloat=25
        let canHistoryView=UIKitUtil.CreateUiView(bottomView, x: 0, y: 0, width: bottomwidth, height: bottomheight/2, backgroundColor: "ffffff")
        
        let sysButton=UIKitUtil.CreateUIImageButton(canHistoryView, text: "统计分析", x: imgx, y: 10, width:imgWidth, height: imgHeight, textColor: "000000", textSize: 13, tag: 5, backgroundImageName: "icon_analysis",isShowText:false,selector:#selector(Handle(_:)),target:self)
        let systxtButton = UIKitUtil.CreateUiButton(canHistoryView, text: "统计分析", x:0,y:texty,width:bottomwidth,height:bottomheight/2, textColor: "000000", textSize: 13, tag: 5)
        systxtButton.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        UIKitUtil.CreateUiView(bottomView, x: bottomwidth, y: 10, width: 1, height: bottomheight/2-20, backgroundColor: "dedede")
        
        let inspectView=UIKitUtil.CreateUiView(bottomView, x: bottomwidth+1, y: 0, width: bottomwidth, height: bottomheight/2, backgroundColor: "ffffff")
        
        UIKitUtil.CreateUIImageButton(inspectView, text: "设备巡检", x: imgx, y: 10, width:imgWidth, height: imgHeight, textColor: "000000", textSize: 13, tag: 6, backgroundImageName: "icon_device_inspect",isShowText:false,selector:#selector(Handle(_:)),target:self)
        
        let inspecttxtButton = UIKitUtil.CreateUiButton(inspectView, text: "设备巡检", x:0,y:texty,width:bottomwidth,height:bottomheight/2, textColor: "000000", textSize: 13, tag: 6)
        inspecttxtButton.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        UIKitUtil.CreateUiView(bottomView, x: bottomwidth*2+2, y: 10, width: 1, height: bottomheight/2-20, backgroundColor: "dedede")
        
        let repairView=UIKitUtil.CreateUiView(bottomView, x: bottomwidth*2+3, y: 0, width: bottomwidth, height: bottomheight/2, backgroundColor: "ffffff")
        
        UIKitUtil.CreateUIImageButton(repairView, text: "设备维修", x: imgx, y: 10, width:imgWidth, height: imgHeight, textColor: "000000", textSize: 13, tag: 7, backgroundImageName: "icon_device_repair",isShowText:false,selector:#selector(Handle(_:)),target:self)
       
        let repairtxtButton = UIKitUtil.CreateUiButton(repairView, text: "设备维修", x:0,y:texty,width:bottomwidth,height:bottomheight/2, textColor: "000000", textSize: 13, tag: 7)
        repairtxtButton.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        let alarmView=UIKitUtil.CreateUiView(bottomView, x: 0, y: bottomheight/2, width: bottomwidth, height: bottomheight/2, backgroundColor: "ffffff")
        
        UIKitUtil.CreateUIImageButton(alarmView, text: "车辆报警", x: imgx, y: 10, width:imgWidth, height: imgHeight, textColor: "000000", textSize: 13, tag: 8, backgroundImageName: "icon_device_alarm",isShowText:false,selector:#selector(Handle(_:)),target:self)
        
        let alarmtxtButton = UIKitUtil.CreateUiButton(alarmView, text: "车辆报警", x:0,y:texty,width:bottomwidth,height:bottomheight/2, textColor: "000000", textSize: 13, tag: 8)
        alarmtxtButton.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
    }
    
    @objc func Handle(_ sender:UIButton){
        print(sender.tag)
        switch sender.tag {
        case 1:
            let deviceListView = DeviceListViewController()
            deviceListView.title = "设备列表"
            self.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(deviceListView, animated: true)
            break
        case 5:
            let canhistoryView = CanHistoryViewController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(canhistoryView, animated: true)
            
        default:
            break
        }
        self.hidesBottomBarWhenPushed = false
    }
    func LineView(x:CGFloat,y:CGFloat,w:CGFloat,h:CGFloat,color:UIColor) -> UIView{
        let lineView = UIView(frame:CGRect(x:x,y:y,width:2,height:h))
        lineView.backgroundColor = color
        return lineView
    }
}
