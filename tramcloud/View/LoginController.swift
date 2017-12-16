//
//  ViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/1.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Closures
import AttributedLib
class LoginController: UIViewController,LoginView{
    
    
    let bounds = UIScreen.main.bounds
    var txtusername:UITextField!
    var txtpassword:UITextField!
    var loginButton:UIButton!
    
    var presenter:AccountPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let size=UIScreen.main.bounds.size
        let height=size.width*231/320
        self.view.backgroundColor=UIColor.hexStringToColor(hexString: "f1f3f2")
        var headimage = UIKitUtil.CreateUIImageView(self.view, "login_header_logo", x: 0, y: 0, width:bounds.width , height: height)
        txtusername = UIKitUtil.CreateTextField(self.view, 10, height+30, bounds.width-20, 35, "请输入账号")
        txtpassword = UIKitUtil.CreateTextField(self.view, 10, height+75, bounds.width-20, 35, "请输入密码")
        txtusername.borderStyle = .roundedRect
        txtpassword.borderStyle = .roundedRect
        txtusername.clearButtonMode = .whileEditing
        txtpassword.clearButtonMode = .whileEditing
        txtpassword.isSecureTextEntry = true
        txtusername.font = UIFont.systemFont(ofSize: 14)
        txtpassword.font = UIFont.systemFont(ofSize: 14)
        let username_ico_image = UIImageView(image:UIImage(named:"login_username"))
        username_ico_image.frame = CGRect(x:10,y:5,width:20,height:20)
        txtusername.leftView = username_ico_image
        txtusername.leftViewMode = UITextFieldViewMode.always
        let pasword_ico_image = UIImageView(image:UIImage(named:"login_password"))
        pasword_ico_image.frame = CGRect(x:10,y:5,width:20,height:20)
        txtpassword.leftView = pasword_ico_image
        txtpassword.leftViewMode = UITextFieldViewMode.always
        loginButton = UIKitUtil.CreateUiButton(self.view, text: "登 录", x: 10, y: height+120, width: bounds.width-20, height: 40, textColor: "ffffff", textSize: 15, tag: 1)
        loginButton.addTarget(self, action:#selector(Handle(_:)), for:.touchUpInside)
        loginButton.backgroundColor = UIColor.hexStringToColor(hexString: "0b9bee")
        loginButton.layer.cornerRadius=3
       
        presenter = AccountPresenter(self,self.view)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func Handle(_ sender:UIButton) {
        let username = txtusername.text as! String
        let password = txtpassword.text as! String
        if(username == nil || username == ""){
            Toast.fail(with: "用户名不能为空!")
            return
        }
        if(password == nil || password == ""){
            Toast.fail(with: "密码不能为空!")
            return
        }
        presenter.Login(username,password,"")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyBoardWillShow(_ notification:Notification){
        let kbInfo = notification.userInfo
        //获得键盘size
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let changeY = kbRect.origin.y - UIScreen.main.bounds.size.height
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration:duration){
            self.view.transform = CGAffineTransform(translationX: 0, y: -160)
        }
    }
    @objc func keyBoardWillHide(_ notification:Notification){
        let kbInfo = notification.userInfo
        let kbRect = (kbInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let changeY = kbRect.origin.y
        let duration = kbInfo?[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration:duration){
            self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
   
}
extension LoginController:UITextFieldDelegate{
    
    
    //处理接收结果
    func GetLoginResult(_ result: BaseResult<UserInfo>) {
        if(!result.success!){
            Toast.fail(with: result.info)
        }else{
            Toast.success(with: result.info)
            
            let encodeObject = result.result!.toJSONString(prettyPrint: false)
            //print("userinfo->" + encodeObject!)
            UserDefaultUtil.setNormalDefault("userinfo", encodeObject)
            UserDefaultUtil.setNormalDefault("username", result.result!.UserName)
            UserDefaultUtil.setNormalDefault("access_token", result.result!.AccessToken)
            UserDefaultUtil.setNormalDefault("refresh_token", result.result!.RefreshToken)
            let homeController = TramTabBarController()
            self.present(homeController, animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.4) {
            self.view.frame.origin.y = 0
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("点击了textfiled")
        UIView.animate(withDuration: 0.4) {
            self.view.frame.origin.y = -150
        }
    }
}



