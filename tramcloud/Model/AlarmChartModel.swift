//
//  AlarmChartModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON

struct AlarmChartModel : HandyJSON {
    var xVals:[String]?
    var yVals:[yVal]?
    var modes:[TypeModel]?
}

struct xVAl : HandyJSON{
    var Id:Int?
    var Name:String?
}
struct yVal : HandyJSON {
    var Val:[Int]?
    var Time:String?
    var Id:Int?
}
struct TypeModel :HandyJSON {
    var Title:String?
    var list:[TypeModel4]?
}
struct TypeModel4 :HandyJSON {
    var Id:Int?
    var Name:String = ""
    var Count:Int = 0
}



struct PageDataModel<T> :HandyJSON {
    var TotalNum:Int?
    var Items:[T]?
    var CurrentPage:Int?
    var TotalPageCount:Int?
}

struct AlarmDetailModel :HandyJSON {
    var Id:Int?
    var DeviceId:Int?
    var DeviceCode:String?
    var BusNumber:String?
    var LineName:String?
    var DepartmentName:String?
    var AlarmKey:Int?
    var AlramName:String?
    var Level:Int?
    var UpdateTime:String?
    var AlarmValue:String = ""
    var Location:String?
    var Address:String?
    var isBreal:Int?
    var Path:String?
    var Extras:String?
    var can:CurrentCanModel?
}

struct CurrentCanModel {
    var speed:String = "0"
    var isBreak:Bool = false
    var distance:Double = 0.0
}
