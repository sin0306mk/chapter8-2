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
        
        //タイトルをつける
        self.title = "取引データ一覧"
        
        var url = NSURL(string: "http://webfproject.azurewebsites.net/api/Torihiki?guid=90f21339-cf54-4691-a4cf-92b22af26526&maxday=2014-11-26&minday=2013-10-26")
        var request = NSURLRequest(URL: url!)
        var jsondata = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        jsonArray = NSJSONSerialization.JSONObjectWithData(jsondata!, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSArray
        println(String(jsonArray.count))
        
        for dat in jsonArray {
            let dataget: NSDictionary = dat as NSDictionary
            let dataValue:String = dataget.objectForKey("bikou") as String

            println("値=\(dataValue)")
        }
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
                let object:String = dataget.objectForKey("bikou") as String
                
//                let object = jsonArray[indexPath.row] as String
                
                let controller = segue.destinationViewController as DetailViewController
                controller.detailItem = object
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
        let dataValue:String = dataget.objectForKey("dayTime") as String
        
        var myStr = dataValue
        
        cell.textLabel.text = myStr
        return cell
    }
}

