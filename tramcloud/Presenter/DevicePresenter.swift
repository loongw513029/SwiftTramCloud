//
//  DevicePresenter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/13.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
class DevicePresenter: BasePresenter {
    
    var view:UIView!
    var deviceView:DeviceView!
    var busDetailView:BusDetailView!
    init(_ view:UIView,_ deviceView:DeviceView) {
        self.view = view
        self.deviceView = deviceView
    }
    init(_ view:UIView,_ busDetailView:BusDetailView) {
        self.view = view
        self.busDetailView = busDetailView
    }
    
    func GetDeviceList(_ userId:Int,_ lineId:Int){
        showProgress(self.view, "")
        Network.provider.rx
        .request(.GetDeviceListByLine(userId, lineId))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                do{
                    self.hideProgress()
                    let model = try response.mapModel(BaseResult<[DeviceListModel]>.self)
                    self.deviceView.GetDeviceList(model.result!)
                }
                catch{ }
            }) { (error) in
                self.hideProgress()
        }
    }
    
    func GetBusDetail(_ dayType:Int,_ deviceId:Int){
        showProgress(self.view, "")
        Network.provider.rx
        .request(.GetBusViewModel(dayType, deviceId))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                
                do{
                    self.hideProgress()
                    let model = try response.mapModel(BaseResult<BusModel>.self)
                    self.busDetailView.GetBusDetail(model.result!)
                }catch{
                    
                }
            }) { (error) in
                self.hideProgress()
        }
    }
}
