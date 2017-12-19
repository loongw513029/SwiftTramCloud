//
//  CanHistoryModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/18.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON

struct CanHistoryModel : HandyJSON{
    var AxisValues:[String] = [String]()
    var time:String = ""
    var ComprehensiveModel:ComprehensiveModel!
    var TrendModel:TrendModel!    
}

struct ComprehensiveModel : HandyJSON {
    var CarSafe:Int = 0
    var DriverAction:Int = 0
    var EnergyConsumption:Int = 0
    var JiWuManage:Int = 0
    var Operation:Int = 0
    var CarTotalNum:Int = 0
    var OperationTotalNum = 0
    var Mileage:Double = 0.00
    var CarWorkLongTime:Double = 0.00
    var GasonlineAvg:Int = 0
    var ElectricAvg:Int = 0
    var GasAvg:Int = 0
    var AlarmTotal:Int = 0
    var UnSafeFaultTotal:Int = 0
    var FaultCarTotal:Int = 0
    var SpeedingTotal:Int = 0
    var UnSafeDriverTotal:Int = 0
    var SeriousFaultNum:Int = 0
    var CommonlyFaultNum:Int = 0
}

struct TrendModel : HandyJSON {
    var CarFault:[[Int]] = [[Int]]()
    var UnSafeAction:[[Int]] = [[Int]]()
    var GasonlineIn100Mileage:[Int] = [Int]()
}

