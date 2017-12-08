//
//  DeviceViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/8.//  Copyright © 2017年  tvis. All rights reserved.

//

import UIKit
class DeviceViewController: TramUIViewController {
    var deviceImage:UIImageView!
    var deviceTypeLabel:UILabel!
    var deviceOnlineLabel:UILabel!
    var lineLabel:UILabel!
    var driverLabel:UILabel!
    
    var mileageLabel:UILabel!
    var dianhaoLabel:UILabel!
    var gashaoLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomNavigationAnalysisBar("单车分析", false, true, false, "N130", 7)
        initView()
    }
    
    func initView(){
        let height = bounds.height - statusHeight
        let baseView = UIKitUtil.CreateUiView(self.view, x: 0, y: 0, width: bounds.width, height: height, backgroundColor: "dedede")
        let infoHeight = height * 0.1787
        let infoView = UIKitUtil.CreateUiView(baseView, x: 0, y: 0, width: bounds.width, height: infoHeight, backgroundColor: "ffffff")
        let infoImageHeight = infoHeight-20
        deviceImage = UIKitUtil.CreateUIImageView(infoView, "ic_vehicle", x: 10, y: 10, width: infoImageHeight, height: infoImageHeight)
        let itemHeight = (infoImageHeight-6)/3
        deviceTypeLabel = UIKitUtil.CreateUILable(infoView, text: "汽油车(传统)", x: infoImageHeight+20, y: 10, width: 90, height: itemHeight, textColor: "ffffff", textSize: 13, textAlign: .center)
        deviceTypeLabel.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
        deviceTypeLabel.layer.cornerRadius = 2
        deviceOnlineLabel = UIKitUtil.CreateUILable(infoView, text: "在线", x: infoImageHeight+115, y: 10, width: 38, height: itemHeight, textColor: "ffffff", textSize: 13, textAlign: .center)
        deviceOnlineLabel.backgroundColor = UIColor.hexStringToColor(hexString: "25d73a")
        deviceOnlineLabel.layer.cornerRadius = 2
        let lineImage = UIKitUtil.CreateUIImageView(infoView, "icon_line", x: infoImageHeight+20, y: 13+itemHeight, width: itemHeight, height: itemHeight)
        lineLabel = UIKitUtil.CreateUILable(infoView, text: "250路", x: infoImageHeight+itemHeight+25, y: 13+itemHeight, width: 100, height: itemHeight, textColor: "000000", textSize: 13, textAlign: .left)
        let driverImage = UIKitUtil.CreateUIImageView(infoView, "icon_person", x: infoImageHeight+20, y: 16+itemHeight*2, width: itemHeight, height: itemHeight)
        driverLabel = UIKitUtil.CreateUILable(infoView, text: "驾驶员:张三", x: infoImageHeight+itemHeight+25, y: 16+itemHeight*2, width: 100, height: itemHeight, textColor: "000000", textSize: 13, textAlign: .left)
        
        let sheight = height*0.142
        let sview = UIKitUtil.CreateUiView(baseView, x: 0, y: infoHeight+1, width: bounds.width, height: sheight, backgroundColor: "ffffff")
        let smallviewwidth = bounds.width*0.333
        let s1view = UIKitUtil.CreateUiView(sview, x: 10, y: 10, width: smallviewwidth, height: sheight-20, backgroundColor: "51d2c2")
        let mileageImage = UIKitUtil.CreateUIImageView(s1view, "icon_mile", x: 8, y: (sheight-20)/4, width: smallviewwidth*0.5-16, height: (sheight-20)/2)
        let lv1 = UIKitUtil.CreateUiView(s1view, x: smallviewwidth*0.5, y: 0, width: smallviewwidth*0.5, height: sheight-20, backgroundColor: "ffffff")
        mileageLabel = UIKitUtil.CreateUILable(lv1, text: "里程\n1620.90\nKM", x: 0, y: (sheight-80)/2, width: smallviewwidth*0.5, height: 60, textColor: "000000", textSize: 13, textAlign: .center)
        mileageLabel.numberOfLines = 0
        let s2view = UIKitUtil.CreateUiView(sview, x: smallviewwidth+10, y: 10, width: smallviewwidth, height: sheight-20, backgroundColor: "95dd25")
        let dianhaoImage = UIKitUtil.CreateUIImageView(s2view, "icon_ele", x: 17, y: (sheight-20)/4, width: smallviewwidth*0.5-34, height: (sheight-20)/2)
        let lv2 = UIKitUtil.CreateUiView(s2view, x: smallviewwidth*0.5, y: 0, width: smallviewwidth*0.5, height: sheight-20, backgroundColor: "ffffff")
        dianhaoLabel = UIKitUtil.CreateUILable(lv2, text: "电耗\n0.00\nKW/H", x: 0, y: (sheight-80)/2, width: smallviewwidth*0.5, height: 60, textColor: "000000", textSize: 13, textAlign: .center)
        dianhaoLabel.numberOfLines = 0
        let s3view = UIKitUtil.CreateUiView(sview, x: smallviewwidth*2+10, y: 10, width: smallviewwidth, height: sheight-20, backgroundColor: "fb7551")
        let gasImage = UIKitUtil.CreateUIImageView(s3view, "icon_gas", x: 15, y: (sheight-20)/4, width: smallviewwidth*0.5-30, height: (sheight-20)/2)
        let lv3 = UIKitUtil.CreateUiView(s3view, x: smallviewwidth*0.5, y: 0, width: smallviewwidth*0.5, height: sheight-20, backgroundColor: "ffffff")
        gashaoLabel = UIKitUtil.CreateUILable(lv3, text: "油耗\n0.00\nL", x: 0, y: (sheight-80)/2, width: smallviewwidth*0.5, height: 60, textColor: "000000", textSize: 13, textAlign: .center)
        gashaoLabel.numberOfLines = 0
        
        let aheight = height * 0.1606
        let actionView = UIKitUtil.CreateUiView(baseView, x: 0, y: height*0.3207+8, width: bounds.width, height: aheight, backgroundColor: "ffffff")
        let awidth = (bounds.width-2)/3
        let as1view = UIKitUtil.CreateUiView(actionView, x: 0, y: 0, width: awidth, height: aheight, backgroundColor: "ffffff")
        let locationImage = UIKitUtil.CreateUIImageButton(as1view, text: "", x: (awidth-(aheight-50))/2, y: 15, width: aheight-50, height: aheight-50, textColor: "000000", textSize: 13, tag: 1, backgroundImageName: "icon_track", isShowText: false, selector: #selector(Handle(_:)), target: self)
        UIKitUtil.CreateUiButton(as1view, text: "车辆追踪", x: 0, y: aheight-35, width: awidth, height: 20, textColor: "000000", textSize: 13, tag: 1).addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        UIKitUtil.CreateUiView(actionView, x: awidth, y: 10, width: 1, height: aheight-20, backgroundColor: "dedede")
        
        let as2view = UIKitUtil.CreateUiView(actionView, x: awidth+1, y: 0, width: awidth, height: aheight, backgroundColor: "ffffff")
        let hisImage = UIKitUtil.CreateUIImageButton(as2view, text: "", x: (awidth-(aheight-50))/2, y: 15, width: aheight-50, height: aheight-50, textColor: "000000", textSize: 13, tag: 2, backgroundImageName: "icon_review", isShowText: false, selector: #selector(Handle(_:)), target: self)
        UIKitUtil.CreateUiButton(as2view, text: "轨迹回放", x: 0, y: aheight-35, width: awidth, height: 20, textColor: "000000", textSize: 13, tag: 2).addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        UIKitUtil.CreateUiView(actionView, x: awidth*2+1, y: 10, width: 1, height: aheight-20, backgroundColor: "dedede")
        
        let as3view = UIKitUtil.CreateUiView(actionView, x: awidth*2+2, y: 0, width: awidth, height: aheight, backgroundColor: "ffffff")
        let dashImage = UIKitUtil.CreateUIImageButton(as3view, text: "", x: (awidth-(aheight-50))/2, y: 20, width: aheight-50, height: aheight-55, textColor: "000000", textSize: 13, tag: 3, backgroundImageName: "icon_dashboard", isShowText: false, selector: #selector(Handle(_:)), target: self)
        UIKitUtil.CreateUiButton(as3view, text: "仪表盘监控", x: 0, y: aheight-35, width: awidth, height: 20, textColor: "000000", textSize: 13, tag: 3).addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        
        let itemView = UIKitUtil.CreateUiView(baseView, x: 0, y: height*0.4813+16, width: bounds.width, height: height-(height*0.4813+16), backgroundColor: "ffffff")
        let itemHeight2 = height * 0.08
        craetaItemView(itemView,"报警分析",4,0,itemHeight2)
        craetaItemView(itemView,"安全行为",5,itemHeight2,itemHeight2)
        craetaItemView(itemView,"维保信息",6,itemHeight2*2,itemHeight2)
    }
    func craetaItemView(_ parentView:UIView,_ itemName:String,_ tag:Int,_ top:CGFloat,_ itemHeight:CGFloat){
        let view = UIKitUtil.CreateUiView(parentView, x: 0, y: top, width: bounds.width, height: itemHeight, backgroundColor: "ffffff")
        view.layer.borderColor = UIColor.hexStringToColor(hexString: "dedede").cgColor
        view.layer.borderWidth = 1
        let itemTop = itemHeight/2 - 10
        let button = UIKitUtil.CreateUiButton(view, text: itemName, x: 0, y: itemTop, width: bounds.width, height: 20, textColor: "000000", textSize: 13, tag: tag)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        UIKitUtil.CreateUIImageView(view, "ic_tz", x: bounds.width-30, y: (itemHeight-20)/2, width: 20, height: 20)
        button.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        
    }
    @objc func Handle(_ sender:UIButton){
        print(sender.tag)
        switch sender.tag {
        case 1:
            print("定位")
        case 2:
            print("轨迹")
        case 3:
            print("监控")
        default:
            break
        }
    }
}
