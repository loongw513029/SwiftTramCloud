//
//  BaseUIViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/4.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
class BaseUIViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //监听键盘变化
        self.navigationItem.backBarButtonItem?.title = "返回"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
 
    
   
    
   
}

