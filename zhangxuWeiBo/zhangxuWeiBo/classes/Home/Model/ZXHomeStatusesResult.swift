//
//  ZXHomeStatusesResult.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/19.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXHomeStatusesResult: NSObject {
    
    var statuses : NSArray?;
    var total_number : NSNumber?;
    
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["statuses" : ZXStatus.self];
    }
    

}
