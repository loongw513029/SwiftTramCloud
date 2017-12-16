//
//  BusModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/13.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON
struct BusModel :HandyJSON {
    var DeviceId:Int?
    var DeviceCode:String?
    var BusId:Int?
    var BusNumber:String?
    var BusType:Int?
    var BusTypeName:String?
    var Status:Int?
    var LineId:Int?
    var LineName:String?
    var DrvierName:String?
    var Mileage:Double?
    var Electric:Double?
    var Oil:Double?
}
