//
//  MineViewController.swift
//  Jiaxiangjingfu
//
//  Created by 李胤馀 on 2017/12/21.
//  Copyright © 2017年 Yehai. All rights reserved.
//

import UIKit
import SnapKit

class MineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var topPanel = UIView()
    lazy var tableView = UITableView(frame: CGRect.init(), style: .grouped)
    
    let topPanelHeight = 60

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        
        do {
            self.view.addSubview(topPanel)
            topPanel.backgroundColor = UIColor.white
            topPanel.snp.makeConstraints({ (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(150)
            })
            
            let ImageContainer = UIView()
            ImageContainer.layer.cornerRadius = 30
            ImageContainer.layer.borderWidth = 0.5
            ImageContainer.layer.borderColor = UIColor.lightGray.cgColor
            topPanel.addSubview(ImageContainer)
            ImageContainer.snp.makeConstraints({ (make) in
                make.left.equalTo(30)
                make.centerY.equalToSuperview().offset(10)
                make.height.width.equalTo(topPanelHeight)
            })
            
            let ImageView = UIImageView()
            ImageView.image = #imageLiteral(resourceName: "mallbg")
            ImageView.layer.cornerRadius = 29
            ImageView.contentMode = .scaleToFill
            ImageContainer.addSubview(ImageView)
            ImageView.snp.makeConstraints({ (make) in
                make.centerX.centerY.equalToSuperview()
                make.width.height.equalTo(58)
            })
            
            let loginButton = UIButton()
            loginButton.setTitle("点击登录/注册", for: UIControlState.normal)
            loginButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            topPanel.addSubview(loginButton)
            loginButton.snp.makeConstraints({ (make) in
                make.left.equalTo(ImageContainer.snp.right).offset(20)
                make.centerY.equalTo(ImageContainer).offset(5)
            })
            
            //scroll view
            self.view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib.init(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "MineTableViewCell")
            tableView.snp.makeConstraints({ (make) in
                make.top.equalTo(topPanel.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineTableViewCell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MineTableViewCell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
