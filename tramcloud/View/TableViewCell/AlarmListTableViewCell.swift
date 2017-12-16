//
//  AlarmListTableViewCell.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
class AlarmListTableViewCell:UITableViewCell{
    var deviceCode:UILabel!
    var typeName:UILabel!
    var time:UILabel!
    var imagePic:UIImageView!
    
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
        deviceCode = UIKitUtil.CreateUILable(self, text: "", x: 0, y: 10, width: width, height: 25, textColor: "000000", textSize: 13, textAlign: .center)
        typeName = UIKitUtil.CreateUILable(self, text: "", x: width, y: 10, width: width, height: 25, textColor: "000000", textSize: 13, textAlign: .center)
        time = UIKitUtil.CreateUILable(self, text: "", x: width*2, y: 10, width: width, height: 25, textColor: "000000", textSize: 13, textAlign: .center)
        imagePic = UIKitUtil.CreateUIImageView(self, "imgicon", x: width*3+(width-25)/2, y: 10, width: 25, height: 25)
    }
}
