//
//  DRContainerView.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/20.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class DRContainerView: UIScrollView {

  var channelBar:DRChanelBarView!
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
//    self.backgroundColor = UIColor.blueColor()
  }

  convenience init() {
    self.init(frame:CGRectZero)
    self.channelBar = DRChanelBarView(rect: CGRectZero)
    let channelCount = self.channelBar.labelArray.count
    self.contentSize = CGSizeMake(CGFloat(channelCount) * UIScreen.mainScreen().bounds.width, 0)
    self.pagingEnabled = true
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - 设置vc内容
  func setupContentView(vcs:NSArray) {
    for i in 0..<vcs.count {
      let content = (vcs[i] as! UIViewController).view
      content.frame = CGRectMake(CGFloat(i) * 375, 0, self.frame.size.width, self.frame.size.height)
      self.addSubview(content)
      
    }
  }
  
}
