//
//  LoginViewModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/11.
//  Copyright © 2017年  tvis. All rights reserved.
//


import RxSwift
import RxCocoa
import NSObject_Rx
class AccountViewModel: HasDisposeBag {
    
    let DataCommand = PublishSubject<Void>()
    let loginResult = Variable(BaseResult<UserInfo>())
    var LoginResult = ""
    var IsLoginSuccess:Bool = false
    var modifySuccess:Bool = false
    
   
}

extension AccountViewModel{
    
    func Login(_ username:String,_ password:String,_ clientid:String){
        DataCommand
        .flatMap{ [unowned self] in Network.Login(username, password, clientid)}
        .subscribe(onNext: { [unowned self] (model) in
           self.loginResult.value = model
         })
        .disposed(by: disposeBag)
    }
    
    func LoginOut(_ username:String){
        DataCommand
            .flatMap { [unowned self] in Network.LoginOut(username) }
            .subscribe(onNext:{[unowned self] (model) in
                if(model.success)!{
                    self.IsLoginSuccess = true
                }
            })
        .disposed(by: disposeBag)
    }
    
    func ModifyPwd(_ userId:Int,_ oldpwd:String,_ newpwd:String){
        DataCommand
            .flatMap { [unowned self] in Network.ModifyPwd(userId, oldpwd, newpwd) }
            .subscribe(onNext:{[unowned self] (model) in
                if(model.success)!{
                    self.IsLoginSuccess = true
                }
            })
            .disposed(by: disposeBag)
    }
}
