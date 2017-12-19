//
//  InspectDetailAdapterModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/18.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation

struct InspectDetailAdapterModel {
    
    var Key:String = ""
    var Value:String = ""
    
    func ConvertToDetailArray(model:DeviceInspectModel) -> [InspectDetailAdapterModel]{
        var array = [InspectDetailAdapterModel]()
        let hMirror = Mirror(reflecting: model)
        for case let (label?, value) in hMirror.children {
            if(!label.contains("Id") && !label.contains("Time")){
                var v2:String = ""
                if value is Int{
                    v2 = String(value as! Int)
                } else if value is Double{
                    v2 = String(value as! Double)
                }else if value is Bool{
                    v2 = String(value as! Bool)
                }else{
                    v2 = value as! String
                }
                array.append(getKeyName(key: label, value: v2))
            }
        }
        return array
    }
    func getKeyName(key:String,value:String) ->InspectDetailAdapterModel{
        var r = key
        var s = value
        switch key {
        case "DeviceCode":
            r = "设备编码"
        case "LineName":
            r = "线路名称"
        case "OrganizationName":
            r = "机构名称"
        case "State":
            r = "设备状态"
            if(value as! String == "1")
            {
                s = "正常"
            }else{
                s = "异常"
            }
        case "Videotape":
            r = "录像状态"
            s = GetNameByValue(value: Bool(value)!)
        case "Video":
            r = "视频状态"
            s = GetNameByValue(value: Bool(value)!)
        case "HardDisk":
            r = "硬盘状态"
            s = GetNameByValue(value: Bool(value)!)
        case "SDCard":
            r = "SD卡状态"
            s = GetNameByValue(value: Bool(value)!)
        case "CPUUseRate":
            r = "CPU使用率"
        case "CPUTemp":
            r = "CPU温度"
        case "MermoryUseRate":
            r = "内存使用率"
        case "DiskTemp":
            r = "硬盘温度"
        case "GpsState":
            r = "GPS状态"
            s = GetNameByValue(value: Bool(value)!)
        case "CanState":
            r = "CAN状态"
            s = GetNameByValue(value: Bool(value)!)
        case "SIMBalance":
            r = "SIM卡余额"
        case "InternerState":
            r = "网络状态"
            s = GetNameByValue(value: Bool(value)!)
        case "GpsSignelState":
            r = "GPS信号"
            s = GetNameByValue(value: Bool(value)!)
        case "GpsInspectState":
            r = "Gps巡检状态"
            s = GetNameByValue(value: Bool(value)!)
        case "CanInspectState":
            r = "Can巡检状态"
            s = GetNameByValue(value: Bool(value)!)
        case "BehaviorInspectState":
            r = "行为识别状态"
            s = GetNameByValue(value: Bool(value)!)
        case "RadarInspectState":
            r = "雷达状态"
            s = GetNameByValue(value: Bool(value)!)
        case "AdasInspectState":
            r = "ADAS状态"
            s = GetNameByValue(value: Bool(value)!)
        case "TimingState":
            r = "校时状态"
            s = GetNameByValue(value: Bool(value)!)
        default:
            r = ""
            s = ""
        }
        return InspectDetailAdapterModel(Key:r,Value:s)
    }
    func GetNameByValue(value:Bool) -> String
    {
        if(value){
            return "正常"
        }
        else{
            return "异常"
        }
    }
}
