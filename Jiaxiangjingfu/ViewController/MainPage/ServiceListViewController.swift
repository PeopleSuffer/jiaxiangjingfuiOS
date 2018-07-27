//
//  ServiceListViewController.swift
//  Jiaxiangjingfu
//
//  Created by 李胤馀 on 2017/12/18.
//  Copyright © 2017年 Yehai. All rights reserved.
//

import UIKit

class ServiceListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    lazy var bannerView = UIView()
    lazy var servicesTableView = UITableView(frame: CGRect.init(), style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = false
        if let nav = self.navigationController {
            nav.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "mallbg"), for: UIBarMetrics.default)
        }
        self.edgesForExtendedLayout = []
        //setup banner
        self.view.addSubview(bannerView)
        let bannerImage = UIImageView(image: #imageLiteral(resourceName: "mallbg"))
        bannerImage.contentMode = .scaleAspectFill
        let imageHeightWidthRatio: CGFloat = 224/702
        let imageHeight = self.view.bounds.width * imageHeightWidthRatio
        bannerView.addSubview(bannerImage)
        bannerImage.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(imageHeight)
        }
        bannerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(bannerImage)
        }
        
        //setup services
        self.view.addSubview(servicesTableView)
        servicesTableView.snp.makeConstraints { (make) in
            make.top.equalTo(bannerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        servicesTableView.tableFooterView = UIView()
        servicesTableView.delegate = self
        servicesTableView.dataSource = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ServiceTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
