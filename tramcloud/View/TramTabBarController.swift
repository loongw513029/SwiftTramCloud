//
//  NvTabBarController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/5.
//  Copyright © 2017年  tvis. All rights reserved.
//
import Foundation
import UIKit
class TramTabBarController: UITabBarController {
    var _backView:UIView? = nil
   
    let NameArr = ["CAN","视频","首页","地图","系统"]
    let PicArr = ["can","video","home_active","map","sys"]
    let PicSelectArr = ["can_active","video_active","home_active","map_active","sys_active"]
    let VCArr = [CanViewController(),VideoViewController(),HomeViewController(),MapViewController(),SystemViewController()]
    //初始化数组
    var NavVCArr:[NSObject] = [NSObject]()
    var nav:UINavigationController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CreatTabBar()
    }
    
    //创建tabBar
    func CreatTabBar()  {
        let tbHeight = AppDelegate().TabBarHeight        
        _backView = UIView(frame:CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:tbHeight))
         for  M in 0 ..< VCArr.count {
            nav = UINavigationController(rootViewController:(VCArr[M] as AnyObject as! UIViewController))
            if(M != 2){
                nav.tabBarItem.image = UIImage(named:PicArr[M])
                nav.tabBarItem.selectedImage = UIImage(named:PicSelectArr[M])
                nav.tabBarItem.title = NameArr[M]
            }
            else{
                let reSize = CGSize(width: tbHeight*0.8, height: tbHeight*0.8)
                nav.tabBarItem.image = UIImage(named:PicArr[M])?.reSizeImage(reSize: reSize)
                nav.tabBarItem.selectedImage = UIImage(named:PicArr[M])?.reSizeImage(reSize: reSize)
                nav.tabBarItem.imageInsets=UIEdgeInsetsMake(6,0,-6,0)
            }
             //VCArr[M].title = NameArr[M]
             NavVCArr.append(nav)
            
            self.navigationController?.title = NameArr[M]
         }
         // 添加工具栏
         self.viewControllers = NavVCArr as? [UIViewController]
         for  i in 0 ..< NavVCArr.count {
             //设置导航栏的背景图片 （优先级高）
             //(NavVCArr[i] as AnyObject).navigationBar.setBackgroundImage(UIImage(named:"NavigationBar"), for:.default)
             //设置顶部Title的背景颜色 （优先级低）
             (NavVCArr[i] as AnyObject).navigationBar.barTintColor = UIColor.hexStringToColor(hexString: "0b9bee")
             (NavVCArr[i] as AnyObject).navigationBar.isTranslucent = false
             //设置导航栏的字体颜色
            (NavVCArr[i] as AnyObject).navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.hexStringToColor(hexString: "ffffff")]
            
         }
        //tabBar 底部工具栏背景颜色 (以下两个都行)
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = UIColor.hexStringToColor(hexString: "ff4081")
        //设置 tabBar 工具栏字体颜色 (未选中  和  选中)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.hexStringToColor(hexString: "8a8a8a")], for: .highlighted)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.hexStringToColor(hexString: "0b9bee")], for: .selected);
        //默认选中首页控制器
        self.selectedIndex = 2
        
    }
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        let tabIndex = tabBar.items?.index(of:item)
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
