//
//  DeviceFilterView.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/12.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
protocol DeviceFilterView {
    func getLines(_ data:[LineDetailModel]) ->()
    func getDevices(_ data:[AppDropDownModel]) ->()
}
