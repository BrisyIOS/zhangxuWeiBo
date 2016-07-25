//
//  ZXUser.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/15.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXUser: NSObject {
    // 用户id
    var idstr : String?;
    // 用户名
    var name : String?;
    // 用户头像
    var profile_image_url : String?;
    // 会员等级
    var mbrank : NSNumber?;
    // 会员类型
    var mbtype : NSNumber?;
    
    // 是否VIP
    func isVIP() -> Bool? {
        
        return self.mbtype?.floatValue > 2;
    }
    

}
