//
//  AlarmListViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/16.
//  Copyright © 2017年  tvis. All rights reserved.
//

import Foundation
import MJRefresh
class AlarmListViewController: TramUIViewController {
    
    var selectedRow = 0
    var list:[AlarmDetailModel] = [AlarmDetailModel]()
    let header = TramCusHeader()
    let footer = MJRefreshAutoNormalFooter()
    var tableView:UITableView!
    var page:Int = 1
    var rows:Int = 15
    var dayType:Int = 2
    var type:Int = 0
    var typeName:String = ""
    var alarmPresenter:AlarmPresenter!
    var searchKey:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if(alarmPresenter == nil){
            self.alarmPresenter = AlarmPresenter(self.view,self)
        }
        
        self.initView()
        self.reloadData()
    }
    func initView(){
        createTableHeader(self.view)
        let height = bounds.height - AppDelegate().StatusHeight - (self.navigationController?.navigationBar.frame.size.height)!-30
        let baseView = UIKitUtil.CreateUiView(self.view, x: 0, y: 0, width: bounds.width, height: height-30, backgroundColor: "ffffff")
        self.tableView = UITableView(frame:CGRect(x:0,y:30,width:bounds.width,height:height))
        tableView.register(AlarmListTableViewCell.self, forCellReuseIdentifier: "cell")
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.isAutomaticallyRefresh = false
        footer.setTitle("上拉加载更多...", for: .idle)
        footer.setTitle("正在加载数据...", for: .refreshing)
        footer.setTitle("没有更多数据了！", for: .noMoreData)
        self.tableView.mj_header = header
        self.tableView.mj_footer = footer
        baseView.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    ///创建表头
    func createTableHeader(_ tableView:UIView){
        let headerView = UIView(frame:CGRect(x:0,y:0,width:bounds.width,height:30))
        headerView.backgroundColor = UIColor.hexStringToColor(hexString: "dedede")
        UIKitUtil.CreateUILable(headerView, text: "设备编号", x: 0, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "报警类型", x: bounds.width*0.25, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "报警时间", x: bounds.width*0.5, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "查看", x: bounds.width*0.75, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        self.view.addSubview(headerView)
    }
}

extension AlarmListViewController : AlarmListView{
    @objc func headerRefresh(){
        self.page = 1
        reloadData()
        sleep(2)
        self.tableView.mj_header.endRefreshing()
    }
    @objc func footerRefresh(){
        self.page += 1
        reloadData()
        sleep(2)
        self.tableView.mj_footer.endRefreshing()
    }
    func reloadData(){
        alarmPresenter.GetAlarmList(userInfo.Id!, self.dayType, GetSelLineId(), self.type, self.searchKey, self.page, self.rows)
    }
    
    func GetAlarmList(_ data: PageDataModel<AlarmDetailModel>) {
        if(self.page == 1){
            self.list = data.Items!
        }else{
            if(!self.list.isEmpty){
                self.list += data.Items!
            }
        }
        self.tableView.reloadData()
    }    
    
}

extension AlarmListViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identityId = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identityId) as? AlarmListTableViewCell
        cell?.deviceCode.text = self.list[indexPath.row].DeviceCode
        cell?.typeName.text = self.list[indexPath.row].AlramName
        cell?.time.text = self.list[indexPath.row].UpdateTime
//        let av = self.list[indexPath.row].AlarmValue
//        if(av.index(of: "Storage") > -1){
//            cell?.imageView.image = UIImage(named:"imgicon")
//        }else{
//            cell?.imageView.image = UIImage(named:"map_active")
//        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alarmDetailViewController = AlarmDetailViewController()
        alarmDetailViewController.title = "报警详情"
        alarmDetailViewController.alarmModel = self.list[indexPath.row]
        self.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(alarmDetailViewController, animated: true)
    }
    
    
}
