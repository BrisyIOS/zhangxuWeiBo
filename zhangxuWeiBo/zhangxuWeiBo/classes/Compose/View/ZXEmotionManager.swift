//
//  ZXEmotionManager.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import Foundation

let kRecentFilepath = (kDocumentPath as NSString).stringByAppendingPathComponent("recent_emotions.data");

class ZXEmotionManager: NSObject {
    
    static var _defaultEmotions : NSMutableArray?;
    static var _emojiEmotions : NSMutableArray?;
    static var _lxhEmotions : NSMutableArray?;
    static var _recentEmotions : NSMutableArray?;
    
    //  默认表情
    class func defaultEmotions() -> NSMutableArray? {
        
        if _defaultEmotions == nil {
            
            let plist = NSBundle.mainBundle().pathForResource("Resource.bundle/EmotionIcons/default/info.plist", ofType: nil);
            // 根据文件路径将plist文件转化成模型数组
            _defaultEmotions = ZXEmotion.mj_objectArrayWithFile(plist);
           
            for emotion in _defaultEmotions! {
                
                let emotion = emotion as? ZXEmotion;
                
                emotion?.directory = NSBundle.mainBundle().pathForResource("Resource.bundle/EmotionIcons/default", ofType: nil);
               
            }
            
        }
        
        return _defaultEmotions;

    }
    
    
    // emoji表情
    class func emojiEmotions() -> NSMutableArray? {
        
        if _emojiEmotions == nil {
            
            let plist = NSBundle.mainBundle().pathForResource("Resource.bundle/EmotionIcons/emoji/info.plist", ofType: nil);
            _emojiEmotions = ZXEmotion.mj_objectArrayWithFile(plist);
            
            for emotion in _emojiEmotions! {
                
                let emotion = emotion as? ZXEmotion;
                emotion?.directory = NSBundle.mainBundle().pathForResource("Resource.bundle/EmotionIcons/emoji", ofType: nil);
                
            }
        }
        
        return _emojiEmotions;
    }
    
    // 浪小花表情
    class func lxhEmotions() -> NSMutableArray? {
        
        if _lxhEmotions == nil {
            
            let plist = NSBundle.mainBundle().pathForResource("Resource.bundle/EmotionIcons/lxh/info.plist", ofType: nil);
            _lxhEmotions = ZXEmotion.mj_objectArrayWithFile(plist);
           
            for emotion in _lxhEmotions! {
                
                let emotion = emotion as? ZXEmotion;
                emotion?.directory = NSBundle.mainBundle().pathForResource("Resource.bundle/EmotionIcons/lxh", ofType: nil);
        
            }
        }
        
        return _lxhEmotions;
    }
   
    
    // 最近表情
    class func recentEmotions() -> NSMutableArray? {
        
        if _recentEmotions == nil {
            
            // 去沙盒中加载最近使用的表情数据
            _recentEmotions = NSKeyedUnarchiver.unarchiveObjectWithFile(kRecentFilepath) as? NSMutableArray;
            
            if _recentEmotions == nil {
                
                // 说明沙盒中没有数据
                _recentEmotions = NSMutableArray();
                
            }
        }
        
        return _recentEmotions;
        
    }
   
    
    
    // 保存最近使用的表情
    class func addRecentEmotion(emotion : ZXEmotion?) -> Void {
        
        // 加载最近的表情数据
        recentEmotions();
        
        // 删除之前的表情
        _recentEmotions?.removeObject(emotion!);
        
        // 添加最新的表情
        _recentEmotions?.insertObject(emotion!, atIndex: 0);
        
        // 存储到沙盒中
        NSKeyedArchiver.archiveRootObject(_recentEmotions!, toFile: kRecentFilepath);

        
    }
    
    // 根据表情的文字描述找出对应的表情对象
    class func emotionWithDesc(desc : String?) -> ZXEmotion? {
        
        
        var foundEmotion : ZXEmotion?;
        // 从默认表情中找
        for emotion in defaultEmotions()! {
            
            let emotion = emotion as? ZXEmotion;
            
            if desc == emotion?.chs || desc == emotion?.cht  {
                
                foundEmotion = emotion;
                
                break;
            }
        }

        if foundEmotion != nil {
            
            return foundEmotion;
        }
        
        // 从浪小花表情中查找
        for lxhEmotion in lxhEmotions()! {
            
            let lxhEmotion = lxhEmotion as? ZXEmotion;
            if desc == lxhEmotion?.chs || desc == lxhEmotion?.cht {
                
                foundEmotion = lxhEmotion;
                break;
            }
        }
        
        return foundEmotion;
    }

}
