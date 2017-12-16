//
//  MapModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/15.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON
struct MapModel : HandyJSON{
    var Maps:[MapModelInfo]?
    var UnSafeBehavior:[UnSafeViewModel]?
}

struct MapModelInfo :HandyJSON {
    var GpsOnLine:Bool = false
    var IsOnline:Bool = false
    var Location:String?
    var deviceId:Int = 0
    var Id:Int = 0
    var Code:String = ""
    var Speed:String?
    var ClientIp:String?
    var Channel:Int?
    var Rotate:Double?
    var UpdateTime:Date?
    var deviceNumber:String?
    var iconclass:String?
    var state:Int = 0
    var dispatch:String?
    var Address:String = ""
    var UpTime:String = ""
}
struct UnSafeViewModel :HandyJSON {
    
    var UnSafeTypeName:String?
    var Time:String?
    var Location:String?
    var Code:String?
}
