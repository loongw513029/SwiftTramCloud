//
//  DeviceFilterPresenter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/12.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
class DeviceFilterPresenter: BasePresenter {
    var view:UIView!
    var deviceFilterView:DeviceFilterView!
    init(_ view:UIView,_ dfview:DeviceFilterView) {
        self.view = view
        self.deviceFilterView = dfview
    }
    
    func GetLines(_ userId:Int,_ departmentId:Int){
        showProgress(self.view, "")
        Network.provider.rx
        .request(.GetHomeData(userId, departmentId))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                do{
                    self.hideProgress()
                    let model = try response.mapModel(BaseResult<LineModel>.self)
                    self.deviceFilterView.getLines(model.result!.Lines)
                }
                catch{}
            }) { (error) in
                self.hideProgress()
        }
    }
    
    func GetDevicesByLines(_ lineId:Int){
        showProgress(self.view, "")
        Network.provider.rx
        .request(.GetDeviceByLine(lineId))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                do{
                    self.hideProgress()
                    let model = try response.mapModel(BaseResult<[AppDropDownModel]>.self)
                    self.deviceFilterView.getDevices(model.result!)
                }catch{}
            }) { (error) in
                 
                self.hideProgress()
        }
    }
}
