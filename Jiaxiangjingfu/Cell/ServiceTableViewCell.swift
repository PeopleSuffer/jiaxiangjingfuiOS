//
//  ServiceTableViewCell.swift
//  Jiaxiangjingfu
//
//  Created by 李胤馀 on 2017/12/18.
//  Copyright © 2017年 Yehai. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {

    lazy var serviceName = UILabel()
    lazy var area = UILabel()
    lazy var price = UILabel()
    lazy var reserveButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
