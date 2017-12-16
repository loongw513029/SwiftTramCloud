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
    var AxisValue:UInt?
}

struct AppHomeModel {
    var Lines:[AppSelectModel]?
}
struct AppSelectModel {
    var Id:Int?
    var Name:String?
    var IsOnline:Bool?
    var NumData:AppDropDownModel?
}
struct AppDropDownModel :HandyJSON {
    var Id:Int?
    var Name:String?
    var IsOnline:Bool?
}

struct LineModel : HandyJSON{
    var Lines:[LineDetailModel]!
}
struct LineDetailModel : HandyJSON {
    var Id:Int!
    var Name:String!
    var IsOnline:Bool!
    var NumData:NumDataModel!
}
struct NumDataModel : HandyJSON {
    var CarNum:Int!
    var OnLineNum:Int!
    var LineNum:Int!
    var UnSafeNum:Int!
}

