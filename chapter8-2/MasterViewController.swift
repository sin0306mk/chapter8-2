//
//  MasterViewController.swift
//  chapter8-2
//
//  Created by SMB開発部 on 2014/11/19.
//  Copyright (c) 2014年 Sorimachi,corp. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var jsonArray = NSArray()
    
//    var jsonDictionary = NSDictionary()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        
        self.refreshControl?.addTarget(self, action: "pullToRefresh", forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl!)
        
        //self.refreshControl = UIRefreshControl()
    }
    
    func pullToRefresh(){
        //タイトルをつける
        self.refreshControl?.attributedTitle = NSAttributedString(string: "読み込み中です....")
        self.title = "取引データ一覧"
        
        var url = NSURL(string: "http://webfproject.azurewebsites.net/api/Torihiki?guid=90f21339-cf54-4691-a4cf-92b22af26526&maxday=2014-11-26&minday=2013-10-26")
        var request = NSURLRequest(URL: url!)
        var jsondata = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        jsonArray = NSJSONSerialization.JSONObjectWithData(jsondata!, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
        println(String(jsonArray.count))
        
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {

            if let indexPath = self.tableView.indexPathForSelectedRow(){
                
                let dataget: NSDictionary = jsonArray[indexPath.row] as NSDictionary
                let setObj:DataTorhikiModel = DataTorhikiModel()
                //クラス変数にセット
                setObj.bikou = dataget.objectForKey("bikou") as? String
                setObj.dayTime = dataget.objectForKey("dayTime") as? String
                
                setObj.torihikiName = dataget.objectForKey("torihikiName") as? String
                setObj.inMoney = dataget.objectForKey("inMoney") as? String
                setObj.outMoney = dataget.objectForKey("outMoney") as? String
                
                let controller = segue.destinationViewController as DetailViewController
                controller.detailItem = setObj
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let dataget: NSDictionary = jsonArray[indexPath.row] as NSDictionary
        let dayTime:String = dataget.objectForKey("dayTime") as String
        let torihikiName:String = dataget.objectForKey("torihikiName") as String
        
        var myStr = dayTime + " : " + torihikiName
        cell.textLabel.text = myStr
        
        if (torihikiName == "支払") {
            cell.textLabel.textColor = UIColor.redColor()
        } else {
            cell.textLabel.textColor = UIColor.blackColor()
        }
        return cell
    }
}

