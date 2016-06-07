//
//  NewsModels.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/15.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit
import SwiftyJSON

// MARK: - 频道使用的模型
struct ChannelModel {
  var channelName: String
  var channelUrl : String
}

struct ChannelBox {
  var channels:[ChannelModel]
  
  init() {
    let path  = NSBundle.mainBundle().pathForResource("channels.plist", ofType: nil)!
    let array = NSArray(contentsOfFile: path)
    
    channels = [] // 这个数组声明为什么不能用NSArray
    for dic in array! {
      let channelName = dic["tname"] as? String
      let channelUrl  = dic["url"] as? String
      
      let channelModel = ChannelModel(channelName: channelName!, channelUrl: channelUrl!)
      channels.append(channelModel)
    }
  }
  
  // swift中自定义下标
  subscript (index:Int) -> ChannelModel {
    get {
      return channels[index]
    }
  }
  
  
}


/**
 帖子类型
 */
enum NewsType:Int {
  case All = 1
  case Video = 41
  case Sound = 31
  case Picture = 10
  case Word = 29
}

class NewsModels: NSObject {
  /**  id  */
  var id = ""
  /**  名称  */
  var name = ""
  /**  头像  */
  var profile_image = ""
  /**  发帖时间  */
  var create_time = ""
  /**  文字内容  */
  var text = ""
  /**  顶的数量  */
  var ding = 0
  /**  踩的数量  */
  var cai = 0
  /**  转发的数量  */
  var repost = 0
  /**  评论的数量  */
  var comment = 0
  /**  是否为新浪加V用户  */
  var sina_v = false
  /**  图片的宽度  */
  var width:CGFloat = 0
  /**  图片的高度  */
  var height:CGFloat = 0
  /**  帖子的类型  */
  var type:NewsType = .All
  /**  图片的url  */
  var small_image = ""
  var large_image = ""
  var middle_image = ""
  /**  播放人数  */
  var playcount = 0
  /**  音频时长  */
  var voicetime = 0
  /**  视频时长  */
  var videotime = 0
  /**  最热评论  */
  var top_cmt:Comment?
  
  /**  cell 行高*/
  var cellHeight:CGFloat = 0
  /**  中间图片的frame（包括视频音频）  */
  var pictureFrame = CGRectZero
  /**  是否大图  */
  var isBigImage = false
  /**  图片下载进度  */
  var imageProgress:CGFloat = 0
  
  init(dic:JSON) {
    super.init()
    
    self.id = dic["id"].stringValue
    self.name = dic["name"].stringValue
    self.profile_image = dic["profile_image"].stringValue
    self.create_time = dic["create_time"].stringValue
    self.text = dic["text"].stringValue
    self.ding = dic["ding"].intValue
    self.repost = dic["repost"].intValue
    self.cai = dic["cai"].intValue
    self.comment = dic["comment"].intValue
    self.sina_v = dic["sina_v"].boolValue
//    if (dic["sina_v"] != nil) {
//      self.sina_v = true
//    }
//    else {
//      self.sina_v = false
//    }
    self.width = CGFloat(dic["width"].intValue)
    self.height = CGFloat(dic["height"].intValue)
    self.small_image = dic["image0"].stringValue
    self.large_image = dic["image1"].stringValue
    self.middle_image = dic["image2"].stringValue
    self.type = NewsType(rawValue: dic["type"].intValue)!
//    self.playcount = (dic["playcount"] as? Int)!
//    self.voicetime = (dic["voicetime"] as? Int)!
//    self.videotime = (dic["videotime"] as? Int)!
    
    let di = dic["top_cmt"]
    if !di.isEmpty {
      self.top_cmt =  Comment(dic: di[0])
    }
    
    let topic = self.text as NSString
    let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.width - 20,CGFloat(MAXFLOAT))
    let textH = topic.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(17)], context: nil).size.height
    
    // 只有文字时的高度
    self.cellHeight = textH + topicCellTextY + 2 * margin + cellBottomBtnH
    
    // 图片的宽度和高度 （包括视频和音频）
    let width = maxSize.width
    var height = self.height * width / self.width
    let top = topicCellTextY  + textH + margin
    
    // 不只有文字时的高度
    if self.type != .Word {
      if  self.type == .Picture {
        // 当为图片 并且高度太高时
        if height > cellPictureMaxImageH {
          height = cellPictureModifiedH
          self.isBigImage = true
        }
      }
      // 计算图片的frame
      self.pictureFrame = CGRectMake(margin, top, width, height)
      self.cellHeight += height + margin
    }
    
    // 最热评论
    if let comment = self.top_cmt{
      let str = NSString.init(format: "%@:%@", comment.user!.username,comment.content) as String
      let commentH = str.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(15)], context: nil).size.height
      self.cellHeight += hotCommentTitleH + commentH + margin
    }
  }
}
