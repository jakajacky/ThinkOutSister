//
//  DRChannelLabel.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/15.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//  自定义可变换文字颜色、文字可缩放的Label

import UIKit

class DRChannelLabel: UILabel {

  // 计算属性
  var scale:CGFloat = 0.0 {
    didSet {
      self.textColor = UIColor(red: scale, green: 0, blue: 0, alpha: 1)
      let s:CGFloat  = 1 + scale * CGFloat(0.3)
      self.transform = CGAffineTransformMakeScale(s, s)
    }
  }

}
