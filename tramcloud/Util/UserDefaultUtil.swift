//
//  UserDefaultUtil.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/11.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
public class UserDefaultUtil {
    //存储对象
    static func setNormalDefault(_ key:String,_ value:Any?){
        if(value == nil){
            UserDefaults.standard.removeObject(forKey: key)
        }
        else{
            UserDefaults.standard.set(value, forKey: key)
            //同步操作
            UserDefaults.standard.synchronize()
        }
    }
    
    //移除存储
    static func removeNormalUserDefault(_ key:String){
        if(key == nil){
            UserDefaults.standard.removeObject(forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    //通过key值查找结果
    static func getNormalUserDefault(_ key:String) -> Any?{
        return UserDefaults.standard.value(forKey: key)
    }
}

