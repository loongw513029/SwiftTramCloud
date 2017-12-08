//
//  TramTabBarItem.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import UIKit
public class TramTabBarItem {
    
    private(set) var title: String                = ""
    private(set) var controller: UIViewController?
    private(set) var selectedImageName: String    = ""
    private(set) var unSelectedImageName: String  = ""
    private(set) var selected: Bool               = false
    
    private init() {
        
    }
    
    //  MARK: 实例化JMSTabBarItem
    /// 实例化JMSTabBarItem
    ///
    /// - Parameters:
    ///     - tTitle: 标题
    ///     - tControllerClass:     类
    ///     - tSelectedImageName:   选中的显示图像名称
    ///     - tUnSelectedImageName: 未选中的显示图像名称
    ///     - tSelected:            是否选中
    public init(tTitle:String, tController:UIViewController, tSelectedImageName:String, tUnSelectedImageName:String, tSelected:Bool) {
        self.title               = tTitle
        self.controller          = tController
        self.selectedImageName   = tSelectedImageName
        self.unSelectedImageName = tUnSelectedImageName
        self.selected            = tSelected
    }
    
}
