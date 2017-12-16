//
//  CanView.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/14.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
protocol CanView {
    func GetCanResult(_ data:CanModel) ->()
    func GetCanState(_ onlieState:DataStateModel) ->()
}
