//
//  ViewController.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/11.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class EssenceViewController: UIViewController {
  
  var containerView:DRContainerView!
  
  var channelBar:DRChanelBarView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    // 设置navigationBar的标题view
    navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
    
    // 自定义leftBarButtonItem：
    
    // 1、自定义视图
    let button = UIButton(type: UIButtonType.Custom);
    button.frame = CGRectMake(0, 0, 32, 32)
    button.addTarget(self, action: #selector(EssenceViewController.leftMenuBtnClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    button.setImage(UIImage(named: "MainTagSubIcon"), forState: UIControlState.Normal)
    button.setImage(UIImage(named: "MainTagSubIconClick"), forState: UIControlState.Highlighted)
    
    // 2、创建UIBarButtonItem
    let item = UIBarButtonItem(customView: button)

    // 3、设置leftBarButtonItem
    navigationItem.setLeftBarButtonItem(item, animated: true)
    
    // 让本控制器自动适应navigationbar的64高度
    self.edgesForExtendedLayout = UIRectEdge.None
//    self.navigationController?.navigationBar.translucent = false
    
//    self.tabBarController?.tabBar.translucent = false
//    self.automaticallyAdjustsScrollViewInsets = false
    self.tabBarController?.tabBar.backgroundColor = UIColor.whiteColor()
    
    // 子视图
    self.initSubviews()

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  func leftMenuBtnClicked(sender:UIBarButtonItem) {
    // 弹出订阅菜单
  }
  
  // MARK: - 创建视图
  func initSubviews() {
    // 频道滑动视图
    channelBar = DRChanelBarView(rect: CGRectMake(0, 0, self.view.frame.size.width, 40))
//    channelBar.backgroundColor = UIColor.redColor()
    channelBar.currentChannelsLabel = channelBar.labelArray[0]
    channelBar.currentChannelsLabel.scale = 1
    self.view.addSubview(channelBar)
    
    // 内容视图
    containerView = DRContainerView()
    containerView.frame = CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 160)
    containerView.delegate = self
    self.view.addSubview(containerView)
    
    // 添加内容
    self.initChildViewController(channelBar.labelArray.count)
    
    channelBar.scrollsToTop = false
    containerView.scrollsToTop = false
  }
  
  func initChildViewController(count:Int) {
    let arr = NSMutableArray(capacity: count)
    for i in 0..<count {
      let vc = EssenceTableViewController()
      if i == 0 {
        vc.tableView.scrollsToTop = true
      }
      else {
        vc.tableView.scrollsToTop = false
      }
      
      self.addChildViewController(vc)
      arr.addObject(vc)
//      DRLog("\(i)")
    }
      containerView.setupContentView(arr)
  }
  
}

extension EssenceViewController: UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    self.scrollViewDidEndScrollingAnimation(scrollView)
  }
//
//  func scrollViewDidZoom(scrollView: UIScrollView) {
//    DRLog("didzoom\(scrollView.contentOffset)")
//  }
//  
//  func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//    DRLog("WillBeginDecelerating\(scrollView.contentOffset)")
//  }
//  
//  func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
//    DRLog("DidEndScrolling\(scrollView.contentOffset)")
//  }
//  
//  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//    DRLog("WillBeginDragging\(scrollView.contentOffset)")
//  }
  
  /**
   每次滑动newsContainerView都会持续调用，用来制造频道label的动画效果
   */
  func scrollViewDidScroll(scrollView: UIScrollView) {
    let currentIndex = scrollView.contentOffset.x / scrollView.bounds.width
    let leftIndex = Int(currentIndex)
    let rightIndex = leftIndex + 1
    guard currentIndex > 0 && rightIndex < self.channelBar.labelArray.count else {
      return
    }
    
//    DRLog("didScroll\(currentIndex)")
    
    let rightScale = currentIndex - CGFloat(leftIndex)
    let leftScale = CGFloat(rightIndex) - currentIndex
    
    let rightLabel = self.channelBar.labelArray[rightIndex]
    let leftLabel = self.channelBar.labelArray[leftIndex]
    
    rightLabel.scale = rightScale
    leftLabel.scale = leftScale
  }
  
  /**
   这个是当用户用代码导致滚动时候调用列如setContentOffset，用来切换需要显示的新闻列表和让频道标签处于合适的位置
   */
  func scrollViewDidEndScrollingAnimation(scrollView:UIScrollView) {
    let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    
    // 让频道处于合适的位置
    let currentLabel = self.channelBar.labelArray[index]
    self.channelBar.currentChannelsLabel = currentLabel
    var offsetX = currentLabel.center.x - self.channelBar.bounds.width * 0.5
    let maxOffset = self.channelBar.contentSize.width - self.channelBar.bounds.width
    if offsetX > 0{
      offsetX = offsetX > maxOffset ? maxOffset : offsetX
    }else {
      offsetX = 0
    }
    let offset = CGPointMake(offsetX, 0)
    DRLog("\(offset)")
    self.channelBar.setContentOffset(offset, animated: true)
    
    // 切换需要显示的控制器
    self.performSelector(#selector(loadData(_:)), withObject: index, afterDelay: 0.5)
    
    
  }
  
  func loadData(obj:AnyObject) -> Void {
    let index = obj.integerValue
    print("test\(index)")
    let vc = self.childViewControllers[index] as! EssenceTableViewController
    vc.newsArray
  }
  
}
