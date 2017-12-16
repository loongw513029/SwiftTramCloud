//
//  MapPresenter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/15.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
class MapPresenter: BasePresenter {
    
    var view:UIView!
    var mapView:MapView!
    
    init(_ view:UIView,_ mapView:MapView) {
        self.mapView = mapView
        self.view = view
    }
    
    func GetMapResults(_ codes:String,_ time:String){
        Network.provider.rx
        .request(.GetMapInfoV2(codes, time))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                do{
                    let model = try response.mapModel(BaseResult<MapModel>.self)
                    if(model.success)!{
                        self.mapView.GetMapResults(model.result!)
                    }
                }
                catch{}
            }) { (error) in                
                print(error.localizedDescription)
                
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
                    self.mapView.GetMapState(model.result!)
                }catch{}
                self.hideProgress()
            }) { (error) in
                self.hideProgress()
        }
    }
}
