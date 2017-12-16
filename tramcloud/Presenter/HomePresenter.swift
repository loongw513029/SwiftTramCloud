//
//  HomePresenter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/12.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
class HomePresenter : BasePresenter {
    
    var homeView : HomeView!
    var view : UIView!
    init(_ view:UIView,_ homeView:HomeView) {
        self.view = view
        self.homeView = homeView
    }
    
    func GetHomeChartData(_ userId:Int,_ lineId:Int){
        showProgress(self.view, "")
        Network.provider
        .rx
        .request(.GetHomeCharts(userId, lineId))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (resp) in
                do{
                    self.hideProgress()                    
                    let model = try resp.mapModel(BaseResult<HomeChartViewModel>.self)
                    self.homeView.GetHomeData(model.result!)
                }catch{
                    
                }
            }) { (error) in
                
        }
    }
    
    func GetDefaultDeviceCodesAndOnlySelectOnlineDevice(){
        Network.provider
            .rx
            .request(.GetDeviceByLine(0))
            .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (resp) in
                do{
                    self.hideProgress()
                    let model = try resp.mapModel(BaseResult<[AppDropDownModel]>.self)
                    self.homeView.GetAppHomeModel(model.result!)
                }catch{
                    
                }
            }) { (error) in
                
        }
    }
}
