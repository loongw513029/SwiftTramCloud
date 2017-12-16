//
//  Network.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/11.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
let bag = DisposeBag()


struct Network {
    static let provider = MoyaProvider<ApiManager>(plugins:[
        AuthPlugin(AccessToken: UserDefaultUtil.getNormalUserDefault("access_token") as! String, username: UserDefaultUtil.getNormalUserDefault("username") as! String, refreshToken: UserDefaultUtil.getNormalUserDefault("refresh_token") as! String)])
    
    ///登录方法
    static func Login(_ username:String,_ password:String,_ clientid:String) ->Observable<BaseResult<UserInfo>>{
        return Observable.create({ (observer) -> Disposable in
            provider
                .rx
                .request(ApiManager.Login(username,password,2,clientid))
                .filterSuccessfulStatusCodes()
                .subscribe(onSuccess: { (response) in
                    do {
                        let model = try response.mapModel(BaseResult<UserInfo>.self)
                        observer.onNext(model)
                        observer.onCompleted()
                    }catch{
                        //Toast.show(with: "格式解析失败")
                        observer.onError(error)
                    }
                }, onError: { (error) in
                    observer.onError(error)
                }).disposed(by: bag)
            return Disposables.create()
        })
    }
    
    ///登出
    static func LoginOut(_ username:String) ->Observable<BaseResult<String>>{
        return Observable.create({ (obs) -> Disposable in
            provider
                .rx
                .request(ApiManager.LoginOut(username))
                .filterSuccessfulStatusCodes()
                .subscribe(onSuccess: { (response) in
                    do{
                        let model = try response.mapModel(BaseResult<String>.self)
                        obs.onNext(model)
                        obs.onCompleted()
                    }catch{
                        obs.onError(error)
                    }
                }, onError: { (error) in
                    obs.onError(error)
                }).disposed(by: bag)
            return Disposables.create()
        })
    }
    
    ///修改密码
    static func ModifyPwd(_ userId:Int,_ oldpwd:String,_ newpwd:String) ->Observable<BaseResult<String>>{
        return Observable.create({ (obs) -> Disposable in
            provider
                .rx
                .request(ApiManager.ModifyPwd(userId, oldpwd, newpwd))
                .filterSuccessfulStatusCodes()
                .subscribe(onSuccess: { (response) in
                    do{
                        let model = try response.mapModel(BaseResult<String>.self)
                        obs.onNext(model)
                        obs.onCompleted()
                    }catch{
                        obs.onError(error)
                    }
                }, onError: { (error) in
                    obs.onError(error)
                }).disposed(by: bag)
            return Disposables.create()
        })
    }
}
struct AuthPlugin:PluginType {
    let AccessToken:String
    let username:String
    let refreshToken:String
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.timeoutInterval = 30
        request.addValue(username, forHTTPHeaderField: "username")
        request.addValue(AccessToken, forHTTPHeaderField: "access_token")
        request.addValue(refreshToken, forHTTPHeaderField: "refresh_token")
        return request
    }
}
