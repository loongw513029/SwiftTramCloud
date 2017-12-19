//
//  DeviceInspectModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/18.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON
struct DeviceInspectModel : HandyJSON {
    var DeviceCode:String = ""
    var DeviceId:Int = 0
    var LineId:Int = 0
    var LineName:String = ""
    var OrganizationId:Int = 0
    var OrganizationName:String = ""
    var State:Int = 0
    var UpdateTime:String = ""
    var Videotape:Bool = false
    var Video:Bool = false
    var HardDisk:Bool = false
    var SDCard:Bool = false
    var CPUUseRate:String = ""
    var CPUTemp:String = ""
    var MermoryUseRate:String = ""
    var DiskTemp:String = ""
    var GpsState:Bool = false
    var SIMBalance:Double = 0.0
    var CanState:Bool = false
    var InternerState:Bool = false
    var GpsSignelState:Bool = false
    var GpsInspectState:Bool = false
    var CanInspectState:Bool = false
    var BehaviorInspectState:Bool = false
    var RadarInspectState:Bool = false
    var AdasInspectState:Bool = false
    var TimingState:Bool = false
}


