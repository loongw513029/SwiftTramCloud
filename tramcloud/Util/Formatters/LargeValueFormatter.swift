//
//  LargeValueFormatter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import Charts
public class LargeValueFormatter:NSObject,IValueFormatter,IAxisValueFormatter{
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return format(value: value)
    }
    
    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return format(value: value)
    }
    
    
    public var suffix = ["","k","m","b","t"]
    public var appendix:String?
    init(appendix: String? = nil) {
        self.appendix = appendix
    }
    
    fileprivate func format(value:Double) ->String{
        var sig = value
        var length = 0
        let maxLength = suffix.count - 1
        while sig >= 1000.0 && length < maxLength {
            sig /= 1000.0
            length += 1
        }
        var r = String(format: "%2.f",sig) + suffix[length]
        
        if let appendix = appendix{
            r += appendix
        }
        return r
    }
}
