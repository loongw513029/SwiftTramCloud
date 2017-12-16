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
    
    init(_ view:UIView,_ canView:CanView) {
        self.view = view
        self.canView = canView
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
}
