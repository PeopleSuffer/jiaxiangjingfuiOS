//
//  OrderTableViewCell.swift
//  Jiaxiangjingfu
//
//  Created by 李胤馀 on 2017/12/22.
//  Copyright © 2017年 Yehai. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var reserveTime: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var evaluate: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        evaluate.isHidden = true
        evaluate.layer.borderWidth = 0.5
        evaluate.layer.cornerRadius = 10
        evaluate.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI(order: Order) {
        self.serviceName.text = order.serviceName
        self.reserveTime.text = order.serviceTime
        self.orderNumber.text = "订单编号：\(order.serviceId)"
        self.status.text = order.serviceState
        if order.serviceState == "待评价" {
            self.evaluate.isHidden = false
        }
    }
    
}
