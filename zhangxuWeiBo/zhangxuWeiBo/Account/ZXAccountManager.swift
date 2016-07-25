//
//  ZXAccountManager.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

let accountPath = (kDocumentPath as NSString).stringByAppendingPathComponent("account.data");

class ZXAccountManager: NSObject {
    

    // 保存账户
    class func saveAccount(account : ZXAccount?) -> Void {
        
        if account != nil {
            
            NSKeyedArchiver.archiveRootObject(account!, toFile: accountPath);
            
        }
        
    }
    
    // 获取账户
    class func account() -> ZXAccount? {
        
        // 判断账号是否过期
        let account = NSKeyedUnarchiver.unarchiveObjectWithFile(accountPath) as? ZXAccount;
        print(account?.access_token);
        // 当前时间
        let now = NSDate();
        // 比较当前时间和账号的过期时间
        if account?.expires_time?.compare(now) == NSComparisonResult.OrderedAscending {
            
            // 过期
            return nil;
        }
        // 没有过期，直接返回
        return account;
        
    }
    
    // 授权获取accessToken
    class func accessTokenWithParam(param : ZXAccessTokenParam? , success: ((ZXAccessTokenResult) -> Void)? , failure : ((NSError) -> Void)?) -> Void {
        
        // post请求
        HttpManager.shareInstance.request(RequestType.POST, urlString: "https://api.weibo.com/oauth2/access_token", parameters: param?.mj_keyValues()) { (result, error) in
            
            if error != nil {
                
                print(error);
                return;
            }
            
            // 获取可选类型中的数据
            guard let result = result else {
                
                return;
            }
            
            let model = ZXAccessTokenResult.mj_objectWithKeyValues(result);
            success!(model);
        }
      
        
    }
}
