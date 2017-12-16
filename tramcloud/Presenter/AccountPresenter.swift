//
//  AccountPresenter.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/12.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation

public class AccountPresenter : BasePresenter {
    var loginView:LoginView
    var view:UIView!
    init(_ loginView:LoginView,_ view:UIView) {
        self.loginView = loginView
        self.view = view
    }
    
    func Login(_ username:String,_ password:String,_ clientid:String){
        showProgress(self.view, "登录中")
        Network.provider.rx
        .request(.Login(username, password, 2, ""))
        .filterSuccessfulStatusCodes()
            .subscribe(onSuccess: { (response) in
                do {
                    self.hideProgress()
                    let model = try response.mapModel(BaseResult<UserInfo>.self)
                    self.loginView.GetLoginResult(model)
                }catch{
                    //Toast.show(with: "格式解析失败")
                    
                }
            }) { (error) in
                self.hideProgress()
        }
    }
    
}
