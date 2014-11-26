//
//  DetailViewController.swift
//  chapter8-2
//
//  Created by SMB開発部 on 2014/11/19.
//  Copyright (c) 2014年 Sorimachi,corp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var bikou: UILabel!
    @IBOutlet weak var dayTime: UILabel!
    @IBOutlet weak var torihikiname: UILabel!
    @IBOutlet weak var inMoney: UILabel!
    @IBOutlet weak var outMoney: UILabel!
    
    var detailItem: DataTorhikiModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: DataTorhikiModel = self.detailItem {
            if let label = self.bikou {
                label.text = detail.bikou
                label.font = UIFont.boldSystemFontOfSize(24)
//                if (detail.torihikiName == "支払"){
//                    label.textColor = UIColor.redColor()
//                } else {
//                    label.textColor = UIColor.blackColor()
//                }
            }
            
            if let label = self.dayTime {
                label.text = "取引日:" + detail.dayTime!
                label.font = UIFont.boldSystemFontOfSize(15)
                label.textColor = UIColor.blackColor()
            }
            
            if let label = self.torihikiname {
                label.text = detail.torihikiName!
                label.font = UIFont.boldSystemFontOfSize(20)
                label.textColor = UIColor.blackColor()
            }
            
            if let label = self.inMoney {
                if (detail.inMoney != nil && detail.inMoney != "" ){
                    label.text = "入金額:" + detail.inMoney!
                    label.textColor = UIColor.blackColor()
                } else if (detail.outMoney != nil && detail.outMoney != "" ){
                    label.text = "出金額:" + detail.outMoney!
                    label.textColor = UIColor.redColor()
                }else {
                    label.text = " "
                }
                label.font = UIFont.boldSystemFontOfSize(15)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

