//
//  TramUIViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/6.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class TramUIViewController: UIViewController {
    
    let bounds=UIScreen.main.bounds
    var statusHeight:CGFloat = 0
    var provider = MoyaProvider<ApiManager>()
    override func viewDidLoad() {
        super.viewDidLoad()
        IsLogin()
        statusHeight = UIApplication.shared.statusBarFrame.height+(self.navigationController?.navigationBar.frame.height)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 17),NSAttributedStringKey.foregroundColor:UIColor.white]
    }
    func IsLogin(){
        if(UserDefaultUtil.getNormalUserDefault("userinfo") == nil){
            let loginView = LoginController()
            self.present(loginView, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func CustomNavigationBar(_ naviBarTitle:String,_ showBack:Bool,_ showRightBtn:Bool,_ hideSecondTitle:Bool,_ code:String,_ longTime:Int,_ interval:Int){
        //self.navigationController?.isNavigationBarHidden = false
        //隐藏系统的导航栏 不然点击事件受到影响
     
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
        let cview = UIView(frame:CGRect(x:0,y:0,width:bounds.width*0.7,height:40))
        let titleLabel = UILabel(frame: CGRect(x:0,y:0,width:bounds.width*0.7,height:20))
        titleLabel.text = naviBarTitle
        titleLabel.textColor = UIColor.white
        //这里使用系统自定义的字体
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        cview.addSubview(titleLabel)
        if(!hideSecondTitle){
            let secondView = UIView(frame:CGRect(x:(bounds.width*0.7-180)/2,y:20,width:180,height:20))
            cview.addSubview(secondView)
            let codeImg = UIKitUtil.CreateUIImageView(secondView, "ic_info_tip", x: 0, y: 3, width: 14, height: 14)
            let codeTitle = UIKitUtil.CreateUILable(secondView, text: code, x: 15, y: 0, width: 30, height: 20, textColor: "ffffff", textSize: 12, textAlign: .left)
            let ltImg = UIKitUtil.CreateUIImageView(secondView, "ic_time_tip", x: 48, y: 3, width: 14, height: 14)
            let ltTitle = UIKitUtil.CreateUILable(secondView, text: "时长:"+String(longTime)+"分钟", x: 63, y: 0, width: 60, height: 20, textColor: "ffffff", textSize: 12, textAlign: .left)
            let intTitle = UIKitUtil.CreateUILable(secondView, text: "间隔:"+String(interval)+"秒", x: 126, y: 0, width: 60, height: 20, textColor: "ffffff", textSize: 12, textAlign: .left)
        }
        // 设置自定义的title
        self.navigationItem.titleView = cview
        if(showBack){
            // 创建左侧按钮
            showBackButton()
        }
        if(showRightBtn){
            // 创建右侧
            let rightButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            rightButton.image = UIImage(named:"ic_more")
            rightButton.tintColor = UIColor.white
            rightButton.width = -20
            // 添加左侧、右侧按钮            
            //self.navigationItem.setRightBarButton(rightButton, animated: true)
            self.navigationItem.rightBarButtonItems = [rightButton]
        }
        
        self.navigationItem.setHidesBackButton(false, animated: true)
        // 把导航栏组件加入导航栏
        //self.navigationController?.navigationItem.pushItem(navItem, animated: false)
        // 导航栏添加到view上
        //self.view.addSubview(navBar)
    }
    func CustomNavigationAnalysisBar(_ naviBarTitle:String,_ showBack:Bool,_ showRightBtn:Bool,_ hideSecondTitle:Bool,_ code:String,_ day:Int){
        //self.navigationController?.isNavigationBarHidden = false
        //隐藏系统的导航栏 不然点击事件受到影响
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
        let cview = UIView(frame:CGRect(x:0,y:0,width:bounds.width*0.7,height:40))
        cview.center = CGPoint(x:self.view.bounds.width/2,y:40)
        let titleLabel = UILabel(frame: CGRect(x:0,y:0,width:bounds.width*0.7,height:20))
        titleLabel.text = naviBarTitle
        titleLabel.textColor = UIColor.white
        //这里使用系统自定义的字体
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        cview.addSubview(titleLabel)
        if(!hideSecondTitle){
            let secondView = UIView(frame:CGRect(x:(bounds.width*0.7-120)/2,y:20,width:180,height:20))
            cview.addSubview(secondView)
            let codeImg = UIKitUtil.CreateUIImageView(secondView, "ic_info_tip", x: 0, y: 3, width: 14, height: 14)
            let codeTitle = UIKitUtil.CreateUILable(secondView, text: code, x: 15, y: 0, width: 35, height: 20, textColor: "ffffff", textSize: 12, textAlign: .left)
            let ltImg = UIKitUtil.CreateUIImageView(secondView, "ic_time_tip", x: 53, y: 3, width: 14, height: 14)
            let ltTitle = UIKitUtil.CreateUILable(secondView, text: "近"+String(day)+"天", x: 68, y: 0, width: 60, height: 20, textColor: "ffffff", textSize: 12, textAlign: .left)
        }
        // 设置自定义的title
        self.navigationItem.titleView = cview
        if(showBack){
            // 创建左侧按钮
            showBackButton()
        }
        if(showRightBtn){
            // 创建右侧
            let rightButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            rightButton.image = UIImage(named:"ic_more")
            rightButton.tintColor = UIColor.white
            rightButton.width = -20
            // 添加左侧、右侧按钮
            //self.navigationItem.setRightBarButton(rightButton, animated: true)
            self.navigationItem.rightBarButtonItems = [rightButton]
        }
        
        self.navigationItem.setHidesBackButton(false, animated: true)
        // 把导航栏组件加入导航栏
        //self.navigationController?.navigationItem.pushItem(navItem, animated: false)
        // 导航栏添加到view上
        //self.view.addSubview(navBar)
    }
    
    func showBackButton(){
        let backButton=UIBarButtonItem(title:"",style:.plain,target:self,action:#selector(backToPrevious))
        self.navigationItem.backBarButtonItem = backButton
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    @objc func backToPrevious(){
        self.navigationController!.popViewController(animated: true)
    }
    
}
