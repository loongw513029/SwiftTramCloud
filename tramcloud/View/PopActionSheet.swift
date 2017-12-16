//
//  PopActionSheet.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/15.
//  Copyright © 2017年  tvis. All rights reserved.
//
import Foundation
import Spring

class PopActionSheet: UIView {
    let screen_width = UIScreen.main.bounds.size.width
    let screen_height = UIScreen.main.bounds.size.height
    let backGroundView = SpringView() //背景视图
    let tap = UITapGestureRecognizer() //手势
    //init 调用方法
    init(title: String?, cancelButtonTitle: String?, buttonTitles: [String]?) {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        if buttonTitles == nil || buttonTitles?.count == 0 {
            return
        }
        
        // 自定义一个actionsheet
        self.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        // 添加手势
        tap.addTarget(self, action: #selector(self.removeWindowsView(_:)))
        self.addGestureRecognizer(tap)
        
        backGroundView.frame = CGRect(x: 0, y: screen_height, width: screen_width , height: 300)
        backGroundView.backgroundColor = UIColor.white
        backGroundView.layer.shadowColor = UIColor.lightGray.cgColor
        backGroundView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        
        
        //        backGroundView.animation = "FadeInUp"
        //        backGroundView.curve = "aseInOutBack"
        //        backGroundView.duration = 1.0
        //        backGroundView.damping = 0.7
        //        backGroundView.velocity = 0.7
        //        backGroundView.force = 1
        //        backGroundView.opacity = 1
        //        backGroundView.animateFrom = true
        //        backGroundView.rotate = 0
        //        backGroundView.animate()
        
        
        
        
        self.addSubview(backGroundView)
        
        
    }

        @objc func removeWindowsView(_ thetap:UITapGestureRecognizer) {
        dismiss()
    }


    func show() {
        
        UIApplication.shared.windows[0].addSubview(self)
        
        SpringAnimation.spring(duration: 0.5, animations: {
            self.backGroundView.frame = CGRect(x: 0, y: self.screen_height -  self.backGroundView.frame.size.height+20, width: self.screen_width , height: self.backGroundView.frame.size.height)
            
        })
        
    }

    func dismiss() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions(), animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/2.0, animations: {
                self.backGroundView.frame = CGRect(x: self.backGroundView.frame.origin.x, y: self.screen_height, width: self.backGroundView.frame.size.width, height: self.backGroundView.frame.size.height)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2.0, relativeDuration: 1/2.0, animations: {
                self.backgroundColor = UIColor(white: 0, alpha: 0)
            })
        }) { (finished) in
            self.backGroundView.removeFromSuperview()
            self.removeFromSuperview()
            self.removeGestureRecognizer(self.tap)
            self.removeFromSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


