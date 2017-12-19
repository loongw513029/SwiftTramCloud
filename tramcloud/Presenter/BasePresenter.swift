//
//  BasePresenter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/12.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
public class BasePresenter {
    var hud : MBProgressHUD!
    func showProgress(_ view:UIView,_ content:String){
        var cont = content
        if(content == ""){
            cont = "数据请求中"
        }
        hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = cont
        hud.dimBackground = true
        //hud.hide(animated: true, afterDelay: 0.8)
    }
    func RequestFail(){
        Toast.fail(with: "数据请求失败!")
    }
    func hideProgress(){
        if(hud != nil)
        {
            hud.hide(animated: true)
        }
    }
}
