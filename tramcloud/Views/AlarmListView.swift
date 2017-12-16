//
//  AlarmListView.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
protocol AlarmListView {
    func GetAlarmList(_ data:PageDataModel<AlarmDetailModel>) ->()
}
