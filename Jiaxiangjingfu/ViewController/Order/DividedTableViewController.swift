//
//  DividedTableViewController.swift
//  Jiaxiangjingfu
//
//  Created by 李胤馀 on 2017/12/21.
//  Copyright © 2017年 Yehai. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Moya
import SwiftyJSON

class DividedTableViewController: UITableViewController, IndicatorInfoProvider {
    
    var isMultiple = false
    var orders: [Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), style: UITableViewStyle.grouped)
        self.tableView.register(UINib.init(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCell")
        self.tableView.separatorStyle = .none
        
        var req = MyService.singletimeOrder
        if isMultiple {
            req = MyService.repeatedOrder
        }
        provider.request(req) { result in
            switch result {
            case .success(let response):
                let data = response.data
                let json = JSON(data)
                if let orders = Order.initOrders(json: json) {
                    self.orders = orders
                    self.tableView.reloadData()
                }
            case .failure(let error):
                return
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return orders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as! OrderTableViewCell
        cell.setUI(order: orders[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if isMultiple {
            return IndicatorInfo(title: "单次")
        }
        return IndicatorInfo(title: "多次")
    }

}
