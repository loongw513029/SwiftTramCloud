//
//  IntAxisValueFormatter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import Charts

public class IntAxisValueFormatter:NSObject,IAxisValueFormatter{
    var ns = [String]()
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(self.ns[Int(value)]))日"
    }
    
    init(_ nss:[String]) {
        self.ns = nss
    }
    
}
