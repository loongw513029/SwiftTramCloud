//
//  SystemViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import UIKit
class SystemViewController: TramUIViewController {
    var headerImage:UIImageView!
    var userLabel:UILabel!
    var roleLabel:UILabel!
    
    var newsButton:UIButton!
    var feedbackButton:UIButton!
    var useButton:UIButton!
    var aboutBUtton:UIButton!
    var loginButton:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomNavigationBar("个人中心", false, false, true, "", 0, 0,1)
        initView()
    }
    
    func initView(){
        let height = bounds.height - statusHeight-AppDelegate().TabBarHeight
        let sysHeaderHeight = height * 0.1385
        let baseView = UIKitUtil.CreateUiView(self.view, x: 0, y: 0, width: bounds.width, height: height, backgroundColor: "f1f3f8")
        let headerView = UIKitUtil.CreateUiView(baseView, x: 0, y: 0, width: bounds.width, height: sysHeaderHeight, backgroundColor: "099bee")
        let mar = (sysHeaderHeight - sysHeaderHeight*0.67)/2
        let imageView = UIKitUtil.CreateUiView(headerView, x: mar, y: mar, width: sysHeaderHeight*0.67, height: sysHeaderHeight*0.67, backgroundColor: "ffffff")
        imageView.layer.cornerRadius = (sysHeaderHeight*0.67)/2
        headerImage = UIKitUtil.CreateUIImageView(imageView, "ic_header", x: 1, y: 1, width: sysHeaderHeight*0.67-2, height: sysHeaderHeight*0.67-2)
        
        let lwidth = sysHeaderHeight*0.67 + (mar * 2)
        let lheight = (sysHeaderHeight - 40)/2
        let labelWidth = bounds.width - (lwidth*2)
        userLabel = UIKitUtil.CreateUILable(headerView, text: "账户:admin", x: lwidth, y: lheight, width: labelWidth, height: 20, textColor: "ffffff", textSize: 13, textAlign: .left)
        roleLabel = UIKitUtil.CreateUILable(headerView, text: "账户:admin", x: lwidth, y: lheight+20, width: labelWidth, height: 20, textColor: "ffffff", textSize: 13, textAlign: .left)
        
        let itemHeight = height * 0.08
        newsButton = craetaItemView(baseView,"新消息通知",1,sysHeaderHeight+10,itemHeight)
        feedbackButton = craetaItemView(baseView,"信息反馈",2,sysHeaderHeight+10+itemHeight,itemHeight)
        useButton = craetaItemView(baseView,"使用说明",3,sysHeaderHeight+10+(itemHeight*2),itemHeight)
        aboutBUtton = craetaItemView(baseView,"关于App",4,sysHeaderHeight+10+(itemHeight*3),itemHeight)
        
        loginButton = UIKitUtil.CreateUiButton(baseView, text: "退 出", x: 10, y: sysHeaderHeight+30+(itemHeight*4), width: bounds.width-20, height: 40, textColor: "ffffff", textSize: 14, tag: 5)
        loginButton.layer.cornerRadius = 3
        loginButton.backgroundColor = UIColor.hexStringToColor(hexString: "e77d0d")
        loginButton.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
    }
    func craetaItemView(_ parentView:UIView,_ itemName:String,_ tag:Int,_ top:CGFloat,_ itemHeight:CGFloat)->UIButton{
        let view = UIKitUtil.CreateUiView(parentView, x: 0, y: top, width: bounds.width, height: itemHeight, backgroundColor: "ffffff")
        view.layer.borderColor = UIColor.hexStringToColor(hexString: "dedede").cgColor
        view.layer.borderWidth = 1
        let itemTop = itemHeight/2 - 10
        let button = UIKitUtil.CreateUiButton(view, text: itemName, x: 0, y: itemTop, width: bounds.width, height: 20, textColor: "000000", textSize: 13, tag: tag)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        UIKitUtil.CreateUIImageView(view, "ic_tz", x: bounds.width-30, y: (itemHeight-20)/2, width: 20, height: 20)
        button.addTarget(self, action: #selector(Handle(_:)), for: .touchUpInside)
        return button
    }
    
    @objc func Handle(_ sender:UIButton){
        print(sender.tag)
    }
}
