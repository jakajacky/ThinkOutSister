//
//  EssenceTableViewController.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/20.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher
import MJRefresh

class EssenceTableViewController: UITableViewController {
 
  var channelName:String!
  var channelUrl:String!
  var dataArray:JSON!
  
  // 加载数据
  var newsArray:[NSDictionary]! {
    get {
      var arr = NSArray()
      
      let queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT)
      
      dispatch_async(queue) {
        Alamofire.request(.GET, "http://api.budejie.com/api/api_open.php", parameters: ["a":"newlist", "c":"data", "type":1]).responseJSON() { response in
          
          let json = JSON(response.result.value!)
          
          arr = json["list"].arrayObject!
          self.dataArray! = json["list"]
          DRLog(arr)
          dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
          })
          
        }
      }
      
      return arr as! [NSDictionary]
    }
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  convenience init() {
    var nibNameOrNil = String?("EssenceTableViewController")
    if NSBundle.mainBundle().pathForResource(nibNameOrNil, ofType: "xib") == nil {
      nibNameOrNil = nil
    }
    self.init(nibName: nibNameOrNil, bundle:nil)
    
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.tableView.registerNib(UINib.init(nibName: "EssenceCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")

      self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(EssenceTableViewController.headerRefresh))
      
      self.dataArray = JSON.init([])
      self.newsArray
    }

  func headerRefresh() -> Void {
    DRLog("adfdfaf")
    self.tableView.mj_header.endRefreshing()
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as! EssenceCell
      let dic = self.dataArray[indexPath.row]
      let visiableRows = tableView.indexPathsForVisibleRows!
      if visiableRows.contains(indexPath) {
        
      }
      cell.news = NewsModels.init(dic: dic)

      return cell
    }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let dic = self.dataArray[indexPath.row]
    let news = NewsModels.init(dic: dic)
    return news.cellHeight
  }
  
}
