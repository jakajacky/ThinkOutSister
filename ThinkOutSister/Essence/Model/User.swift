//
//  User.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/28.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
  /**  用户  */
  var username = ""
  /**  性别  */
  var sex = ""
  /**  头像 */
  var profile_image = ""
  
  init(dic:JSON) {
    super.init()
    
    self.username = dic["username"].stringValue
    self.sex = dic["sex"].stringValue
    self.profile_image = dic["profile_image"].stringValue
  }
  
  
  
}
