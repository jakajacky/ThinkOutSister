//
//  EssencePictureCell.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/28.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit
import DACircularProgress

class EssencePictureCell: UITableViewCell {
  
  @IBOutlet var progressView: DALabeledCircularProgressView!
  
  @IBOutlet var imageC: UIImageView!
  
  var rect: CGRect?
  
  var imageURL:String? {
    didSet {
      self.imageC?.kf_setImageWithURL(NSURL(string: imageURL!)!)
      self.imageC.kf_setImageWithURL(NSURL(string: imageURL!)!,
                                     placeholderImage: nil,
                                     optionsInfo: nil,
        progressBlock: { (receivedSize, totalSize) in
          self.progressView.setProgress(CGFloat(receivedSize) / CGFloat(totalSize), animated: true)
          
          let str = NSString(string: "\((Int(CGFloat(receivedSize) / CGFloat(totalSize) * 100)))%");
          str.stringByReplacingOccurrencesOfString("-", withString: "")
          self.progressView.progressLabel.text = str as String
        }) { (image, error, cacheType, imageURL) in
          if image != nil {
            self.progressView.hidden = true
            self.imageView?.userInteractionEnabled = true
            
            // 为了让大图的顶部显示到上边
            UIGraphicsBeginImageContextWithOptions(self.rect!.size, true, 0.0);
            
            let width = self.rect!.size.width
            let height = width * (image?.size.height)! / (image?.size.width)!
            image?.drawInRect(CGRect(x: 0, y: 0, width: width, height: height))
            
            self.imageC!.image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
          }
      }
    }
  }
  
  class func essencePictureCell() -> EssencePictureCell{
    return NSBundle.mainBundle().loadNibNamed("EssencePictureCell", owner: nil, options: nil)[0] as! EssencePictureCell
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
      self.progressView.progressLabel.textColor = UIColor.whiteColor()
      self.progressView.roundedCorners = 2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
