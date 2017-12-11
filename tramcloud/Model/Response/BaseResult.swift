//
//  BaseResult.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/11.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON
struct BaseResult<T> :HandyJSON{
    var success:Bool?
    var info:String?
    var code:Int?
    var result:T?
}
