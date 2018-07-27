//
//  Order.swift
//  Jiaxiangjingfu
//
//  Created by 李胤馀 on 2017/12/23.
//  Copyright © 2017年 Yehai. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Order {
    
    let serviceId: String
    let serviceName: String
    let serviceTime: String
    let serviceState: String
}

extension Order {
    init?(json: JSON) {
        guard let serviceId = json["serviceId"].string,
            let serviceName = json["serviceName"].string,
            let serviceTime = json["serviceTime"].string,
            let serviceState = json["serviceState"].string else {
                return nil
        }
        self.init(serviceId: serviceId, serviceName: serviceName, serviceTime: serviceTime, serviceState: serviceState)
    }

    static func initOrders(json: JSON) -> [Order]? {
        var orders = [Order]()
        let orderarray = json.arrayValue
        for orderJson in orderarray {
            guard let order = Order(json: orderJson) else {
                return nil
            }
            orders.append(order)
        }
        return orders
    }
}
