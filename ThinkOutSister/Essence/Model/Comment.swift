//
//  Comment.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/28.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit
import SwiftyJSON

class Comment: NSObject {
  /**  id  */
  var id = ""
  /**  音频文件的时长  */
  var voicetime = 0
  /**  音频文件的路径  */
  var voiceuri:String = ""
  /**  评论的文字内容  */
  var content = ""
  /**  被点赞的数量  */
  var like_count = 0
  /**  用户  */
  var user:User?
  /**  行高  */
  var cellHeight:CGFloat = 0
  
  init(dic:JSON) {
    super.init()
    self.id = dic["id"].stringValue
    self.voicetime = dic["voicetime"].intValue
    self.voiceuri = dic["voiceuri"].stringValue
    self.content = dic["content"].stringValue
    self.like_count = dic["like_count"].intValue
    self.user = User.init(dic: dic["user"])
    
    // 计算最热评论区的高度
    let topic = self.content as NSString
    let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.width - 105, CGFloat(MAXFLOAT))
    let textH = topic.boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(17.0)], context: nil).size.height
    
    self.cellHeight = textH + CGFloat(50)
  }
}
