//
//  EssenceCell.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/27.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

class EssenceCell: UITableViewCell {

  @IBOutlet var icon: UIImageView!
  
  @IBOutlet var name: UILabel!
  
  @IBOutlet var createTime: UILabel!
  
  @IBOutlet var isVip: UIImageView!
  
  @IBOutlet var textL: UILabel!
  
  @IBOutlet var hotCommentView: UIView!
  
  @IBOutlet var hotCommentL: UILabel!
  
  @IBOutlet var hotComment: UILabel!
  
  @IBOutlet var dingBtn: UIButton!
  
  @IBOutlet var caiBtn: UIButton!
  
  @IBOutlet var shareBtn: UIButton!
  
  @IBOutlet var commentBtn: UIButton!
  
  /**  中间的图片  */
  let pictureView = EssencePictureCell.essencePictureCell()
  /**  音频  */
//  let voiceView = TopicVoiceView.voiceView()
  /**  视频  */
//  let videoView = TopicVideoView.videoView()
  
  
  //
   class func essenceCell() -> EssenceCell{
    return NSBundle.mainBundle().loadNibNamed("EssenceCell", owner: nil, options: nil)[0] as! EssenceCell
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      let bgView = UIImageView.init(image: UIImage.init(named: "mainCellBackground"))
      backgroundView = bgView
    }

 // 为cell赋值
  var news:NewsModels? {
    didSet {

      DRLog("__\(news)")
//      let dic = self.dataArray[indexPath.row] as! NSDictionary
      self.icon!.kf_setImageWithURL(NSURL(string: news!.profile_image)!)
      self.textL.text! = news!.text
      self.name.text! = news!.name
      self.createTime.text! = (news?.create_time)!
      self.dingBtn.setTitle("\((news?.ding)!)", forState: UIControlState.Normal)
      self.caiBtn.setTitle("\((news?.cai)!)", forState: UIControlState.Normal)
      self.shareBtn.setTitle("\((news?.repost)!)", forState: UIControlState.Normal)
      self.commentBtn.setTitle("\((news?.comment)!)", forState: UIControlState.Normal)
      self.selectionStyle = UITableViewCellSelectionStyle.Default
    
      // 中间多媒体
      if news!.width != 0 {
        
        let maxSize = CGSizeMake(UIScreen.mainScreen().bounds.width - 30,CGFloat(MAXFLOAT))
        let textH = self.textL.text!.boundingRectWithSize(maxSize, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(17)], context: nil).size.height
        
        DRLog("-----\(news!.width)")
//        self.pictureView.frame = CGRectMake(margin, 65 + textH, maxSize.width, news!.height * (maxSize.width / news!.width))
        self.pictureView.frame = news!.pictureFrame
        self.pictureView.backgroundColor = UIColor.brownColor()
        self.pictureView.rect = news!.pictureFrame
        self.pictureView.imageURL = news!.large_image
        self.addSubview(self.pictureView)
      }
      
      // 最热评论
      if let comment:Comment = news!.top_cmt {
        let user = comment.user!
        
        self.hotCommentView!.hidden = false
        let str = String.init(format: "%@:%@", user.username ,comment.content)
        self.hotComment.text = str
      }
      else {
        self.hotCommentView!.hidden = true
      }
      
      // vip
      if news!.sina_v {
        self.isVip.hidden = false
      }
      else {
        self.isVip.hidden = true
      }
    }
  }
    
}
