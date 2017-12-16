//
//  DeviceFilterResult.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/14.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
class DeviceFilterResult {
    var totalTime:Int? = 0
    var intervalTime:Int? = 0
    var lineId:Int? = 0
    var lineName:String?
    var deviceId:Int? = 0
    var deviceName:String?
    
    init() {
        
    }
    init(totalTime:Int,intervalTime:Int,lineId:Int,lineName:String,deviceId:Int,deviceName:String) {
        self.totalTime = totalTime
        self.intervalTime = intervalTime
        self.lineId = lineId
        self.lineName = lineName
        self.deviceId = deviceId
        self.deviceName = deviceName
    }
}
