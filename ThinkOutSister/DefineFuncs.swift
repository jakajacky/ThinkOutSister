//
//  DefineFuncs.swift
//  ThinkOutSister
//
//  Created by Xiaoqiang Zhang on 16/4/21.
//  Copyright © 2016年 Xiaoqiang Zhang. All rights reserved.
//

import Foundation

let kPrintLog = 1

//separator: String = default, terminator: String = default
func DRLog(item: Any...) {
  if kPrintLog == 1 {
    print(item.last!)
  }
}