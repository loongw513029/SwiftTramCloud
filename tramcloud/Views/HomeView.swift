//
//  HomeView.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/12.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
protocol HomeView {
    //获得首页图表数据
    func GetHomeData(_ data:HomeChartViewModel) ->()
    
    func GetAppHomeModel( _ data:[AppDropDownModel]) ->()
    
}
