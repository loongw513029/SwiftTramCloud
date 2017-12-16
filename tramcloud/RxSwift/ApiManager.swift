//
//  ApiManager.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/4.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import Moya

enum ApiManager {
    case Login(String,String,Int,String)
    case GetHomeData(Int,Int)
    case LoginOut(String)
    case GetCanInfo(String)
    case GetMapInfoV2(String,String)
    case GetHomeCharts(Int,Int)
    case GetDeviceByLine(Int)
    case GetChannelsByDevice(Int)
    case GetDeviceListByLine(Int,Int)
    case GetAlarms(Int,Int,Int,Int,String,Int,Int)
    case GetAlarmDetailInfo(Int)
    case GetDeviceInspectList(Int,Int,String,Int,Int)
    case GetUnSafeList(Int,Int,Int,Int,Int,Int)
    case GetDeviceRepairList(Int,Int,Int)
    case GetBusViewModel(Int,Int)
    case GetBicycleUnSafeInfo(Int,Int)
    case GetBicycleAlarmInfo(Int,Int)
    case GetCanHistorys(Int,Int,Int)
    case GetMapHistorys(Int,String)
    case UploadBase64Img(Int,String)
    case GetAlarmCharts(Int,Int,Int)
    case GetVideoConfig(Int)
    case SendSocket(Int,Int,Int)
    case GetDeviceCanOrGpsState(String)
    case ModifyPwd(Int,String,String)
    case GetAppDeviceSearch(String)
    case PostAlarm(String)
    case GetMaintenaceList(Int,Int,Int)
    case AddMaintenance(Int,Int,String,String,Double,String,String,Double,String,String)
}
extension ApiManager:TargetType{
    
    var baseURL: URL {
        return URL.init(string: AppDelegate().BaseUrl)!
    }
    var path: String {
        switch self {
        case .Login(_,_,_,_):
            return "/api/v1/account/login"
        case .GetHomeData(_,_):
            return "/api/v1/home/lines"
        case .LoginOut(_):
            return "/api/v1/account/loginout"
        case .GetCanInfo(_):
            return "/api/v1/can/realtimedata"
        case .GetMapInfoV2(_,_):
            return "/api/v2/map/maps"
        case .GetHomeCharts(_, _):
            return "/api/v1/home/getcharts"
        case .GetDeviceByLine(_):
            return "/api/v1/home/getdevicesbyline"
        case .GetChannelsByDevice(_):
            return "/api/v1/home/getchannelbydevice"
        case .GetDeviceListByLine(_, _):
            return "/api/v1/home/devices"
        case .GetAlarms(_, _, _, _,_, _, _):
            return "/api/v1/alarm/list2"
        case .GetAlarmDetailInfo(_):
            return "/api/v1/alarm/detail"
        case .GetDeviceInspectList(_, _, _, _, _):
            return "/api/v1/device/inspectlist"
        case .GetUnSafeList(_, _, _, _, _, _):
            return "/api/v1/device/unsafelist"
        case .GetDeviceRepairList(_, _, _):
            return "/api/v1/device/repairlist"
        case .GetBusViewModel(_, _):
            return "/api/v1/device/getbusinfo"
        case .GetBicycleUnSafeInfo(_, _):
            return "/api/v1/driver/getbicycleunsafeinfo"
        case .GetBicycleAlarmInfo(_, _):
            return "/api/v1/driver/getbicyclealarminfo"
        case .GetCanHistorys(_, _, _):
            return "/api/v1/can/getlinestatistics"
        case .GetMapHistorys(_, _):
            return "/api/v1/map/getmaphistory"
        case .UploadBase64Img(_,_):
            return "/api/v1/upload/uploadBaseImage"
        case .GetAlarmCharts(_, _, _):
            return "/api/v1/alarm/getalarmcharts"
        case .GetVideoConfig(_):
            return "/api/v1/home/getdeviceconfig"
        case .SendSocket(_, _, _):
            return "/api/v1/home/sendSocket"
        case .GetDeviceCanOrGpsState(_):
            return "/api/v1/home/getcanorgpsstate"
        case .ModifyPwd(_,_,_):
            return "/api/v1/account/modifypwd"
        case .GetAppDeviceSearch(_):
            return "/api/v1/home/devicesearch"
        case .PostAlarm(_):
            return "/api/v1/server/accept"
        case .GetMaintenaceList(_, _, _):
            return "/api/v1/maintenance/list"
        case .AddMaintenance(_,_,_,_,_,_,_,_,_,_):
            return "/api/v1/maintenance/add"
        }
    }
    var method: Moya.Method {
        switch self {
        case .Login(_,_,_,_):
            return .post
        case .UploadBase64Img(_,_):
            return .post
        case .ModifyPwd(_,_,_):
            return .post
        case .PostAlarm(_):
            return .post
        case .AddMaintenance:
            return .post
        default:
            return .get
        }
    }
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .Login(let username, let password, let logintype, let clientid):
            var params:[String:Any] = [:]
            params["username"] = username
            params["password"] = password
            params["logintype"] = logintype
            params["clientid"] = clientid
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .UploadBase64Img(let userId,let base64Str):
            var params:[String:Any] = [:]
            params["UserId"] = userId
            params["Base64Str"] = base64Str
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .ModifyPwd(let userId,let oldpwd,let newpwd):
            var params:[String:Any] = [:]
            params["userid"] = userId
            params["oldpwd"] = oldpwd
            params["newpwd"] = newpwd
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .PostAlarm(let requestStr):
            var params:[String:Any] = [:]
            params["postRequestParam"] = requestStr
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .AddMaintenance(let Id,let deviceId,let deviceCode,let MtDate,let MtMileage,let Project,let NextData,let NextMilage,let Description,let createTime):
            var params:[String:Any] = [:]
            params["Id"] = Id
            params["DeviceId"] = deviceId
            params["DeviceCode"] = deviceCode
            params["MtDate"] = MtDate
            params["MtMileage"] = MtMileage
            params["Project"] = Project
            params["NextDate"] = NextData
            params["NextMileage"] = NextMilage
            params["Description"] = Description
            params["CreateTime"] = createTime
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .GetAlarmCharts(let userId, let lineId, let type):
            var params:[String:Any] = [:]
            params["userId"] = userId
            params["lineId"] = lineId
            params["type"] = type
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetAlarmDetailInfo(let id):
            var params:[String:Any] = [:]
            params["id"] = id
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetAlarms(let userId,let dayType, let lineId, let type, let code,let page, let limit):
            var params:[String:Any] = [:]
            params["userId"] = userId
            params["dayType"] = dayType
            params["lineId"] = lineId
            params["type"] = type
            params["code"] = code
            params["page"] = page
            params["limit"] = limit
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetAppDeviceSearch(let keywords):
            var params:[String:Any] = [:]
            params["code"] = keywords
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetBicycleAlarmInfo(let daytype,let deviceid):
            var params:[String:Any] = [:]
            params["dattype"] = daytype
            params["deviceId"] = deviceid
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetBicycleUnSafeInfo(let daytype,let deviceid):
            var params:[String:Any] = [:]
            params["dattype"] = daytype
            params["deviceId"] = deviceid
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetBusViewModel(let dayType, let deviceId):
            var params:[String:Any] = [:]
            params["dayType"] = dayType
            params["deviceId"] = deviceId
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetCanHistorys(let lineId, let userId, let dayType):
            var params:[String:Any] = [:]
            params["lineId"] = lineId
            params["userId"] = userId
            params["dayType"] = dayType
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetCanInfo(let code):
            var params:[String:Any] = [:]
            params["code"] = code
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetChannelsByDevice(let deviceid):
            var params:[String:Any] = [:]
            params["deviceId"] = deviceid
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetDeviceByLine(let lineId):
            var params:[String:Any] = [:]
            params["lineId"] = lineId
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetDeviceCanOrGpsState(let devicecode):
            var params:[String:Any] = [:]
            params["devicecode"] = devicecode
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetDeviceInspectList(let lineId, let departmentId, let code, let page, let limit):
            var params:[String:Any] = [:]
            params["lineId"] = lineId
            params["departmentId"] = departmentId
            params["code"] = code
            params["page"] = page
            params["limit"] = limit
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetDeviceListByLine(let userId, let lineId):
            var params:[String:Any] = [:]
            params["lineId"] = lineId
            params["userId"] = userId
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetDeviceRepairList(let userId, let page, let limit):
            var params:[String:Any] = [:]
            params["userId"] = userId
            params["page"] = page
            params["limit"] = limit
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetHomeCharts(let userId, let lineId):
            var params:[String:Any] = [:]
            params["lineId"] = lineId
            params["userId"] = userId
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetHomeData(let userId, let departmentId):
            var params:[String:Any] = [:]
            params["userId"] = userId
            params["departmentId"] = departmentId
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetMaintenaceList(let userId, let page, let limit):
            var params:[String:Any] = [:]
            params["userId"] = userId
            params["page"] = page
            params["limit"] = limit
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetMapHistorys(let timetype, let code):
            var params:[String:Any] = [:]
            params["timetype"] = timetype
            params["code"] = code
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetMapInfoV2(let code,let time):
            var params:[String:Any] = [:]
            params["codes"] = code
            params["time"] = time
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetUnSafeList(let userId, let daytype, let unsafetype, let lineId, let page, let limit):
            var params:[String:Any] = [:]
            params["userId"] = userId
            params["daytype"] = daytype
            params["unsafetype"] = unsafetype
            params["lineId"] = lineId
            params["page"] = page
            params["limit"] = limit
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .GetVideoConfig(let deviceId):
            var params:[String:Any] = [:]
            params["deviceId"] = deviceId
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        case .LoginOut(let username):
            var params:[String:Any] = [:]
            params["username"] = username
            return .requestParameters(parameters:params,encoding:URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
