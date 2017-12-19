//
//  InspectViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/18.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
import MJRefresh
class InspectViewController : TramUIViewController{
    var baseView:UIView!
    var viewHeight:CGFloat = 0
    var tableView:UITableView!
    let header = TramCusHeader()
    let footer = MJRefreshAutoNormalFooter()
    var page:Int = 1
    var rows:Int = 15
    var keys:String = ""
    var devicePresenter:DevicePresenter!
    lazy var list:[DeviceInspectModel] = {
        return [DeviceInspectModel]()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        if(devicePresenter == nil){
            devicePresenter = DevicePresenter(self.view,self)
        }
        self.reloadData()
    }
    
    private lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar(frame:CGRect(x:0,y:0,width:200,height:40))
        searchBar.placeholder = "请输入设备编号"
        searchBar.backgroundColor = UIColor.clear
        searchBar.delegate = self
        return searchBar
    }()

    
    func createTableHeader(_ tableView:UIView){
        let headerView = UIView(frame:CGRect(x:0,y:0,width:bounds.width,height:30))
        headerView.backgroundColor = UIColor.hexStringToColor(hexString: "dedede")
        UIKitUtil.CreateUILable(headerView, text: "设备编号", x: 0, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "车牌号码", x: bounds.width*0.25, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "司机名称", x: bounds.width*0.5, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        UIKitUtil.CreateUILable(headerView, text: "在线状态", x: bounds.width*0.75, y: 5, width: bounds.width*0.25, height: 20, textColor: "000000", textSize: 13, textAlign: .center)
        self.view.addSubview(headerView)
    }
    
    func initView(){
        viewHeight = bounds.height - AppDelegate().StatusHeight - (self.navigationController?.navigationBar.frame.height)!
        let TitleView = UIView(frame:CGRect(x:0,y:0,width:200,height:40))
        TitleView.addSubview(self.searchBar)
        self.navigationItem.titleView = TitleView
        baseView = UIKitUtil.CreateUiView(self.view, x: 0, y: 0, width: bounds.width, height: viewHeight, backgroundColor: "ffffff")
        self.createTableHeader(baseView)
        self.tableView = UITableView(frame:CGRect(x:0,y:30,width:bounds.width,height:viewHeight-30))
        tableView.register(DeviceInspectTableViewCell.self, forCellReuseIdentifier: "cell")
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.isAutomaticallyRefresh = false
        footer.setTitle("上拉加载更多...", for: .idle)
        footer.setTitle("正在加载数据...", for: .refreshing)
        footer.setTitle("没有更多数据了！", for: .noMoreData)
        self.tableView.mj_header = header
        self.tableView.mj_footer = footer
        baseView.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    
}

extension InspectViewController : UISearchBarDelegate,UISearchControllerDelegate{
    func didPresentSearchController(_ searchController: UISearchController) {
        self.searchBar.becomeFirstResponder()
    }
}

extension InspectViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentity = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentity) as? DeviceInspectTableViewCell
        cell?.devicecodeLabel.text = list[indexPath.row].DeviceCode
        cell?.busnumberLabel.text = list[indexPath.row].LineName
        cell?.drivernameLabel.text = list[indexPath.row].OrganizationName
        if(list[indexPath.row].State == 1){
            cell?.onlinestatusLabel.text = "在线"
            cell?.onlinestatusLabel.textColor = UIColor.green
        }else{
            cell?.onlinestatusLabel.text = "离线"
            cell?.onlinestatusLabel.textColor = UIColor.gray
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = list[indexPath.row]
        let detailViewController = InspectDetailViewController()
        detailViewController.title = "巡检详情"
        detailViewController.inspectModel = model
        self.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
    
}
extension InspectViewController:DeviceInspectView{
    
    func reloadData(){
        devicePresenter.GetInspectList(GetSelLineId(), userInfo.DepartmentId!, self.keys, self.page, self.rows)
    }
    
    func GetInspectList(_ data: [DeviceInspectModel]) {
        if(self.page == 1){
            self.list = data
        }else{
            if(!self.list.isEmpty){
                self.list += data
            }
        }
        self.tableView.reloadData()
    }
    
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
    
}
