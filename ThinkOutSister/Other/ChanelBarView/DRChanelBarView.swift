//
//  DRChanelBarView.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/15.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class DRChanelBarView: UIScrollView {

  var channels:ChannelBox                   // 频道数组
  var labelArray:[DRChannelLabel]           // label数组
  var currentChannelsLabel:DRChannelLabel!  // 加！的目的，是不是 不能为空？
  var maxchannelsCount:Int                  // 最大频道数
  var channelCount:Int!                     // 频道数量
  var labelMargin:CGFloat                   // label间距
  
//  var containerView:UIScrollView
  
  override init(frame: CGRect) {
    channels             = ChannelBox()
    labelArray           = []
    currentChannelsLabel = DRChannelLabel()
    maxchannelsCount     = 20
    channelCount         = self.labelArray.count
    labelMargin          = 25
//    containerView = UIScrollView(frame: frame)
    super.init(frame: frame)
  }
  
  convenience init(rect:CGRect) {
    // 计算frame
    self.init(frame:rect)
    
//    channels             = channelss
    labelArray           = []
    currentChannelsLabel = DRChannelLabel()
    maxchannelsCount     = 20
    channelCount         = self.labelArray.count
    labelMargin          = 20
    self.contentSize = CGSizeMake(380, 0)

    self.initSubviews()
    
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  // 创建频道scrollView
  func initSubviews() {
    channelCount = channels.channels.count > maxchannelsCount ? maxchannelsCount : channelCount

    // 计算属性嘛？
    let labelX:([UILabel]) -> CGFloat = {
      (labels: [UILabel]) -> CGFloat in
      
      let lastObj = labels.last
      
      guard let label = lastObj else {
        return self.labelMargin
      }
      return CGRectGetMaxX(label.frame) + self.labelMargin
    }
    
    for i in 0..<channelCount {
      let label = DRChannelLabel()
      label.text = self.channels[i].channelName
      label.textColor = UIColor.blackColor()
      label.font = UIFont.systemFontOfSize(14)
      label.sizeToFit()
      label.frame.origin.x = labelX(self.labelArray)
      label.frame.origin.y = (self.bounds.height - label.bounds.height) * 0.5
      
//      label.backgroundColor = UIColor.greenColor()
      self.labelArray.append(label)
      self.addSubview(label)
      
    }
    self.contentSize = CGSizeMake(labelX(self.labelArray), 0)
  }
  
}
