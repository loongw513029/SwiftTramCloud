//
//  InspectDetailViewController.swift
//  tramcloud
//
//  Created by  tvis on 2017/12/18.
//  Copyright © 2017年  tvis. All rights reserved.
//

import UIKit
class InspectDetailViewController: TramUIViewController {
    var inspectModel:DeviceInspectModel!
    var list = [InspectDetailAdapterModel]()
    var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let inspectAdapter = InspectDetailAdapterModel()
        self.list = inspectAdapter.ConvertToDetailArray(model: inspectModel)
        self.initView()
    }
    
    func initView(){
        let height = bounds.height - AppDelegate().StatusHeight - (self.navigationController?.navigationBar.frame.size.height)!
        tableView = UITableView(frame:CGRect(x:0,y:0,width:bounds.width,height:height))
        tableView.register(InspectDetailTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
}

extension InspectDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identityId = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identityId) as? InspectDetailTableViewCell
        cell?.inspectName.text = self.list[indexPath.row].Key
        cell?.inspectValue.text = self.list[indexPath.row].Value
        return cell!
    }
    
    
}
