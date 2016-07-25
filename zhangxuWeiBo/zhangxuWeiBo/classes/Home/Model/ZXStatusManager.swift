//
//  ZXStatusManager.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXStatusManager: NSObject {
    
    // 加载首页数据
    class func homeStatusesWithParam(param : ZXHomeStatusParam? , success : ((ZXHomeStatusesResult) -> Void)? , failure : ((NSError) -> Void)?) -> Void {
        
        
        HttpManager.shareInstance.request(RequestType.GET, urlString: "https://api.weibo.com/2/statuses/home_timeline.json", parameters: param?.mj_keyValues()) { (result, error) in
            
            if error != nil {
                
                print(error);
                return;
            }
            
            // 获取可选类型中的数据
            guard let result = result else {
                
                return;
            }
            
            let model = ZXHomeStatusesResult.mj_objectWithKeyValues(result);
            
            success!(model);
            let filePath = (kDocumentPath as NSString).stringByAppendingPathComponent("homeStatus");
            result.mj_keyValues().writeToFile(filePath, atomically: true);
            
        }
        
    }
    
    // 发微博
    class func sendStatusWithParam(param : ZXSendStatusParam? , success : ((ZXSendStatusResult) -> Void)? , failure : ((NSError) -> Void)?) -> Void {
        
        HttpManager.shareInstance.request(RequestType.POST, urlString: "https://api.weibo.com/2/statuses/update.json", parameters: param?.mj_keyValues()) { (result, error) in
            
//            let json = try!NSJSONSerialization.JSONObjectWithData(data as! NSData, options: NSJSONReadingOptions.MutableContainers) as?NSDictionary;
            
            if error != nil {
                
                return;
            }
            
            // 获取可选类型中的数据
            guard let result = result else {
                
                return;
            }
            
            let model = ZXSendStatusResult.mj_objectWithKeyValues(result);
            success!(model);
            
        }
    }

}
