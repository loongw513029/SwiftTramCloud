//
//  CanModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/14.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON

struct CanModel : HandyJSON {
    var time:String?
    var caninfo:CanInfoModel?
    var canstatinfo:CanStatModel?
    var canalarminfo:CanAlarmModel?
    var RadarInfo:[Int]?
    var DispatchInfo:DispatchModel?
}

struct CanInfoModel : HandyJSON{
    var speed:String?
    var ratespeed:String?
    var leftpress:String?
    var rightpress:String?
    var oilmass:String?
    var oilopenings:String?
    var totalbattertvoltage:String?
    var totalbatterygenerator:String?
    var beforepressure:String?
    var afterpressure:String?
    var oilpressure:String?
    var soc:String?
    var watertemp:String?
    var shortmileage:String?
    var totalmileage:String?
    var oilconsumption:String?
    var remainingoil:String?
    var controllerstat:String?
    var enginestat:String?
    var electricalstat:String?
    var electricalratespeed:String?
    var location:String?
    var roate:Double?
    var outcartemp:String?
    var incartemp:String?
}
struct CanStatModel : HandyJSON {
    //左转向灯
    var leftturn:Int = 0
    //右转向灯
    var rightturn:Int = 0
    //Acc开关
    var accturn:Int = 0
    //前雾灯
    var beforefoglampsturn:Int = 0
    //后雾灯
    var afterfoglampsturn:Int = 0
    //近光灯
    var dippedlightsturn:Int = 0
    //远光灯
    var highbeamturn:Int = 0
    //Abs故障灯
    var absturn:Int = 0
    //驻车制动器开关
    var parkingbraketurn:Int = 0
    //脚刹
    var footbraketurn:Int = 0
    //发动机预热
    var enginepreheatingturn:Int = 0
    var engineworkturn:Int = 0
    //安全带
    var safetybelt:Int = 0
    //前门
    var headerdoorturn:Int = 0
    //中门
    var middledoorturn:Int = 0
    //后门
    var lastdoorturn:Int = 0
    //位置灯
    var positionlampturn:Int = 0
    //AC空调信号灯
    var acturn:Int = 0
    
}

struct CanAlarmModel : HandyJSON{
    
}

struct DispatchModel : HandyJSON{
    var CurrentSite:String?
    var NextSite:String?
    //进站 0 出站 1
    var InOrOutSite:Int?
    var InOrOutSiteType:Int?
    //起始站0 终点站1 中途站2
    var SiteType:Int?
}
