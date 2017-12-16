//
//  DateUtil.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/15.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation

class DateUtil{
    static func GetNowDateString() ->String{
        let now = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateformatter.string(from: now)
    }
}
