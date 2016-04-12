//
//  DRTabBarController.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/12.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class DRTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      self.addChildViewControllers()

      let newTabBar = DRTabBar(frame: tabBar.bounds)
      setValue(newTabBar, forKey: "tabBar")
      
//      self.selectedViewController = self.childViewControllers[3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  // MARK: - private method
  //添加所有子控制器
  func addChildViewControllers() {
    
    setChildrenController("精华", image: UIImage.init(named: "tabBar_essence_icon")!, selectedImage: UIImage.init(named: "tabBar_essence_click_icon")!,controller: EssenceViewController.init())
    
    setChildrenController("最新", image: UIImage.init(named: "tabBar_new_icon")!, selectedImage: UIImage.init(named: "tabBar_new_click_icon")!,controller: NewstViewController.init())
    
    setChildrenController("关注", image: UIImage.init(named: "tabBar_friendTrends_icon")!, selectedImage: UIImage.init(named: "tabBar_friendTrends_click_icon")!,controller: FriendTrendViewController.init())
    
    setChildrenController("我", image: UIImage.init(named: "tabBar_me_icon")!, selectedImage: UIImage.init(named: "tabBar_me_click_icon")!,controller: MineViewController.init(style:.Grouped))
    
  }
  // 添加一个子控制器
  private func setChildrenController(title:String, image:UIImage, selectedImage:UIImage, controller:UIViewController) {
    controller.tabBarItem.title = title
    controller.tabBarItem.image = image
    controller.tabBarItem.selectedImage = selectedImage
    
    let navicontroller = UINavigationController.init(rootViewController: controller)
    addChildViewController(navicontroller)
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
