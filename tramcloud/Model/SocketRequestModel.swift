//
//  SocketRequestModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/19.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import  HandyJSON
struct BaseRequest<T> :HandyJSON {
    var type:Int = 0
    var source:String = ""
    var target:String = ""
    var msgInfo:T?
}
struct RequestChannelModel :HandyJSON {
    var State:Bool = false
    var Channel:Int = 0
    var SubChannel:Int = 1
    var type:String = ""
    var IpString:String = ""
}

struct SocketResponseModel :HandyJSON {
    var AlarmTime:String = ""
    var AlarmType:Int = 0
    var Timestamp:String = ""
    var type:String = ""
    var Buffer:String = "'"
}
