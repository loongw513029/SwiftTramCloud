//
//  DeviceInspectTableViewCell.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/18.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit

class InspectDetailTableViewCell : UITableViewCell{
    var inspectName:UILabel!
    var inspectValue:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        step()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func step(){
        let width = UIScreen.main.bounds.width
        inspectName = UIKitUtil.CreateUILable(self, text: "", x: 10, y: 10, width: width*0.5-10, height: 25, textColor: "000000", textSize: 13, textAlign: .left)
        inspectValue = UIKitUtil.CreateUILable(self, text: "", x: width*0.5, y: 10, width: width*0.5-10, height: 25, textColor: "000000", textSize: 13, textAlign: .right)
        
    }
}

