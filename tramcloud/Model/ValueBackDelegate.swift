//
//  ValueBackDelegate.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/14.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
@objc protocol ValueBackDelegate {
    func ValueBack(type:Int,value:AnyObject) ->Void
}
