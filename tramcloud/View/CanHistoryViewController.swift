//
//  CanHistoryViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/8.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
import Charts
class CanHistoryViewController: TramUIViewController {
    var totalMilage:UILabel!
    var totalCar:UILabel!
    var totalGasHao:UILabel!
    var totalPHao:UILabel!
    var totalElecHao:UILabel!
    var totalFault:UILabel!
    var totalBehavior:UILabel!
    var totalTime:UILabel!
    var scrollView:UIScrollView!
    var height:CGFloat = 0
    var dayType:Int = 2
    var canPresenter:CanPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.hexStringToColor(hexString: "dedede")
        CustomNavigationAnalysisBar("统计分析", false, true, false, "250路", 7,1)
        initView()
        if(canPresenter == nil){
            canPresenter = CanPresenter(self.view,self)
        }
        canPresenter.GetCanHistory(GetSelLineId(), userInfo.Id!, self.dayType)
    }
    
    func initView(){
        height = bounds.height - statusHeight
        let baseView = UIKitUtil.CreateUiView(self.view, x: 0, y: 0, width: bounds.width, height: height*0.3075, backgroundColor: "0b9bee")
        scrollView = UIScrollView()
        scrollView.frame = baseView.frame
        scrollView.contentSize = CGSize(width: view.bounds.width * 2,height: height*0.3075)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        baseView.addSubview(scrollView)
        let columnView = UIKitUtil.CreateUiView(self.view, x: 0, y: height*0.3075+8, width: bounds.width, height: height*0.2969, backgroundColor: "ffffff")
        let columnWidth = (bounds.width-3)/4
        let columnHeight = (height*0.2969-1)/2
        var imageArr = ["icon_total_mileage","icon_total_vehicle","icon_total_oil","icon_total_gas","icon_total_elec","icon_total_fault","icon_total_behavior","icon_total_line"]
        var strArr = ["总里程\n0.00KM","车辆总数\n2辆","总油耗\n0.0L","总气耗\n0.0L","总电耗\n0.0KW/H","故障次数\n0次","不安全行为\n0次","营运时长\n0.0H"]
        var objArr = [totalMilage,totalCar,totalGasHao,totalPHao,totalElecHao,totalFault,totalBehavior,totalTime]
        for i in 0...7{
            if(i == 0)
            {
                self.totalMilage = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
            }
            if(i == 1)
            {
                self.totalCar = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
            }
            if(i == 2)
            {
                self.totalGasHao = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
            }
            if(i == 3)
            {
                self.totalPHao = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
            }
            if(i == 4)
            {
                self.totalElecHao = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
            }
            if(i == 5)
            {
                self.totalFault = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
            }
            if(i == 6)
            {
                self.totalBehavior = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
            }
            if(i == 7)
            {
                self.totalTime = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
            }
        }
    }
    
    func createColumnView(_ parentView:UIView,_ image:String,_ str:String,_ w:CGFloat,_ h:CGFloat,_ index:Int)->UILabel{
        var x:CGFloat = 0
        var y:CGFloat = 0
        if(index%4 != 0)
        {
            if(index<4){
                x = CGFloat(index)*w + CGFloat(index)
            }else{
                x = CGFloat(index-4)*w + CGFloat(index-4)
                y = h+CGFloat(1)
            }
        }else if(index==4){
            y = h+CGFloat(1)
        }
        let cview = UIKitUtil.CreateUiView(parentView, x:x , y:y, width: w, height: h, backgroundColor: "ffffff")
        UIKitUtil.CreateUiView(parentView, x: x+1, y: y, width: 1, height: h, backgroundColor: "dedede")
        let imgeHeight = h-43
        let h2 = (w-imgeHeight)/2
        let imagebutton = UIKitUtil.CreateUIImageView(cview, image, x: h2, y: 5, width: imgeHeight, height: imgeHeight)
        var label = UIKitUtil.CreateUILable(cview, text: str, x: 0, y: 5+imgeHeight, width: w, height: 40, textColor: "000000", textSize: 12, textAlign: .center)
        label.numberOfLines = 0
        if(index==4){
            UIKitUtil.CreateUiView(parentView, x: 0, y: h, width: bounds.width, height: 1, backgroundColor: "dedede")
        }
        return label
    }
    
}

extension CanHistoryViewController{
    func createFaultChart(_ lineChart:LineChartView,_ dataPoints: [String], values: [Int],thema:String) {
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
        lineChart.legend.textColor = UIColor.white
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChart.xAxis.granularity = 1.0
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.axisLineColor = UIColor.white
        lineChart.xAxis.labelTextColor = UIColor.white
        //不显示右侧Y轴
        lineChart.rightAxis.drawAxisLineEnabled = true
        //不显示右侧Y轴数字
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.axisLineColor = UIColor.white
        lineChart.leftAxis.gridColor = UIColor.white
        lineChart.leftAxis.labelTextColor = UIColor.white
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false
        lineChartDataSet.setCircleColor(UIColor.white)
        lineChartDataSet.circleHoleColor = UIColor.white
        lineChartDataSet.colors = [UIColor.white]
        lineChartDataSet.valueColors = [UIColor.white]
        //显示
        lineChartDataSet.drawValuesEnabled = true
        //添加显示动画
        lineChart.animate(xAxisDuration: 1)
    }
    
    func createUnsafeChart(_ lineChart:LineChartView,_ dataPoints: [String], values: [[Int]],thema:String) {
        var dataEntries: [ChartDataEntry] = []
        var yVals1:[BarChartDataEntry] = []
        var yVals2:[BarChartDataEntry] = []
        var yVals3:[BarChartDataEntry] = []
        var yVals4:[BarChartDataEntry] = []
        var yVals5:[BarChartDataEntry] = []
        var count:Int = dataPoints.count
        for i in 0..<count{
            yVals1.append(BarChartDataEntry(x:Double(i),y:Double(values[0][i])))
            yVals2.append(BarChartDataEntry(x:Double(i),y:Double(values[1][i])))
            yVals3.append(BarChartDataEntry(x:Double(i),y:Double(values[2][i])))
            yVals4.append(BarChartDataEntry(x:Double(i),y:Double(values[3][i])))
            yVals5.append(BarChartDataEntry(x:Double(i),y:Double(values[4][i])))
        }
        let set1 = LineChartDataSet(values: yVals1, label: "未停稳开车门")
        set1.setColor(UIColor.hexStringToColor(hexString: "1296db"))
        let set2 = LineChartDataSet(values: yVals2, label: "急减速")
        set2.setColor(UIColor.hexStringToColor(hexString: "13227a"))
        let set3 = LineChartDataSet(values: yVals3, label: "超速")
        set3.setColor(UIColor.hexStringToColor(hexString: "1afa29"))
        let set4 = LineChartDataSet(values: yVals3, label: "起步急加速")
        set4.setColor(UIColor.black)
        let set5 = LineChartDataSet(values: yVals3, label: "急刹车")
        set5.setColor(UIColor.cyan)
        let lineChartData = LineChartData(dataSets: [set1,set2,set3,set4,set5])
        lineChart.data = lineChartData
        //右下角图标描述
        lineChart.chartDescription?.text = thema
        lineChart.chartDescription?.textColor = UIColor.white
        lineChart.chartDescription?.font = UIFont.boldSystemFont(ofSize: 14)
        lineChart.legend.textColor = UIColor.white
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
        lineChart.xAxis.granularity = 1.0
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.axisLineColor = UIColor.white
        lineChart.xAxis.labelTextColor = UIColor.white
        //不显示右侧Y轴
        lineChart.rightAxis.drawAxisLineEnabled = true
        //不显示右侧Y轴数字
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.axisLineColor = UIColor.white
        lineChart.leftAxis.gridColor = UIColor.white
        lineChart.leftAxis.labelTextColor = UIColor.white
        lineChart.scaleXEnabled = false
        lineChart.scaleYEnabled = false
        //添加显示动画
        lineChart.animate(xAxisDuration: 1)
    }
}
extension CanHistoryViewController:CanHistoryView,ChartViewDelegate{
    
    func GetCanHistoryResult(_ data: CanHistoryModel) {
        let lineChart1 = LineChartView.init(frame:CGRect(x:0,y:0,width:bounds.width,height:height*0.3075))
        lineChart1.delegate = self
        lineChart1.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
        scrollView.addSubview(lineChart1)
        createFaultChart(lineChart1,data.AxisValues, values: data.TrendModel.CarFault[0],thema: "故障统计")
        let lineChart2 = LineChartView.init(frame:CGRect(x:0,y:0,width:bounds.width,height:height*0.3075))
        lineChart2.delegate = self
        lineChart2.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
        scrollView.addSubview(lineChart2)
        createUnsafeChart(lineChart2,data.AxisValues, values: data.TrendModel.UnSafeAction,thema: "不安全行为统计")
        totalCar.text = "车辆总数\n"+String(data.ComprehensiveModel.OperationTotalNum)+"辆"
        totalTime.text = "营运时长\n"+String(data.ComprehensiveModel.CarWorkLongTime/3600)+"H"
        totalMilage.text = "总里程\n"+String(data.ComprehensiveModel.Mileage)+"KM"
        totalPHao.text = "总气耗\n"+String(data.ComprehensiveModel.GasAvg)+"L"
        totalElecHao.text = "总电耗\n"+String(data.ComprehensiveModel.ElectricAvg)+"KW/H"
        totalGasHao.text = "总油耗\n"+String(data.ComprehensiveModel.GasonlineAvg)+"L"
        totalFault.text = "故障次数\n"+String(data.ComprehensiveModel.FaultCarTotal)+"次"
        totalBehavior.text = "不安全行为\n"+String(data.ComprehensiveModel.UnSafeFaultTotal)+"次"
    }
    
    
}
