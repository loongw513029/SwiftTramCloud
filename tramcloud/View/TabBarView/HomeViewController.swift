//
//  HomeViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import UIKit
import Charts
import SnapKit
import RxCocoa
import RxSwift

class HomeViewController: TramUIViewController,ChartViewDelegate,HomeView {
    
    var carnotext:UIButton!
    var onlinetext:UIButton!
    var linetext:UIButton!
    var yctext:UIButton!
    var xAlias = [[String]]()
    var yAlias = [[UInt]]()
    var titles = [String]()
    var scrollView:UIScrollView!
    var chartView:UIView!
    var homePresenter:HomePresenter!
    var AppTitle = "车辆云管理"
    var lineId:Int? = 0
    var userId:Int?
    var defaultDeviceCode:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()       
        self.navigationItem.title = AppTitle
        self.view.backgroundColor=UIColor.hexStringToColor(hexString: "f2f2f2")
        self.InitView()
        let rightButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(showMorePage))
        rightButton.image = UIImage(named:"ic_more")
        rightButton.tintColor = UIColor.white
        rightButton.tag = 1
        rightButton.width = -20
        // 添加左侧、右侧按钮
        self.navigationItem.setRightBarButton(rightButton, animated: true)
        if(homePresenter == nil){
            homePresenter = HomePresenter(self.view,self)
        }
        userId = userInfo.Id!
        self.reloadData()
        homePresenter.GetDefaultDeviceCodesAndOnlySelectOnlineDevice()
    }
   
    func InitView(){
        chartView = UIKitUtil.CreateUiView(self.view,x: 0, y: 0, width: bounds.width, height: bounds.height*0.32, backgroundColor: "0b9bee")
        self.view.addSubview(chartView)
        initScrollView(chartView)
        //中间车辆总数，在线数量，线路条数，异常行为
        let navNumberView=UIKitUtil.CreateUiView(self.view,x:0,y:bounds.height*0.32,width:bounds.width,height:bounds.height*0.13,backgroundColor:"ffffff")
        let labelWidth = bounds.width/4-1
        let labelHeight = bounds.height*0.13
        let carnoView=UIKitUtil.CreateUiView(navNumberView, x:0,y:0,width:labelWidth,height:labelHeight, backgroundColor: "ffffff")
        let carnoLabel=UIKitUtil.CreateUILable(carnoView, text: "车辆台数", x:0,y:15,width:labelWidth,height:20, textColor: "00000", textSize: 13, textAlign: .center)
        carnotext=UIKitUtil.CreateUiButton(carnoView, text: "0", x:0,y:35,width:labelWidth,height:labelHeight-35, textColor: "0b9bee", textSize: 14, tag: 1)
        UIKitUtil.CreateUiView(navNumberView, x: labelWidth, y: 10, width: 1, height: labelHeight-20, backgroundColor: "dedede")
   
        carnotext.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        let onlineView=UIKitUtil.CreateUiView(navNumberView, x:labelWidth+1,y:0,width:labelWidth,height:labelHeight, backgroundColor: "ffffff")
        let onlineLabel=UIKitUtil.CreateUILable(onlineView, text: "在线台数", x:0,y:15,width:labelWidth,height:20, textColor: "00000", textSize:13,textAlign: .center)
        onlinetext=UIKitUtil.CreateUiButton(onlineView, text: "0", x:0,y:35,width:labelWidth,height:labelHeight-35, textColor: "0b9bee", textSize: 14, tag: 2)
        onlinetext.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        UIKitUtil.CreateUiView(navNumberView, x: labelWidth*2, y: 10, width: 1, height: labelHeight-20, backgroundColor: "dedede")
        
        let lineView=UIKitUtil.CreateUiView(navNumberView, x:labelWidth*2+2,y:0,width:labelWidth,height:labelHeight, backgroundColor: "ffffff")
        let lineLabel=UIKitUtil.CreateUILable(lineView, text: "线路条数", x:0,y:15,width:labelWidth,height:20, textColor: "00000", textSize: 13, textAlign: .center)
        linetext=UIKitUtil.CreateUiButton(lineView, text: "0", x:0,y:35,width:labelWidth,height:labelHeight-35, textColor: "0b9bee", textSize: 14, tag: 3)
        UIKitUtil.CreateUiView(navNumberView, x: labelWidth*3, y: 10, width: 1, height: labelHeight-20, backgroundColor: "dedede")
        linetext.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        
        let ycView=UIKitUtil.CreateUiView(navNumberView, x:labelWidth*3+3,y:0,width:labelWidth,height:labelHeight, backgroundColor: "ffffff")
        let ycLabel=UIKitUtil.CreateUILable(ycView, text: "异常行为", x:0,y:15,width:labelWidth,height:20, textColor: "00000", textSize: 13, textAlign: .center)
        yctext=UIKitUtil.CreateUiButton(ycView, text: "0", x:0,y:35,width:labelWidth,height:labelHeight-35, textColor: "0b9bee", textSize: 14, tag: 4)
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
    func initScrollView(_ view:UIView){
        scrollView = UIScrollView()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.bounds.width * 2,height: view.bounds.height)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        view.addSubview(scrollView)
    }
    
    
    
    @objc func Handle(_ sender:UIButton){
       
        switch sender.tag {
        case 1:
            let deviceListView = DeviceListViewController()
            deviceListView.tag = 1
            deviceListView.title = "设备列表"
            self.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(deviceListView, animated: true)
            break
        case 2:
            let deviceListView = DeviceListViewController()
            deviceListView.tag = 2
            deviceListView.title = "在线列表"
            self.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(deviceListView, animated: true)
            break
        case 5:
            let canhistoryView = CanHistoryViewController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(canhistoryView, animated: true)
        case 8:
            let canAlarmView = CarAlarmChartController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController!.pushViewController(canAlarmView,animated:true)
            break
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

extension HomeViewController{
    func reloadData(){
        homePresenter.GetHomeChartData(self.userId!, self.lineId!)
    }
    func createChartView(_ scrollView:UIScrollView,_ index:Int,xAlis:[String],yAlis:[UInt],title:String){
        var x:CGFloat = 0;
        if(index>0){
            x = bounds.width * CGFloat(index)
        }
        var lineChart = LineChartView.init(frame:CGRect(x:x,y:0,width:bounds.width,height:bounds.height*0.32))
        lineChart.delegate = self
        lineChart.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
        scrollView.addSubview(lineChart)
        setChart(lineChart,xAlis, values: yAlis,thema: title)
    }
    
    func setChart(_ lineChart:LineChartView,_ dataPoints: [String], values: [UInt],thema:String) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "单位：次")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        lineChart.data = lineChartData
        //右下角图标描述
        lineChart.chartDescription?.text = thema
        lineChart.chartDescription?.textColor = UIColor.white
        lineChart.chartDescription?.font = UIFont.boldSystemFont(ofSize: 14)
        
        //左下角图例
        //        lineChart.legend.formSize = 30
        //        lineChart.legend.form = .square
        lineChart.legend.textColor = UIColor.white
        
        //设置X轴坐标
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChart.xAxis.granularity = 1.0
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.axisLineColor = UIColor.white
        lineChart.xAxis.labelTextColor = UIColor.white
        
        //设置Y轴坐标
        //        lineChart.rightAxis.isEnabled = false
        //不显示右侧Y轴
        lineChart.rightAxis.drawAxisLineEnabled = true
        //不显示右侧Y轴数字
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.axisLineColor = UIColor.white
        lineChart.leftAxis.gridColor = UIColor.white
        lineChart.leftAxis.labelTextColor = UIColor.white
        
        //设置双击坐标轴是否能缩放
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false
        
        //        lineChart.dragEnabled = true
        //        lineChart.dragDecelerationEnabled = true
        
        //设置图表背景色和border
        //必须设置enable才能有效
        //        lineChart.drawGridBackgroundEnabled = true
        //        lineChart.drawBordersEnabled = true
        //        lineChart.gridBackgroundColor = UIColor.red
        //        lineChart.borderColor = UIColor.orange
        //        lineChart.borderLineWidth = 5
        
        //设置折线线条
        //        lineChartDataSet.fillColor = kDefault_0xff6600_clolr
        //        lineChartDataSet.lineWidth = 4
        
        //外圆
        lineChartDataSet.setCircleColor(UIColor.white)
        //画外圆
        //        lineChartDataSet.drawCirclesEnabled = true
        //内圆
        lineChartDataSet.circleHoleColor = UIColor.white
        //画内圆
        //        lineChartDataSet.drawCircleHoleEnabled = true
        //线条显示样式
        //        lineChartDataSet.lineDashLengths = [1,3,4,2]
        //        lineChartDataSet.lineDashPhase = 0.5
        lineChartDataSet.colors = [UIColor.white]
        //线条上的文字
        lineChartDataSet.valueColors = [UIColor.white]
        //显示
        lineChartDataSet.drawValuesEnabled = true
        //添加显示动画
        lineChart.animate(xAxisDuration: 1)
    }
    func GetHomeData(_ data: HomeChartViewModel) {
        titles = [String]()
        xAlias = [[String]]()
        yAlias = [[UInt]]()
        carnotext.setTitle(String(data.TotalDeviceCount!), for: .normal)
        onlinetext.setTitle(String(data.OnLineDeviceCount!), for: .normal)
        linetext.setTitle(String(data.TotalLineCount!), for: .normal)
        yctext.setTitle(String(data.TotalUnsafeCount!), for: .normal)
        for i in 0..<data.ChartList!.count{
            let Chart = data.ChartList![i]
            titles.append(Chart.ChartName!)
            var xAliaItem = [String]()
            var yAliaItem = [UInt]()
            for j in 0..<Chart.Data!.count{
                let item  = Chart.Data![j]
                xAliaItem.append(item.AxisName!)
                yAliaItem.append(item.AxisValue!)
            }
            xAlias.append(xAliaItem)
            yAlias.append(yAliaItem)
        }
        for i in 0..<2{
            createChartView(scrollView, i, xAlis: xAlias[i], yAlis: yAlias[i], title: titles[i])
        }
    }
    
    func GetAppHomeModel(_ data: [AppDropDownModel]) {
        var deviceInfo:AppDropDownModel!
        for i in 0..<data.count{
            let device = data[i]
            if(device.IsOnline)!{
                deviceInfo = device
                break
            }
        }
        if(deviceInfo != nil){
            UserDefaultUtil.setNormalDefault("DefaultDevice", deviceInfo.toJSONString(prettyPrint: true))
        }else{
            UserDefaultUtil.setNormalDefault("DefaultDevice", "")
        }
    }
    
}
extension HomeViewController : ValueBackDelegate{
    
    func ValueBack(type: Int, value: AnyObject) {
        let model = value as? DeviceFilterResult
        updateTabbarItem(title:self.AppTitle,linename: (model?.lineName)!)
        self.lineId = model?.lineId
        self.reloadData()
        
    }
    
}
