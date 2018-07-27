//
//  ViewController.swift
//  Jiaxiangjingfu
//
//  Created by 李胤馀 on 2017/12/11.
//  Copyright © 2017年 Yehai. All rights reserved.
//

import UIKit
import SnapKit
import Moya

class MainPageViewController: UIViewController {
    
    lazy var scrollView = UIScrollView()
    lazy var bannerView = UIView()
    lazy var serviceView = UIView()
    lazy var mallEntryButton = UIButton()
    lazy var mallEntryView = UIView()
    
    var itemSpacing: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Setup UI
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor.groupTableViewBackground
        do {
            //setup banner view
            self.view.addSubview(bannerView)
            let imageheight:Float = Float(self.view.bounds.width * #imageLiteral(resourceName: "banner").size.height / #imageLiteral(resourceName: "banner").size.width)

            bannerView.snp.makeConstraints { (make) in
                make.top.left.right.equalTo(self.view)
                make.height.equalTo(imageheight + 45)
            }

            let bannerImage = UIImageView()
            bannerImage.image = #imageLiteral(resourceName: "banner")
            bannerImage.contentMode = .scaleAspectFill
            bannerView.addSubview(bannerImage)
            bannerImage.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(imageheight)
            }
            
            let announcement = UIView()
            announcement.backgroundColor = UIColor.white
            self.bannerView.addSubview(announcement)
            announcement.snp.makeConstraints({ (make) in
                make.top.equalTo(bannerImage.snp.bottom)
                make.left.right.bottom.equalToSuperview()
            })
            let announceLabel = UILabel()
            announceLabel.text = "  公告  "
            announceLabel.font = UIFont.boldSystemFont(ofSize: 14)
            announceLabel.textColor = UIColor.red
            announceLabel.layer.borderWidth = 1
            announceLabel.layer.borderColor = UIColor.red.cgColor
            announceLabel.layer.cornerRadius = 5
            announcement.addSubview(announceLabel)
            announceLabel.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.height.equalTo(23)
                make.width.equalTo(43)
                make.centerY.equalToSuperview()
            }
            
            let moreButton = UIButton()
            moreButton.setTitle("更多", for: UIControlState.normal)
            moreButton.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            announcement.addSubview(moreButton)
            moreButton.snp.makeConstraints({ (make) in
                make.right.equalTo(-20)
                make.centerY.equalToSuperview()
                make.top.bottom.equalToSuperview()
                make.width.equalTo(40)
            })
            
            let annonce = UILabel()
            annonce.text = "家享精服为您提供高端保洁服务首单享好礼！"
            annonce.font = UIFont.systemFont(ofSize: 12)
//            annonce.adjustsFontSizeToFitWidth = true
            announcement.addSubview(annonce)
            annonce.snp.makeConstraints { (make) in
                make.left.equalTo(announceLabel.snp.right).offset(15)
                make.right.equalTo(moreButton.snp.left).offset(-15)
                make.height.equalTo(23)
                make.centerY.equalToSuperview()
            }

            self.view.addSubview(scrollView)
            scrollView.backgroundColor = UIColor.white
            scrollView.snp.makeConstraints { (make) in
                make.top.equalTo(bannerView.snp.bottom).offset(20)
                make.bottom.equalToSuperview()
                make.left.right.equalTo(0)
            }
            scrollView.isScrollEnabled = true

            let label = UILabel()
            label.text = "下拉刷新"
            scrollView.addSubview(label)
            label.snp.makeConstraints({ (make) in
                make.top.equalToSuperview().offset(-50)
                make.left.right.equalTo(self.view)
                make.height.equalTo(50)
            })

            //setup service view
            let serviceNum = 12
            let rowHeightperRow = 112
            itemSpacing = (self.view.bounds.width - CGFloat(3 * rowHeightperRow)) / CGFloat(3 + 1)
            let rowSpacing = itemSpacing
            var rowNum = 1
            rowNum = serviceNum > 2 ? 2 : rowNum
            rowNum = serviceNum > 4 ? ((serviceNum - 5) / 3 + 3) : rowNum
            let itemWidth = rowHeightperRow
            scrollView.addSubview(serviceView)
            var currentItem = 1
            for row in 0...rowNum - 1 {
                let serviceRow = UIView()
                serviceView.addSubview(serviceRow)
                serviceRow.snp.makeConstraints({ (make) in
                    if row == 0 {
                        make.top.equalTo(label).offset(50 + itemSpacing)
                        make.left.right.equalToSuperview()
                        make.height.equalTo(rowHeightperRow)
                    } else {
                        make.top.equalTo(serviceView.subviews[row - 1].snp.bottom).offset(rowSpacing)
                        make.left.right.equalToSuperview()
                        make.height.equalTo(rowHeightperRow)
                    }
                })
                let itemofRowNum = row > 1 ? 3 : 2
                if itemofRowNum == 2 {
                    let WiderBlock = UIView()
                    let shorterBlock = UIView()
                    serviceRow.addSubview(WiderBlock)
                    serviceRow.addSubview(shorterBlock)
                    if row == 0 {
                        shorterBlock.snp.makeConstraints({ (make) in
                            make.left.equalTo(itemSpacing)
                            make.top.bottom.equalToSuperview()
                            make.width.equalTo(itemWidth)
                        })
                        WiderBlock.snp.makeConstraints({ (make) in
                            make.left.equalTo(shorterBlock.snp.right).offset(itemSpacing)
                            make.top.bottom.equalToSuperview()
                            make.right.equalToSuperview().offset(-itemSpacing)
                        })
                    } else {
                        shorterBlock.snp.makeConstraints({ (make) in
                            make.right.equalTo(-itemSpacing)
                            make.top.bottom.equalToSuperview()
                            make.width.equalTo(itemWidth)
                        })
                        WiderBlock.snp.makeConstraints({ (make) in
                            make.left.equalToSuperview().offset(itemSpacing)
                            make.top.bottom.equalToSuperview()
                            make.right.equalTo(shorterBlock.snp.left).offset(-itemSpacing)
                        })
                    }
                    
                    let button1 = UIButton()
                    button1.addTarget(nil, action: #selector(serviceBtnTapped), for: UIControlEvents.touchUpInside)
                    shorterBlock.addSubview(button1)
                    button1.layer.cornerRadius = 8
                    button1.backgroundColor = UIColor.lightGray
                    button1.snp.makeConstraints({ (make) in
                        make.edges.equalToSuperview()
                    })
                    
                    let button2 = UIButton()
                    button2.addTarget(nil, action: #selector(serviceBtnTapped), for: UIControlEvents.touchUpInside)
                    WiderBlock.addSubview(button2)
                    button2.layer.cornerRadius = 8
                    button2.backgroundColor = UIColor.lightGray
                    button2.snp.makeConstraints({ (make) in
                        make.edges.equalToSuperview()
                    })
                    
                    currentItem += 2
                } else {
                    for item in 0...itemofRowNum {
                        let serviceBlock = UIView()
                        serviceRow.addSubview(serviceBlock)
                        serviceBlock.snp.makeConstraints({ (make) in
                            if item == 0 {
                                make.left.equalTo(itemSpacing)
                                make.top.bottom.equalToSuperview()
                                make.width.equalTo(itemWidth)
                            } else {
                                make.left.equalTo(serviceRow.subviews[item - 1].snp.right).offset(itemSpacing)
                                make.top.bottom.equalToSuperview()
                                make.width.equalTo(itemWidth)
                            }
                        })
                        
                        let button = UIButton()
                        button.addTarget(nil, action: #selector(serviceBtnTapped), for: UIControlEvents.touchUpInside)
                        serviceBlock.addSubview(button)
                        button.layer.cornerRadius = 8
                        button.backgroundColor = UIColor.lightGray
                        button.snp.makeConstraints({ (make) in
                            make.edges.equalToSuperview()
                        })
                        
                        currentItem += 1
                    }
                }
            }
            serviceView.snp.makeConstraints { (make) in
                make.top.equalTo(label).offset(50)
                make.left.right.equalTo(self.view)
                make.height.equalTo(CGFloat(rowNum * rowHeightperRow) + CGFloat(rowNum + 1) * rowSpacing)
            }

            //setup mall entry view
            scrollView.addSubview(mallEntryView)
            let image = #imageLiteral(resourceName: "商城待开通")
            let heighttoWidthRatio: CGFloat = image.size.height / image.size.width
            mallEntryView.snp.makeConstraints({ (make) in
                make.top.equalTo(serviceView.snp.bottom)
                make.left.equalTo(self.view).offset(itemSpacing)
                make.right.equalTo(self.view).offset(-itemSpacing)
                make.height.equalTo(CGFloat(self.view.bounds.width * heighttoWidthRatio) + itemSpacing + 1)
                make.bottom.equalTo(0)
            })
            
            mallEntryButton.setBackgroundImage(image, for: UIControlState.normal)
            mallEntryButton.addTarget(nil, action: #selector(serviceBtnTapped), for: UIControlEvents.touchUpInside)
            mallEntryButton.contentMode = .scaleAspectFill
            mallEntryButton.adjustsImageWhenHighlighted = false
            mallEntryView.addSubview(mallEntryButton)
            mallEntryButton.snp.makeConstraints({ (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(self.view.bounds.width * heighttoWidthRatio)
            })
        }
    }
    override func viewDidLayoutSubviews() {
        guard mallEntryButton.frame.maxY > 0 else {
            super.viewDidLayoutSubviews()
            return
        }
        if mallEntryButton.frame.maxY < self.view.bounds.height - self.tabBarController!.tabBar.bounds.height {
//            self.updateViewConstraints()////
        }
        super.viewDidLayoutSubviews()
    }
    
    override func updateViewConstraints() {
        guard mallEntryButton.frame.maxY > 0 else {
            super.updateViewConstraints()
            return
        }
        if mallEntryButton.frame.maxY < self.view.bounds.height - self.tabBarController!.tabBar.bounds.height {
            let serviceFixedHeight = self.view.bounds.height - self.bannerView.bounds.height - mallEntryButton.bounds.height - itemSpacing
            serviceView.snp.updateConstraints { (make) in
                make.height.equalTo(serviceFixedHeight)
            }
        }
        
        super.updateViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func serviceBtnTapped() {
        let controller = ServiceListViewController()
        self.navigationController?.pushViewController(controller, animated: true)
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
