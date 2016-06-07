//
//  Common.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/28.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit

//cell中text的Y值
let topicCellTextY:CGFloat = 55
//cell  的间距
let margin:CGFloat = 10
//cell 底部按钮的高度
let cellBottomBtnH:CGFloat = 35
//cell 最热评论的高度
let hotCommentTitleH:CGFloat = 20
// 图片的最大高度
let cellPictureMaxImageH:CGFloat = 1000
// 超过最大高度时候 设置的高度
let cellPictureModifiedH:CGFloat = 250
// 屏幕宽度
let screenW = UIScreen.mainScreen().bounds.width
// 屏幕高度
let screenH = UIScreen.mainScreen().bounds.height

/** UIView的frame属性扩展   */
extension UIView {
  var x:CGFloat{
    get{
      return self.frame.origin.x
    }
    set{
      self.frame.origin.x = newValue
    }
  }
  
  var y:CGFloat{
    get{
      return self.frame.origin.y
    }
    set{
      self.frame.origin.y = newValue
    }
  }
  
  var centerX:CGFloat{
    get{
      return self.frame.midX
    }
    set{
      self.frame.origin.x = newValue - self.frame.size.width * 0.5
    }
  }
  
  var centerY:CGFloat{
    get{
      return self.frame.midY
    }
    set{
      self.frame.origin.y = newValue - self.frame.size.height * 0.5
    }
  }
  
  var width:CGFloat{
    get{
      return self.frame.size.width
    }
    set{
      self.frame.size.width = newValue
    }
  }
  
  var height:CGFloat{
    get{
      return self.frame.size.height
    }
    set{
      self.frame.size.height = newValue
    }
  }
  
  var size:CGSize{
    get{
      return self.frame.size
    }
    set{
      self.frame.size = newValue
    }
  }
  
  func isShowingOnKeyWindow() -> Bool{
    let window = UIApplication.sharedApplication().keyWindow
    
    let newFrame = self.superview!.convertRect(self.frame, toView: window)
    let intersects = CGRectIntersectsRect(newFrame, (window?.frame)!)
    
    return !self.hidden && self.alpha > 0.01 && intersects
  }
}

class Common: NSObject {

  
  
}
