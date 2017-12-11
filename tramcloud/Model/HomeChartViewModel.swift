//
//  HomeChartViewModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/11.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON
struct HomeChartViewModel : HandyJSON{
    var TotalDeviceCount:Int?
    var OnLineDeviceCount:Int?
    var TotalLineCount:Int?
    var TotalUnsafeCount:Int?
    var TotalAlarmCount:Int?
    var ChartList:[ChartListViewModel]?
}
struct ChartListViewModel : HandyJSON{
    var ChartName:String?
    var Data:[ChartData]?
}
struct ChartData : HandyJSON{
    var AxisName:String?
    var AxisValue:Double?
}

