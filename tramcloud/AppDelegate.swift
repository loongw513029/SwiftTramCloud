//
//  AppDelegate.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/1.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let TabBarHeight = UIScreen.main.bounds.height*50/568
    let StatusHeight = UIApplication.shared.statusBarFrame.height
    var BaseUrl:String = "http://112.94.162.133:8089"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AMapServices.shared().apiKey = "5dc5cd0d8f46b98e2468caf44be0fc08"
        self.window = UIWindow(frame:UIScreen.main.bounds)
        let userInfo = UserDefaultUtil.getNormalUserDefault("userinfo") as! String
        //let rootVC = TramTabBarController()
        //let sb=UIStoryboard(name: "Main", bundle: nil)
        //let vc=sb.instantiateViewController(withIdentifier: "TramUIViewController")
        //let nav = UINavigationController(rootViewController:TramTabBarController())
        self.window?.rootViewController = userInfo == "" ? LoginController() : TramTabBarController()
        //self.window!.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

