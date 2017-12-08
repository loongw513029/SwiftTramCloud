//
//  CanHistoryViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/8.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
class CanHistoryViewController: TramUIViewController {
    var totalMilage:UILabel!
    var totalCar:UILabel!
    var totalGasHao:UILabel!
    var totalPHao:UILabel!
    var totalElecHao:UILabel!
    var totalFault:UILabel!
    var totalBehavior:UILabel!
    var totalTime:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.hexStringToColor(hexString: "dedede")
        CustomNavigationAnalysisBar("统计分析", false, true, false, "250路", 7)
        initView()
    }
    
    func initView(){
        let height = bounds.height - statusHeight
        let baseView = UIKitUtil.CreateUiView(self.view, x: 0, y: 0, width: bounds.width, height: height*0.3075, backgroundColor: "0b9bee")
        
        let columnView = UIKitUtil.CreateUiView(baseView, x: 0, y: height*0.3075+8, width: bounds.width, height: height*0.2969, backgroundColor: "ffffff")
        let columnWidth = (bounds.width-3)/4
        let columnHeight = (height*0.2969-1)/2
        var imageArr = ["icon_total_mileage","icon_total_vehicle","icon_total_oil","icon_total_gas","icon_total_elec","icon_total_fault","icon_total_behavior","icon_total_line"]
        var strArr = ["总里程\n0.00KM","车辆总数\n2辆","总油耗\n0.0L","总气耗\n0.0L","总电耗\n0.0KW/H","故障次数\n0次","不安全行为\n0次","营运时长\n0.0H"]
        var objArr = [totalMilage,totalCar,totalGasHao,totalPHao,totalElecHao,totalFault,totalBehavior,totalTime]
        for i in 0...7{
            objArr[i] = createColumnView(columnView, imageArr[i], strArr[i], columnWidth, columnHeight, i)
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
