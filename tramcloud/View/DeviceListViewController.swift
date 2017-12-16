//
//  DeviceListUIViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/8.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
class DeviceListViewController: TramUIViewController,UITableViewDataSource,UITableViewDelegate,DeviceView {
    
    var tag:Int!
    var tableView:UITableView!
    var datas = Array<DeviceListModel>()
    var devicePresenter:DevicePresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        showBackButton()
        if(devicePresenter == nil)
        {
            devicePresenter = DevicePresenter(self.view,self)
        }
        initView()
        devicePresenter.GetDeviceList(userInfo.Id!, 0)
    }
    func initView(){
        createTableHeader(self.view)
        let height = bounds.height - statusHeight-30
        tableView = UITableView(frame:CGRect(x:0,y:30,width:bounds.width,height:height),style:.plain)
        tableView.register(DeviceListTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //创建表头
    func createTableHeader(_ tableView:UIView){
        let headerView = UIView(frame:CGRect(x:0,y:0,width:bounds.width,height:30))
        headerView.backgroundColor = UIColor.hexStringToColor(hexString: "dedede")
        UIKitUtil.CreateUILable(headerView, text: "设备编号", x: 0, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "车牌号码", x: bounds.width*0.25, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "司机名称", x: bounds.width*0.5, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "在线状态", x: bounds.width*0.75, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        self.view.addSubview(headerView)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentity = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity) as? DeviceListTableViewCell
        cell?.devicecodeLabel.text = datas[indexPath.row].DeviceCode
        cell?.busnumberLabel.text = datas[indexPath.row].DeviceCode
        cell?.drivernameLabel.text = datas[indexPath.row].DriverName
        if(datas[indexPath.row].IsOnline)!{
            cell?.onlinestatusLabel.text = "在线"
            cell?.onlinestatusLabel.textColor = UIColor.green
        }else{
            cell?.onlinestatusLabel.text = "离线"
            cell?.onlinestatusLabel.textColor = UIColor.gray
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deviceView = DeviceViewController()
        deviceView.deviceListModel = self.datas[indexPath.row]
        deviceView.title = self.datas[indexPath.row].DeviceCode
        self.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(deviceView, animated: true)
        
    }
}
extension DeviceListViewController{
    
    func GetDeviceList(_ data: [DeviceListModel]) {
        if(tag == 2){
            var Arrs = Array<DeviceListModel>()
            for i in 0..<data.count{
                if(data[i].IsOnline)!{
                    Arrs.append(data[i])
                }
            }
            self.datas = Arrs
        }else{
            self.datas = data
        }
        self.tableView.reloadData()
    }
    
    
}
