//
//  AlarmPresenter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation

class AlarmPresenter: BasePresenter {
    
    var view:UIView!
    var alarmChartView:AlarmChartView!
    var alarmListView:AlarmListView!
    var alarmDetailView:AlarmDetailView!
    
    init(_ view:UIView,_ alarmChartView:AlarmChartView) {
        self.view = view
        self.alarmChartView = alarmChartView
    }
    
    init(_ view:UIView,_ alarmListView:AlarmListView) {
        self.view = view
        self.alarmListView = alarmListView
    }
    
    init(_ view:UIView,_ alarmDetailView:AlarmDetailView) {
        self.view = view
        self.alarmDetailView = alarmDetailView
    }
    
    func GetAlarmCharts(_ userId:Int,_ lineId:Int, _ type:Int){
        showProgress(self.view, "")
        Network.provider.rx
        .request(.GetAlarmCharts(userId, lineId, type))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                self.hideProgress()
                do{
                    let model = try response.mapModel(BaseResult<AlarmChartModel>.self)
                    if(model.success)!{
                        self.alarmChartView.GetAlarmCharts(model.result!)
                    }
                }catch{}
            }) { (error) in
                self.hideProgress()
        }
    }
    
    func GetAlarmList(_ userId:Int,_ dayType:Int,_ lineId:Int,_ type:Int,_ code:String,_ page:Int,_ limit:Int){
       showProgress(self.view, "")
        Network.provider.rx
        .request(.GetAlarms(userId, dayType, lineId, type, code, page, limit))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                self.hideProgress()
                do{
                    let model = try response.mapModel(BaseResult<PageDataModel<AlarmDetailModel>>.self)
                    if(model.success)!{
                        self.alarmListView.GetAlarmList(model.result!)
                    }
                }catch{}
            }) { (error) in
                self.hideProgress()
        }
    }
}
