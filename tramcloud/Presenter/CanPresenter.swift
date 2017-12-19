//
//  CanPresenter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/14.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
class CanPresenter: BasePresenter {
    var view:UIView!
    var canView:CanView!
    var canHistoryView:CanHistoryView!
    init(_ view:UIView,_ canView:CanView) {
        self.view = view
        self.canView = canView
    }
    init(_ view:UIView,_ canHistoryView:CanHistoryView) {
        self.view = view
        self.canHistoryView = canHistoryView
    }
    
    func GetCanData(_ code:String){
        Network.provider.rx
        .request(.GetCanInfo(code))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                do{
                    let model = response.mapModel(BaseResult<CanModel>.self)
                    if(model.success)!{
                        self.canView.GetCanResult(model.result!)
                    }else{
                        print(model.info)
                    }
                }catch{}
            }) { (error) in
                
        }
    }
    func GetDataState(_ devicecode:String){
        showProgress(self.view, "")
        Network.provider.rx
        .request(.GetDeviceCanOrGpsState(devicecode))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                do{
                    self.hideProgress()
                    let model = response.mapModel(BaseResult<DataStateModel>.self)
                    self.canView.GetCanState(model.result!)
                }catch{}
                self.hideProgress()
            }) { (error) in
                self.hideProgress()
        }
    }
    
    func GetCanHistory(_ lineId:Int,_ userId:Int,_ dayType:Int){
        showProgress(self.view, "")
        Network.provider.rx
        .request(.GetCanHistorys(lineId, userId, dayType))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                self.hideProgress()
                do{
                    let model = try response.mapModel(BaseResult<CanHistoryModel>.self)
                    if(model.success)!{
                        self.canHistoryView.GetCanHistoryResult(model.result!)
                    }
                    else{
                        self.RequestFail()
                    }
                }catch{}
            }) { (error) in
                self.hideProgress()
        }
    }
}
