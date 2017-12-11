//
//  LToast.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/11.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import CFNotify
import SwifterSwift
struct Toast {
    
    fileprivate init() {}
    
    
    static func show(with text:String) {
        let toastView = CFNotifyView.classicWith(title: "提示", body: text, theme:.info(.light))
        var classicViewConfig = CFNotify.Config()
        classicViewConfig.initPosition = .bottom(.random)
        classicViewConfig.appearPosition = .bottom
        classicViewConfig.hideTime = .custom(seconds: 1)
        CFNotify.present(config: classicViewConfig, view: toastView)
    }
    
    static func success(with text:String) {
        let toastView = CFNotifyView.classicWith(title: "提示", body: text, theme: .success(.light))
        var classicViewConfig = CFNotify.Config()
        classicViewConfig.initPosition = .bottom(.random)
        classicViewConfig.appearPosition = .bottom
        classicViewConfig.hideTime = .custom(seconds: 1)
        CFNotify.present(config: classicViewConfig, view: toastView)
    }
    
    static func fail(with text:String) {
        let toastView = CFNotifyView.classicWith(title: "提示", body: text, theme: .fail(.light))
        var classicViewConfig = CFNotify.Config()
        classicViewConfig.initPosition = .bottom(.random)
        classicViewConfig.appearPosition = .bottom
        classicViewConfig.hideTime = .custom(seconds: 1)
        CFNotify.present(config: classicViewConfig, view: toastView)
    }
    
}
