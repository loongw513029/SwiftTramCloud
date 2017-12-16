//
//  TramCusHeader.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import MJRefresh
class TramCusHeader : MJRefreshHeader{
    var label:UILabel!

    var logo:UIImageView!
    var loading:UIActivityIndicatorView!
    
    //在这里做一些初始化配置（比如添加子控件）
    override func prepare()
    {
        super.prepare()
        
        // 设置控件的高度
        self.mj_h = 50
        
        // 添加label
        self.label =  UILabel()
        self.label.textColor = UIColor.hexStringToColor(hexString: "dedede")
        self.label.font = UIFont.boldSystemFont(ofSize: 16)
        self.label.textAlignment = .left
        self.addSubview(self.label)
        
        // logo
        self.logo =  UIImageView(image:UIImage(named:"refresh_header"))
        self.logo.contentMode = .scaleAspectFit
        self.addSubview(self.logo)
        
        // loading
        self.loading =  UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.addSubview(self.loading)
    }
    
    //在这里设置子控件的位置和尺寸
    override func placeSubviews()
    {
        super.placeSubviews()
        
        self.label.frame = CGRect(x:(bounds.width-120)/2, y:0, width:120, height:50)
        
        self.logo.frame = CGRect(x:(bounds.width-170)/2, y:0, width:50, height:50)
        
        self.loading.center = CGPoint(x:self.mj_w - 30, y:self.mj_h * 0.5)
    }
    
    //监听控件的刷新状态
    override var state: MJRefreshState{
        didSet
        {
            switch (state) {
            case .idle:
                self.loading.stopAnimating()
                self.label.text = "下拉刷新..."
                break
            case .pulling:
                self.loading.stopAnimating()
                self.label.text = "松开立即刷新..."
                break
            case .refreshing:
                self.label.text = "加载数据中..."
                self.loading.startAnimating()
                break
            default:
                break
            }
        }
    }
    
    //监听拖拽比例（控件被拖出来的比例）
    override var pullingPercent: CGFloat {
        didSet
        {
            // 1.0 0.5 0.0
            // 0.5 0.0 0.5
            let  red =  1.0 - pullingPercent * 0.5
            let green =  0.5 - 0.5 * pullingPercent
            let blue =  0.5 * pullingPercent
            self.label.textColor = UIColor(red:red, green:green, blue:blue, alpha:1.0)
        }
    }
    
    //监听scrollView的contentOffset改变
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }
    
    //监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }
    
    //监听scrollView的拖拽状态改变
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }
}
