//
//  ZXEmotionKeyboard.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionKeyboard: UIView , ZXEmotionToolbarDelegate {

    
    var listView : ZXEmotionListView?;
    var toolbar : ZXEmotionToolbar?;
    
    
    
    class func keyboard() -> AnyObject? {
    
        let keyboard = ZXEmotionKeyboard.init(frame: CGRectZero);
        return keyboard;
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        backgroundColor = UIColor.init(patternImage: UIImage(named: "emoticon_keyboard_background")!);
        
        // 添加表情列表
        listView = ZXEmotionListView.init(frame: CGRectZero);
        addSubview(listView!);
        
        // 添加表情工具条
        toolbar = ZXEmotionToolbar();
        toolbar?.delegate = self;
        addSubview(toolbar!);

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        // 设置工具条的frame
        let toolbarW = self.frame.size.width;
        let toolbarH = CGFloat(35);
        let toolbarX = CGFloat(0);
        let toolbarY = self.frame.size.height - (self.toolbar?.frame.size.height)!;
        toolbar?.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        
        // 设置表情列表的frame
        let listViewW = self.frame.size.width;
        let listViewH = self.toolbar?.frame.origin.y;
        listView?.frame = CGRectMake(0, 0, listViewW, listViewH!);
   
        
    }
    
    func emotionToolbarDidSelectedButton(toolbar: ZXEmotionToolbar?, emotionType: ZXEmotionType) {
        
        switch emotionType {
            
        case .Default:
            
            self.listView?.emotions = ZXEmotionManager.defaultEmotions();
            
            
        case .Emoji:
            
            self.listView?.emotions = ZXEmotionManager.emojiEmotions();
            
        case .Lxh:
            
            self.listView?.emotions = ZXEmotionManager.lxhEmotions();
        
        default:
            
            self.listView?.emotions = ZXEmotionManager.recentEmotions();
        }

    }

}
