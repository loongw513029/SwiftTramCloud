//
//  CarAlarmViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/15.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import SnapKit
import Charts
class CarAlarmChartController : TramUIViewController{
    var barChartView:BarChartView!
    var alarmPresenter:AlarmPresenter!
    var dayType:Int = 3
    var height:CGFloat = 0
    var baseView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomNavigationAnalysisBar("报警统计", false, false, false, GetSelLineId()==0 ? "全部线路" : "", 7, 2)
        self.initView()
        if(alarmPresenter == nil){
           self.alarmPresenter = AlarmPresenter(self.view,self)
        }
        self.reloadData()
    }
    
    func initView(){
        height = bounds.height - AppDelegate().StatusHeight-40
        baseView = UIKitUtil.CreateUiView(self.view, x: 0, y: 0, width: bounds.width, height: height, backgroundColor: "f2f2f2")
        let chartHeight = height*0.45
        var chartView = UIKitUtil.CreateUiView(baseView, x: 0, y: 0, width: bounds.width, height: chartHeight, backgroundColor: "ffffff")
        barChartView = BarChartView(frame: CGRect(x:0,y:0,width:bounds.width,height:chartHeight))
        chartView.addSubview(barChartView)
        self.initChartView()
        
    }
    func initChartView(){
        self.barChartView.chartDescription?.enabled  = false
        self.barChartView.pinchZoomEnabled = false
        self.barChartView.drawBarShadowEnabled = false
        self.barChartView.noDataText = "未查询到数据！"
        let xAxis = self.barChartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 10,weight:.light)
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        let leftAxis = self.barChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10,weight:.light)
        leftAxis.valueFormatter = LargeValueFormatter()
        leftAxis.spaceTop = 0.35
        leftAxis.axisMinimum = 0
        self.barChartView.rightAxis.enabled = false
    }
}
extension CarAlarmChartController : AlarmChartView{
    
    func reloadData(){
        self.alarmPresenter.GetAlarmCharts(userInfo.Id!, GetSelLineId(), self.dayType)
    }
    func GetAlarmCharts(_ data: AlarmChartModel) {
        let groupSpace = 0.02
        let barSpace = 0.1
        let barWidth = 0.2
        let xAias = data.xVals
        var xAias2 = [String]()
        var yVals1:[BarChartDataEntry] = []
        var yVals2:[BarChartDataEntry] = []
        var yVals3:[BarChartDataEntry] = []
        var count:Int = (xAias?.count)!
        for i in 0..<count{
            yVals1.append(BarChartDataEntry(x:Double(i),y:Double(data.yVals![0].Val![i])))
            yVals2.append(BarChartDataEntry(x:Double(i),y:Double(data.yVals![1].Val![i])))
            yVals3.append(BarChartDataEntry(x:Double(i),y:Double(data.yVals![2].Val![i])))
            xAias2.append(xAias![i]+"日")
        }
        let set1 = BarChartDataSet(values: yVals1, label: "人员")
        set1.setColor(UIColor.hexStringToColor(hexString: "1296db"))
        let set2 = BarChartDataSet(values: yVals2, label: "设备")
        set2.setColor(UIColor.hexStringToColor(hexString: "13227a"))
        let set3 = BarChartDataSet(values: yVals3, label: "运营")
        set3.setColor(UIColor.hexStringToColor(hexString: "1afa29"))
        let barChartData = BarChartData(dataSets: [set1, set2, set3])
        barChartData.setValueFont(.systemFont(ofSize: 10, weight: .light))
        //data.setValueFormatter(LargeValueFormatter())
        barChartData.barWidth = barWidth
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAias2)
        barChartView.xAxis.granularity = 1.0
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartData.groupBars(fromX: Double(0), groupSpace: groupSpace, barSpace: barSpace)
        barChartView.data = barChartData
        let modes = data.modes!
        let itemHeight = height*0.15
        for b in 0..<modes.count{
            let nView = UIKitUtil.CreateUiView(baseView, x: 0, y: (self.height*0.45+10)+(self.height*0.15)*CGFloat(b), width: bounds.width, height: self.height*0.15, backgroundColor: "ffffff")
            let label = UIKitUtil.CreateUILable(nView, text: modes[b].Title!, x: 10, y: 0, width: bounds.width-10, height: itemHeight*0.4, textColor: "000000", textSize: 16, textAlign: .left)
            let line = UIKitUtil.CreateUiView(nView, x: 0, y: itemHeight*0.4, width: bounds.width, height: 1, backgroundColor: "dedede")
            let nwidth = bounds.width/3
            let nheight = itemHeight-(itemHeight*0.4)-1
            let nView2 = UIKitUtil.CreateUiView(nView, x: 0, y: itemHeight*0.4+1, width: bounds.width, height: nheight, backgroundColor: "ffffff")
            let items = modes[b].list!
            for k in 0..<items.count{
                let text = items[k].Name+"("+String(items[k].Count)+")"
                let button =  UIKitUtil.CreateUiButton(nView2, text: text, x: nwidth*CGFloat(k), y: 0, width: nwidth, height: nheight, textColor: "000000", textSize: 14, tag: items[k].Id!)
                button.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
            }
        }
    }
    @objc func Handle(_ sender:UIButton){
        let alarmListViewController = AlarmListViewController()
        alarmListViewController.title = "报警列表"
        alarmListViewController.type = sender.tag
        self.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(alarmListViewController, animated: true)
    }
}
