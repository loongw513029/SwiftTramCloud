//
//  DeviceListTableViewCell.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/8.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
class DeviceListTableViewCell: UITableViewCell {
    
    var devicecodeLabel:UILabel!
    var busnumberLabel:UILabel!
    var drivernameLabel:UILabel!
    var onlinestatusLabel:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initView(){
        let width = UIScreen.main.bounds.width / 4
        devicecodeLabel = UIKitUtil.CreateUILable(self, text: "", x: 0, y: 10, width: width, height: 25, textColor: "000000", textSize: 13, textAlign: .center)
        busnumberLabel = UIKitUtil.CreateUILable(self, text: "", x: width, y: 10, width: width, height: 25, textColor: "000000", textSize: 13, textAlign: .center)
        drivernameLabel = UIKitUtil.CreateUILable(self, text: "", x: width*2, y: 10, width: width, height: 25, textColor: "000000", textSize: 13, textAlign: .center)
        onlinestatusLabel = UIKitUtil.CreateUILable(self, text: "", x: width*3, y: 10, width: width, height: 25, textColor: "000000", textSize: 13, textAlign: .center)
    }
}
