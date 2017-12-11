//
//  UserViewModel.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/11.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import HandyJSON
struct UserInfo : HandyJSON{
    var Id:Int?
    var UserName:String?
    var RealName:String?
    var RoleId:Int?
    var RoleName:String?
    var Phone:String?
    var Photo:String?
    var DepartmentId:Int?
    var DepartmentType:Int?
    var RoleLV:Int?
    var ManageScope:String?
    var DepartmentName:String?
    var AccessToken:String?
    var RefreshToken:String?
    var IsTram:Bool?
    var DeviceScopes:[String]?
    var AppConf:AppRoleModel?
}
struct AppRoleModel : HandyJSON{
    var AppName:String?
    var OrgType:Int?
    var IsHaveCan:Bool?
    var IsHaveVedio:Bool?
    var IsHaveGps:Bool?
}
