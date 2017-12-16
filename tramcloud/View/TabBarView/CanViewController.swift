//
//  CanTabViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
class CanViewController : TramUIViewController,CanView {
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
    var canPresenter:CanPresenter!
    var deviceCode:String = ""
    var totalTime:Int = 1
    var intervalTime:Int = 3
    var NowSecondTime:Int = 0
    private var timer:Timer!
    var pageStepTime:DispatchTimeInterval = .seconds(3)
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultDeviceInfo = GetDefaultDevice()
        //定义title内容
        self.view.backgroundColor = UIColor.hexStringToColor(hexString: "ffffff")
        InitView()
        if(canPresenter == nil){
            canPresenter = CanPresenter(self.view,self)
        }
        self.pageStepTime = .seconds(intervalTime)        
        deviceCode = defaultDeviceInfo!.Name!
        CustomNavigationBar("仪表盘监控", false, true, false, deviceCode, totalTime, intervalTime,2)
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
    //初始化View
    func InitView(){
        let height = bounds.height-AppDelegate().StatusHeight-AppDelegate().TabBarHeight-40
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
        batterytotalvoltage = UIKitUtil.CreateUILable(sview, text: "电池总电压(V)\n0.0", x: 0, y: 0, width: l2width, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        batterytotalelectric = UIKitUtil.CreateUILable(sview, text: "电池总电流(A)\n0", x: bounds.width-l2width, y: 0, width: l2width, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        batterytotalvoltage.numberOfLines = 0
        batterytotalelectric.numberOfLines = 0
        UIKitUtil.CreateUiView(sview, x: 0, y: sheight/2, width: bounds.width, height: sheight/2, backgroundColor: "f2f2f2")
        press1 = UIKitUtil.CreateUILable(sview, text: "0\n前气压(mpa)", x: 0, y: sheight-40, width: l2width, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        press2 = UIKitUtil.CreateUILable(sview, text: "0\n后气压(mpa)", x: bounds.width-l2width, y: sheight-40, width: l2width, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        press1.numberOfLines = 0
        press2.numberOfLines = 0
        //定义中心园
        let circleRauids:CGFloat = sheight * 0.665
        let circleView=UIKitUtil.CreateUiView(sview, x: (bounds.width-circleRauids)/2, y: (sheight-circleRauids)/2, width: circleRauids, height: circleRauids, backgroundColor: "e45e52")
        circleView.layer.cornerRadius = CGFloat(circleRauids)/2
        speedLabel = UIKitUtil.CreateUILable(circleView, text: "30", x: 0, y: 10, width: circleRauids, height: 20, textColor: "ffffff", textSize: 16, textAlign: .center)
        let speedbLabel = UIKitUtil.CreateUILable(circleView, text: "车速(Km/h)", x: 0, y: 30, width: circleRauids, height: 20, textColor: "ffffff", textSize: 13, textAlign: .center)
        speedLabel.numberOfLines = 0
        let rotebLabel = UIKitUtil.CreateUILable(circleView, text: "转速(r/min)", x: 0, y: circleRauids-50, width: circleRauids, height: 20, textColor: "ffffff", textSize: 13, textAlign: .center)
        roteLabel = UIKitUtil.CreateUILable(circleView, text: "1100", x: 0, y: circleRauids-30, width: circleRauids, height: 20, textColor: "ffffff", textSize: 16, textAlign: .center)
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
        blabel2 = UIKitUtil.CreateUILable(circle2, text: "0.0V\n蓄电池电压", x: 0, y: (circleHeight-40)/2, width: circleHeight, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        blabel2.numberOfLines = 0
        let circle3 = UIKitUtil.CreateUiView(bview, x: (circleHeight)*2+(bjk)*4+bjk, y: bhk, width: circleHeight, height: circleHeight, backgroundColor: "ffffff")
        circle3.layer.cornerRadius = circleHeight/2
        circle3.layer.borderColor = UIColor.hexStringToColor(hexString: "949495").cgColor
        circle3.layer.borderWidth = 1
        blabel3 = UIKitUtil.CreateUILable(circle3, text: "0mpa\n机油压力", x: 0, y: (circleHeight-40)/2, width: circleHeight, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        blabel3.numberOfLines = 0
        let circle4 = UIKitUtil.CreateUiView(bview, x: (circleHeight)*3+(bjk)*6+bjk, y: bhk, width: circleHeight, height: circleHeight, backgroundColor: "ffffff")
        circle4.layer.cornerRadius = circleHeight/2
        circle4.layer.borderColor = UIColor.hexStringToColor(hexString: "949495").cgColor
        circle4.layer.borderWidth = 1
        blabel4 = UIKitUtil.CreateUILable(circle4, text: "0℃\n水温", x: 0, y: (circleHeight-40)/2, width: circleHeight, height: 40, textColor: "000000", textSize: 13, textAlign: .center)
        blabel4.numberOfLines = 0
        
    }
}
//网络处理
extension CanViewController{
    
    //开始定时器
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.intervalTime), target: self,
                                     selector: #selector(intervalFunc), userInfo: nil, repeats: true);
        timer.fire()
    }
    //结束定时器
    func endTimer(){
        if(timer != nil){
            timer.invalidate()
            timer = nil
            Toast.show(with: "监控结束")
            self.NowSecondTime = 0
        }
        
    }
    //定制执行函数
    @objc func intervalFunc(){
        if(self.NowSecondTime >= (self.totalTime * 60)){
            self.endTimer()
            self.NowSecondTime = 0
        }else{
            self.NowSecondTime += self.intervalTime
            if(self.canPresenter == nil){
                self.canPresenter = CanPresenter(self.view,self)
            }
            self.canPresenter.GetCanData(self.deviceCode)
        }
    }
   
    func GetCanResult(_ data: CanModel) {
        DispatchQueue.main.async {
            self.BindUiView(data)
        }
    }
    
    //获得CAN状态在线是再执行定时器
    func GetCanState(_ onlieState: DataStateModel) {
        if(onlieState.canstate){
            self.startTimer()
        }else{
            Toast.show(with: "车辆CAN不在线")
        }
    }
    
    func reloadData(){
        if(deviceCode == ""){
            Toast.fail(with: "当前无在线设备")
        }else{
            canPresenter.GetDataState(deviceCode)
        }
    }
}
//从筛选界面回传处理
extension CanViewController:ValueBackDelegate{
    func ValueBack(type: Int, value: AnyObject) {
        let model = value as? DeviceFilterResult
        CustomNavigationBar("仪表盘监控", false, true, false, (model?.deviceName)!, (model?.totalTime)!, (model?.intervalTime)!, 2)
        self.deviceCode = (model?.deviceName)!
        self.totalTime = (model?.totalTime)!
        self.intervalTime = (model?.intervalTime)!
        self.pageStepTime = .seconds((model?.intervalTime)!)
    }
    
}

//UI界面渲染
extension CanViewController{
    
    //更新灯组状态
    func UpdateLightStyle(_ lightImage:UIImageView,_ image:String,_ value:Int){
        var lastImage = image
        if(value == 2)
        {
            lastImage = image + "_on"
        }
        if(value != 0){
            lightImage.image = UIImage(named:lastImage)
        }
    }
    
    func BindUiView(_ canInfo:CanModel){
        //灯组
        self.UpdateLightStyle(self.leftlight, "left_light", (canInfo.canstatinfo?.leftturn)!)
        self.UpdateLightStyle(self.rightligh, "right_light", (canInfo.canstatinfo?.rightturn)!)
        self.UpdateLightStyle(self.frontfotlight, "front_fog_light", (canInfo.canstatinfo?.beforefoglampsturn)!)
        self.UpdateLightStyle(self.backfotlight, "back_fog_light", (canInfo.canstatinfo?.afterfoglampsturn)!)
        self.UpdateLightStyle(self.farlight, "far_light", (canInfo.canstatinfo?.highbeamturn)!)
        self.UpdateLightStyle(self.nearlight, "near_light", (canInfo.canstatinfo?.dippedlightsturn)!)
        self.UpdateLightStyle(self.stoplight, "stop_light", (canInfo.canstatinfo?.footbraketurn)!)
        self.UpdateLightStyle(self.parklight, "park_light", (canInfo.canstatinfo?.parkingbraketurn)!)
        self.UpdateLightStyle(self.frontfotlight, "front_door", (canInfo.canstatinfo?.headerdoorturn)!)
        self.UpdateLightStyle(self.middoor, "mid_door", (canInfo.canstatinfo?.middledoorturn)!)
        self.UpdateLightStyle(self.faultabs, "fault_abs", (canInfo.canstatinfo?.absturn)!)
        self.totalmileage.text = "总里程\n"+(canInfo.caninfo?.totalmileage)!+"\nKM"
        self.shortmileage.text = "小计里程\n"+(canInfo.caninfo?.shortmileage)!+"\nKM"
        self.surplusgas.text = "燃油余量\n"+(canInfo.caninfo?.oilmass)!+"\nL"
        if(canInfo.caninfo?.totalbattertvoltage != nil){
            self.batterytotalvoltage.text = "电池总电压(V)\n"+(canInfo.caninfo?.totalbattertvoltage)!
        }
        if(canInfo.caninfo?.totalbatterygenerator != nil){
            self.batterytotalelectric.text = "电池总电流(A)\n0"+(canInfo.caninfo?.totalbatterygenerator)!
        }
        if(canInfo.caninfo?.leftpress != nil){
            self.press1.text = (canInfo.caninfo?.leftpress)!+"\n前气压(mpa)"
        }
        if(canInfo.caninfo?.rightpress != nil){
            self.press2.text = (canInfo.caninfo?.rightpress)!+"\n后气压(mpa)"
        }
        if(canInfo.caninfo?.speed != nil){
            self.speedLabel.text = canInfo.caninfo?.speed
        }
        if(canInfo.caninfo?.roate != nil){
            let rote = canInfo.caninfo?.roate
            self.roteLabel.text = "\(rote)"
        }
        if(canInfo.caninfo?.incartemp != nil && canInfo.caninfo?.outcartemp != nil){
            self.blabel1.text = (canInfo.caninfo?.incartemp)!+"℃/"+(canInfo.caninfo?.outcartemp)!+"℃\n内温/外温"
        }
        if(canInfo.caninfo?.soc != nil){
            self.blabel2.text = (canInfo.caninfo?.soc)!+"V\n蓄电池电压"
        }
        if(canInfo.caninfo?.oilpressure != nil){
            self.blabel3.text = (canInfo.caninfo?.oilpressure)!+"mpa\n机油压力"
        }
        if(canInfo.caninfo?.watertemp != nil){
            self.blabel4.text = (canInfo.caninfo?.watertemp)!+"℃\n水温"
        }
        
    }
}
