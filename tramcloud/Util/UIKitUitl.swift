//
//  UIKitUitl.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/6.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import UIKit
public class UIKitUtil {
    //创建UIView
    static func CreateUiView(_ parentView:UIView?,x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,backgroundColor:String) -> UIView{
        let view = UIView(frame:CGRect(x:x,y:y,width:width,height:height))
        view.backgroundColor = UIColor.hexStringToColor(hexString: backgroundColor)
        
        if(parentView != nil){
            parentView?.addSubview(view)
        }
        return view
    }
    //创建UILabel
    static func CreateUILable(_ parentView:UIView?,text:String,x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,textColor:String,textSize:CGFloat,textAlign:NSTextAlignment) -> UILabel{
        let label=UILabel(frame:CGRect(x:x,y:y,width:width,height:height))
        label.textAlignment = textAlign
        label.textColor = UIColor.hexStringToColor(hexString: textColor)
        label.text = text
        label.font = UIFont.systemFont(ofSize: textSize)
        if(parentView != nil){
            parentView?.addSubview(label)
        }
        return label
    }
    static func CreateUiButton(_ pview:UIView?,text:String,x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,textColor:String,textSize:CGFloat,tag:Int) ->UIButton{
        let button = UIButton(frame:CGRect(x:x,y:y,width:width,height:height))
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.hexStringToColor(hexString: textColor), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: textSize)
        button.tag = tag
       
        if(pview != nil){
            pview?.addSubview(button)
        }
        return button
    }
    static func CreateUIImageButton(_ pview:UIView?,text:String,x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,textColor:String,textSize:CGFloat,tag:Int,backgroundImageName:String,isShowText:Bool,selector:Selector,target:Any?)->UIButton{
        let button=self.CreateUiButton(pview, text: text, x: x, y: y, width: width, height: height, textColor: textColor, textSize: textSize, tag: tag);
        button.setBackgroundImage(UIImage(named:backgroundImageName), for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        if(!isShowText)
        {
            button.setTitle("", for: .normal)
        }
        return button
    }
    //创建UIImageView
    static func CreateUIImageView(_ pview:UIView?,_ imageName:String,x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat)-> UIImageView{
        
        let imageview = UIImageView(image:UIImage(named:imageName))
        imageview.frame = CGRect(x:x,y:y,width:width,height:height)
        if(pview != nil){
            pview?.addSubview(imageview)
        }
        return imageview
    }
    
    static func CreateTextField(_ view:UIView,_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat,
                                _ placeholder:String) ->UITextField{
        let textField = UITextField(frame:CGRect(x:x,y:y,width:width,height:height))
        if(view != nil){
            view.addSubview(textField)
        }
        textField.placeholder = placeholder
        return textField
    }
}
extension UIView{
    
    class func AddOnClickListener(target:AnyObject,action:Selector)
    {
        let gr=UITapGestureRecognizer(target:target,action:action)
        target.addGestureRecognizer(gr)
    }
}
