//
//  MapView.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/15.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
protocol MapView {
    func GetMapResults(_ data:MapModel) ->()
    func GetMapState(_ onlineState:DataStateModel) ->()
}
