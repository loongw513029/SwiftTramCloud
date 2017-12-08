//
//  ViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/1.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var bkView: UIView!
    @IBOutlet weak var headimage: UIImageView!
    @IBOutlet weak var txtusername: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let size=UIScreen.main.bounds.size
        let height=size.width*231/320
        bkView.backgroundColor=UIColor.hexStringToColor(hexString: "f1f3f2")
        headimage.frame.size=CGSize(width:size.width,height:height)
        txtusername.clearButtonMode = .whileEditing
        let username_ico_image = UIImageView(image:UIImage(named:"login_username"))
        username_ico_image.frame = CGRect(x:0,y:5,width:30,height:20)
        txtusername.leftView = username_ico_image
        txtusername.leftViewMode = UITextFieldViewMode.always
        let pasword_ico_image = UIImageView(image:UIImage(named:"login_password"))
        pasword_ico_image.frame = CGRect(x:0,y:5,width:30,height:20)
        txtpassword.leftView = pasword_ico_image
        txtpassword.leftViewMode = UITextFieldViewMode.always
        loginButton.addTarget(self, action:#selector(loginClick), for:.touchUpInside)
        loginButton.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
        loginButton.layer.cornerRadius=3
      
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func loginClick() {
        print("click this")
        let alert=UIAlertController.init(title:"tips",message:"msg",preferredStyle:.alert)
        alert.addAction(UIAlertAction.init(title:"cancle",style:.cancel,handler:nil))
        self.present(alert,animated: true)
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}


