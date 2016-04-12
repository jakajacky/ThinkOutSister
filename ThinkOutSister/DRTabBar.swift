//
//  DRTabBar.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/12.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class DRTabBar: UITabBar {

  override init(frame: CGRect) {
    super.init(frame: frame)
    // 设置选中tabBarItem的文字颜色
    self.tintColor = UIColor(red: 49 / 255.0, green: 53 / 255.0, blue: 55 / 255.0, alpha: 1)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {

    let width = frame.width * 0.2
    var buttonIndex:CGFloat = 0

    for item in subviews {
      item.frame = CGRect(x: width * (buttonIndex > 1 ? buttonIndex + 1 : buttonIndex), y: 0, width: width, height: item.frame.height)
      
      buttonIndex++
    }
  }
  
  
}
