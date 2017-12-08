//
//  CanTabViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
class CanViewController : TramUIViewController {
    //左转向灯
    var leftlight:UIImageView!
    //右转向灯
    var rightligh:UIImageView!
    //前雾灯
    var frontfotlight:UIImageView!
    //后雾灯
    var backfotlight:UIImageView!
    //远光灯
    var farlight:UIImageView!
    //近光灯
    var nearlight:UIImageView!
    //刹车灯
    var stoplight:UIImageView!
    //驻车灯
    var parklight:UIImageView!
    //前门
    var frontdoor:UIImageView!
    //中门
    var middoor:UIImageView!
    //加油提示灯
    var batterycharge:UIImageView!
    //abs报警
    var faultabs:UIImageView!
    //
    var faultserious:UIImageView!
    var faultchargeconnect:UIImageView!
    var faultbrake:UIImageView!
    var faultsystem:UIImageView!
    
    var totalmileage:UILabel!
    var totalconsume:UILabel!
    var shortmileage:UILabel!
    var shortconsume:UILabel!
    var surplusgas:UILabel!
    
    var batterytotalvoltage:UILabel!
    var batterytotalelectric:UILabel!
    var press1:UILabel!
    var press2:UILabel!
    
    var speedLabel:UILabel!
    var roteLabel:UILabel!
    
    var blabel1:UILabel!
    var blabel2:UILabel!
    var blabel3:UILabel!
    var blabel4:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //定义title内容
        CustomNavigationBar("仪表盘监控", false, true, false, "N130", 1, 3)
        self.view.backgroundColor = UIColor.hexStringToColor(hexString: "ffffff")
        InitView()
    }
    //初始化View
    func InitView(){
        let height = bounds.height-statusHeight-50
        let baseView = UIView(frame:CGRect(x:0,y:0,width:bounds.width,height:height))
        baseView.backgroundColor = UIColor.hexStringToColor(hexString: "f2f2f2")
        self.view.addSubview(baseView)
        //Can状态指示灯View
        let canStateHeight = height*0.244
        let canSateView = UIKitUtil.CreateUiView(baseView, x: 0, y: 0, width: bounds.width, height: canStateHeight, backgroundColor: "50a2e9")
        let canState2View = UIKitUtil.CreateUiView(canSateView, x: 0, y: canStateHeight*0.33-10, width: bounds.width, height: canStateHeight*0.33+20, backgroundColor: "50a2e9")
        let lightheight = canStateHeight*0.33/2
        let lightwidth = lightheight
        //左右转向灯高度
        let h2 = canStateHeight*0.33/2+10
        leftlight = UIKitUtil.CreateUIImageView(canState2View, "left_light", x: 7, y: (canStateHeight*0.33-h2)/2+10, width: h2, height: h2)
        rightligh = UIKitUtil.CreateUIImageView(canState2View, "right_light", x: bounds.width - h2-7, y: (canStateHeight*0.33-h2)/2+10, width: h2, height: h2)
        let cwidth = bounds.width-(h2*2)-40
        //各指示灯之间间距
        let lj = (cwidth - (lightwidth*9))/8
        let lightView = UIKitUtil.CreateUiView(canState2View, x: h2+20, y: 0, width:cwidth , height: canStateHeight*0.33+20, backgroundColor: "50a2e9")
        //第一行指示灯
        frontfotlight = UIKitUtil.CreateUIImageView(lightView, "front_fog_light", x: 0, y: 0, width: lightwidth, height: lightheight)
        backfotlight = UIKitUtil.CreateUIImageView(lightView, "back_fog_light", x: lightwidth+lj, y: 0, width: lightwidth, height: lightheight)
        farlight = UIKitUtil.CreateUIImageView(lightView, "far_light", x: (lightwidth+lj)*2, y: 0, width: lightwidth, height: lightheight)
        nearlight = UIKitUtil.CreateUIImageView(lightView, "near_light", x: (lightwidth+lj)*3, y: 0, width: lightwidth, height: lightheight)
        stoplight =  UIKitUtil.CreateUIImageView(lightView, "stop_light", x: (lightwidth+lj)*4, y: 0, width: lightwidth, height: lightheight)
        parklight =  UIKitUtil.CreateUIImageView(lightView, "park_light", x: (lightwidth+lj)*5, y: 0, width: lightwidth, height: lightheight)
        frontdoor =  UIKitUtil.CreateUIImageView(lightView, "front_door", x: (lightwidth+lj)*6, y: 0, width: lightwidth, height: lightheight)
        middoor =  UIKitUtil.CreateUIImageView(lightView, "mid_door", x: (lightwidth+lj)*7, y: 0, width: lightwidth, height: lightheight)
        batterycharge = UIKitUtil.CreateUIImageView(lightView, "battery_charge", x: (lightwidth+lj)*8, y: 0, width: lightwidth, height: lightheight)
        //第二行指示灯
        let flw = (cwidth - (lightwidth*5)-(lj*4))/2
        faultabs = UIKitUtil.CreateUIImageView(lightView, "fault_abs", x: flw, y: lightheight+10, width: lightwidth, height: lightheight)
        faultserious = UIKitUtil.CreateUIImageView(lightView, "fault_serious", x: flw+(lightwidth+lj)*1, y: lightheight+10, width: lightwidth, height: lightheight)
        faultchargeconnect = UIKitUtil.CreateUIImageView(lightView, "fault_charge_connect", x: flw+(lightwidth+lj)*2, y: lightheight+10, width: lightwidth, height: lightheight)
        faultbrake = UIKitUtil.CreateUIImageView(lightView, "fault_brake", x: flw+(lightwidth+lj)*3, y: lightheight+10, width: lightwidth, height: lightheight)
        faultsystem = UIKitUtil.CreateUIImageView(lightView, "fault_system", x: flw+(lightwidth+lj)*4, y: lightheight+10, width: lightwidth, height: lightheight)
        
        //各种数值，里程
        let nheight = height*0.145
        let nview = UIKitUtil.CreateUiView(baseView, x: 0, y: canStateHeight, width: bounds.width, height: nheight, backgroundColor: "4599e5")
        let labelwith = bounds.width/5
        totalmileage = UIKitUtil.CreateUILable(nview, text: "总里程\n0\nKM", x: 0, y: (nheight-60)/2, width: labelwith, height: 60, textColor: "ffffff", textSize: 13, textAlign: .center)
        totalmileage.numberOfLines = 0
        totalconsume = UIKitUtil.CreateUILable(nview, text: "总能耗\n0\nL/M3", x: labelwith*1, y: (nheight-60)/2, width: labelwith, height: 60, textColor: "ffffff", textSize: 13, textAlign: .center)
        totalconsume.numberOfLines = 0
        shortmileage = UIKitUtil.CreateUILable(nview, text: "小计里程\n0\nKM", x: labelwith*2, y: (nheight-60)/2, width: labelwith, height: 60, textColor: "ffffff", textSize: 13, textAlign: .center)
        shortmileage.numberOfLines = 0
        shortconsume = UIKitUtil.CreateUILable(nview, text: "瞬时能耗\n0\nL/M3", x: labelwith*3, y: (nheight-60)/2, width: labelwith, height: 60, textColor: "ffffff", textSize: 13, textAlign: .center)
        shortconsume.numberOfLines = 0
        surplusgas = UIKitUtil.CreateUILable(nview, text: "燃油余量\n0\nL", x: labelwith*4, y: (nheight-60)/2, width: labelwith, height: 60, textColor: "ffffff", textSize: 13, textAlign: .center)
        surplusgas.numberOfLines = 0
        
        //转速，车速view
        let sheight = height*0.415
        let sview = UIKitUtil.CreateUiView(baseView, x:0 , y: height*0.389, width: bounds.width, height: sheight, backgroundColor: "ffffff")
        let l2width = bounds.width * 0.3
        batterytotalvoltage = UIKitUtil.CreateUILable(sview, text: "电池总电压(V)\n26.4", x: 0, y: 0, width: l2width, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        batterytotalelectric = UIKitUtil.CreateUILable(sview, text: "电池总电流(A)\n0", x: bounds.width-l2width, y: 0, width: l2width, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        batterytotalvoltage.numberOfLines = 0
        batterytotalelectric.numberOfLines = 0
        UIKitUtil.CreateUiView(sview, x: 0, y: sheight/2, width: bounds.width, height: sheight/2, backgroundColor: "f2f2f2")
        press1 = UIKitUtil.CreateUILable(sview, text: "768\n前气压(mpa)", x: 0, y: sheight-40, width: l2width, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        press2 = UIKitUtil.CreateUILable(sview, text: "788\n后气压(mpa)", x: bounds.width-l2width, y: sheight-40, width: l2width, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        press1.numberOfLines = 0
        press2.numberOfLines = 0
        //定义中心园
        let circleRauids:CGFloat = sheight * 0.665
        let circleView=UIKitUtil.CreateUiView(sview, x: (bounds.width-circleRauids)/2, y: (sheight-circleRauids)/2, width: circleRauids, height: circleRauids, backgroundColor: "e45e52")
        circleView.layer.cornerRadius = CGFloat(circleRauids)/2
        speedLabel = UIKitUtil.CreateUILable(circleView, text: "30\n车速(Km/h)", x: 0, y: 10, width: circleRauids, height: 40, textColor: "ffffff", textSize: 13, textAlign: .center)
        speedLabel.numberOfLines = 0
        roteLabel = UIKitUtil.CreateUILable(circleView, text: "转速(r/min)\n1100", x: 0, y: circleRauids-50, width: circleRauids, height: 40, textColor: "ffffff", textSize: 13, textAlign: .center)
        roteLabel.numberOfLines = 0
        //底部4个圆圈
        
        let bheight = height * 0.195
        let bview = UIKitUtil.CreateUiView(baseView, x: 0, y: height*0.804, width: bounds.width, height: bheight, backgroundColor: "ffffff")
        let circleHeight = bheight * 0.836
        //各yuan的间隔
        let bjk = (bounds.width - (circleHeight*4)) / 8
        let bhk = (bheight-circleHeight)/2
        let circle1 = UIKitUtil.CreateUiView(bview, x: bjk, y: bhk, width: circleHeight, height: circleHeight, backgroundColor: "ffffff")
        circle1.layer.cornerRadius = circleHeight/2
        circle1.layer.borderColor = UIColor.hexStringToColor(hexString: "949495").cgColor
        circle1.layer.borderWidth = 1
        blabel1 = UIKitUtil.CreateUILable(circle1, text: "0℃/0℃\n内温/外温", x: 0, y: (circleHeight-40)/2, width: circleHeight, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        blabel1.numberOfLines = 0
        let circle2 = UIKitUtil.CreateUiView(bview, x: (circleHeight)*1+(bjk)*2+bjk, y: bhk, width: circleHeight, height: circleHeight, backgroundColor: "ffffff")
        circle2.layer.cornerRadius = circleHeight/2
        circle2.layer.borderColor = UIColor.hexStringToColor(hexString: "949495").cgColor
        circle2.layer.borderWidth = 1
        blabel2 = UIKitUtil.CreateUILable(circle2, text: "26.4V\n蓄电池电压", x: 0, y: (circleHeight-40)/2, width: circleHeight, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        blabel2.numberOfLines = 0
        let circle3 = UIKitUtil.CreateUiView(bview, x: (circleHeight)*2+(bjk)*4+bjk, y: bhk, width: circleHeight, height: circleHeight, backgroundColor: "ffffff")
        circle3.layer.cornerRadius = circleHeight/2
        circle3.layer.borderColor = UIColor.hexStringToColor(hexString: "949495").cgColor
        circle3.layer.borderWidth = 1
        blabel3 = UIKitUtil.CreateUILable(circle3, text: "60mpa\n机油压力", x: 0, y: (circleHeight-40)/2, width: circleHeight, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        blabel3.numberOfLines = 0
        let circle4 = UIKitUtil.CreateUiView(bview, x: (circleHeight)*3+(bjk)*6+bjk, y: bhk, width: circleHeight, height: circleHeight, backgroundColor: "ffffff")
        circle4.layer.cornerRadius = circleHeight/2
        circle4.layer.borderColor = UIColor.hexStringToColor(hexString: "949495").cgColor
        circle4.layer.borderWidth = 1
        blabel4 = UIKitUtil.CreateUILable(circle4, text: "84℃\n水温", x: 0, y: (circleHeight-40)/2, width: circleHeight, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        blabel4.numberOfLines = 0
        
    }
}
