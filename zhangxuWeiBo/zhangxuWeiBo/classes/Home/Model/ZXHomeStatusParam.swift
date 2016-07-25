//
//  ZXHomeStatusParam.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/15.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXHomeStatusParam: NSObject {
    
    // 授权标记,必传参数
    var access_token : String?;
    // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博）
    var since_id : NSNumber?;
    // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0
    var max_id : NSNumber?;
    
    
    
    // 获取参数
    class func param() -> AnyObject? {
        
        let param = ZXHomeStatusParam();
        param.access_token = ZXAccountManager.account()?.access_token;
        
        return param;
    }

}
