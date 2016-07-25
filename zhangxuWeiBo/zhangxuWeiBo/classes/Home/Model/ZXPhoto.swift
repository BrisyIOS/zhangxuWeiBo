//
//  ZXPhoto.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/15.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXPhoto: NSObject {
    
    // 缩略图
    var thumbnail_pic : String?;
    // 中等图
    var bmiddle_pic : String? {
        
        get {
            
            return thumbnail_pic?.stringByReplacingOccurrencesOfString("thumbnail", withString: "bmiddle");
            
        }
    };

}
