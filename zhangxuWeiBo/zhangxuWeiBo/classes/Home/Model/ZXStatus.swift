//
//  ZXStatus.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/15.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXStatus: NSObject {
    
    // 微博ID
    var idstr : String?;
    // 微博信息内容
    var text : String?;
    // 微博创建时间
    var created_at : String? {
        
        didSet {

            // 获得微博的创建时间
            let formatter = NSDateFormatter();
            formatter.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy";
            formatter.locale = NSLocale(localeIdentifier: "en_US");
            // 将字符串转化成时间对象，方便进行日期处理
            let createdTime = formatter.dateFromString(self.created_at!);
            // 比较当前时间和微博的创建时间
            let components = createdTime?.deltaWithNow();
            // 根据时间差，返回对应的字符串
            if createdTime == nil {
                
                return;
            }
            // 今年
            if createdTime?.isThisYear() == true {
                // 今天
                if createdTime?.isToday() == true {
                    
                    // 至少1小时前发的
                    if components?.hour >= 1 {
                        
                        self.created_at = String(format: "%d小时前" , (components?.hour)!);
                        
                    }
                        // 60分钟以内发的
                    else if components?.minute >= 1 {
                        
                        self.created_at = String(format: "%d分钟前" , (components?.minute)!);
                        
                    }
                        // 刚刚
                    else {
                        
                        self.created_at = "刚刚";
                        
                    }
                }
                    // 昨天
                else if createdTime?.isYesterday() == true {
                    
                    formatter.dateFormat = "昨天 HH:mm";
                    self.created_at = formatter.stringFromDate(createdTime!);
                    
                }
                    // 至少是前天发的
                else {
                    
                    formatter.dateFormat = "MM-dd HH:mm";
                    self.created_at = formatter.stringFromDate(createdTime!);
                    
                }
                
                
            }
                // 非今年
            else {
                
                formatter.dateFormat = "yyyy-MM-dd HH:mm";
                self.created_at = formatter.stringFromDate(createdTime!);
                
            }
        }
        
    };
    
    // 微博来源
    var source : String? {
        
        didSet {
            
            // 截取中间的来源
            let startIndex = self.source?.rangeOfString(">")?.endIndex;
            let endIndex = self.source?.rangeOfString("</")?.startIndex;
            // 防措处理
            if startIndex == nil || endIndex == nil {
                
                return;
            }
            let range = Range(startIndex! ..< endIndex!);
            let subSource = self.source?.substringWithRange(range);
            
            // 拼接"来自"
            self.source = "来自" + subSource!;
           
        }
    };
    
    // 转发数
    var reposts_count : NSNumber?;
    // 评论数
    var comments_count : NSNumber?;
    // 点赞数
    var attitudes_count : NSNumber?;
    // 微博作者
    var user : ZXUser?;
    // 转发微博
    var retweeted_status : ZXStatus?;
    
    // 微博配图
    var pic_urls : NSArray?;
    
    // 数组中存放什么样的模型
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        
        return ["pic_urls" : ZXPhoto.self];
        
    }
   

}
