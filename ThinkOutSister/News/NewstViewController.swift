//
//  NewstViewController.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/12.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class NewstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      self.view.backgroundColor = UIColor.whiteColor()
      // 设置navigationBar的标题view
      navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
      
      // 自定义leftBarButtonItem：
      
      // 1、自定义视图
      let button = UIButton(type: UIButtonType.Custom);
      button.frame = CGRectMake(0, 0, 32, 32)
      button.addTarget(self, action: "leftMenuBtnClicked:", forControlEvents: UIControlEvents.TouchUpInside)
      button.setImage(UIImage(named: "MainTagSubIcon"), forState: UIControlState.Normal)
      button.setImage(UIImage(named: "MainTagSubIconClick"), forState: UIControlState.Highlighted)
      
      // 2、创建UIBarButtonItem
      let item = UIBarButtonItem(customView: button)
      
      // 3、设置leftBarButtonItem
      navigationItem.setLeftBarButtonItem(item, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
