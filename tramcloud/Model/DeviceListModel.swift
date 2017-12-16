//
//  DeviceListModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/13.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON
struct DeviceListModel : HandyJSON{
    var Id:Int?
    var DeviceCode:String?
    var DeviceName:String?
    var IsOnline:Bool?
    var DriverName:String?
}
