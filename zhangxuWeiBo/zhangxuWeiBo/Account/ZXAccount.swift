//
//  ZXAccount.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import Foundation

class ZXAccount: NSObject , NSCoding {
    
    var access_token : String?;
    var expires_in : NSNumber?;
    var expires_time : NSDate?;
    var remind_in : NSNumber?;
    var uid : NSNumber?;
    var name : String?;
    
    
    override init() {
        
        super.init();
    }
    
    // 将字典转化为账户模型
    func accountWithDic(dic : NSDictionary?) -> AnyObject {
        
        // 创建一个账户
        let account = self;
        account.access_token = dic!["access_token"] as? String;
        account.uid = dic!["uid"] as? NSNumber;
        account.remind_in = dic!["remind_in"] as? NSNumber;
        account.expires_in = dic!["expires_in"] as? NSNumber;
        // 获得当前时间
        let now = NSDate();
        // 计算出过期时间
        account.expires_time = now.dateByAddingTimeInterval(((account.expires_in)?.doubleValue)!);
        
        return account;

    }
    
    // 归档
    func encodeWithCoder(aCoder: NSCoder) {
       
        aCoder.encodeObject(access_token, forKey: "access_token");
        aCoder.encodeObject(remind_in, forKey: "remind_in");
        aCoder.encodeObject(expires_in, forKey: "expires_in");
        aCoder.encodeObject(uid, forKey: "uid");
        aCoder.encodeObject(name, forKey: "name");
        aCoder.encodeObject(expires_time, forKey: "expires_time");
    
    }
    
    // 解档
    required init?(coder aDecoder: NSCoder) {
        
        self.access_token = aDecoder.decodeObjectForKey("access_token") as?String;
        print(access_token);
        self.remind_in = aDecoder.decodeObjectForKey("remind_in") as? NSNumber;
        self.expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber;
        self.uid = aDecoder.decodeObjectForKey("uid") as? NSNumber;
        self.name = aDecoder.decodeObjectForKey("name") as? String;
        self.expires_time = aDecoder.decodeObjectForKey("expires_time") as? NSDate;
    
    }

}
