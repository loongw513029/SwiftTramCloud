//
//  DeviceFilterViewCell.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/12.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
class DeviceViewCell: UICollectionViewCell {
    var txtLabel:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        step()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func step(){
        txtLabel = UIButton(frame:CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height))
        txtLabel.backgroundColor = UIColor.hexStringToColor(hexString: "415077")
        txtLabel.titleLabel?.textColor = UIColor.hexStringToColor(hexString: "ffffff")
        txtLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.addSubview(txtLabel)
    }
    
    
}

