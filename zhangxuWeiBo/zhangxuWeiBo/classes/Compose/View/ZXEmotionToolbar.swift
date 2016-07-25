//
//  ZXEmotionToolbar.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

let kEmotionToolbarButtonMaxCount = 4;


enum ZXEmotionType : NSInteger {
    
    case Recent = 1000 // 最新
    case Default = 2000// 默认
    case Emoji = 3000// 表情
    case Lxh = 4000// 浪小花
}

protocol ZXEmotionToolbarDelegate : NSObjectProtocol {
    
    func emotionToolbarDidSelectedButton(toolbar : ZXEmotionToolbar? , emotionType : ZXEmotionType);
    
}

class ZXEmotionToolbar: UIView {
    
    weak var delegate : ZXEmotionToolbarDelegate? {
        
        didSet {
            
            // 获得默认按钮
            let defaultButton = viewWithTag(ZXEmotionType.Default.rawValue) as? UIButton;
            // 默认选中默认按钮
            buttonClick(defaultButton);
            
        }
    };
    private var selectedButton : UIButton?;
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 添加4个按钮
        setupButton("最近", tag: ZXEmotionType.Recent);
        setupButton("默认", tag: ZXEmotionType.Default);
        setupButton("Emoji", tag: ZXEmotionType.Emoji);
        setupButton("浪小花", tag: ZXEmotionType.Lxh);

        // 监听表情选中的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(emotionDidSelected(_:)), name: ZXEmotionDidSelectedNotification, object: nil);

        
    }
    
    deinit {
        // 移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    
    func emotionDidSelected(notification : NSNotification?) -> Void {
        
        if self.selectedButton?.tag == ZXEmotionType.Recent.rawValue {
            
            buttonClick(selectedButton);
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupButton(title : String? , tag : ZXEmotionType?) -> Void {
        
        let button = UIButton();
        button.tag = (tag?.rawValue)!;
        
        // 文字
        button.setTitle(title, forState: UIControlState.Normal);
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        button.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Selected);
        button.addTarget(self, action: #selector(buttonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        button.titleLabel?.font = UIFont.systemFontOfSize(13);
        addSubview(button);
        
        // 设置背景图片
        let count = self.subviews.count;
        if count == 1 {
            // 第一个按钮
            button.setBackgroundImage(UIImage(named: "compose_emotion_table_right_normal"), forState: UIControlState.Normal);
        button.setBackgroundImage(UIImage.resizableImage("compose_emotion_table_mid_selected"), forState: UIControlState.Selected);
            
        } else if count == kEmotionToolbarButtonMaxCount {
            
                // 最后一个按钮
            button.setBackgroundImage(UIImage.resizableImage("compose_emotion_table_right_normal"), forState: UIControlState.Normal);
            button.setBackgroundImage(UIImage.resizableImage("compose_emotion_table_right_selected"), forState: UIControlState.Selected);
        } else {
            
            button.setBackgroundImage(UIImage.resizableImage("compose_emotion_table_mid_normal"), forState: UIControlState.Normal);
            button.setBackgroundImage(UIImage.resizableImage("compose_emotion_table_mid_selected"), forState: UIControlState.Selected);
        }
    }
    
    
    func buttonClick(button : UIButton?) -> Void {
        
        // 控制按钮状态
        self.selectedButton?.selected = false;
        button?.selected = true;
        self.selectedButton = button;
    
        // 通知代理
        if delegate != nil {
            
            let emotionType = ZXEmotionType.init(rawValue: (button?.tag)!);
            self.delegate?.emotionToolbarDidSelectedButton(self, emotionType: emotionType!);
        }
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        // 设置工具条按钮的frame
        let buttonW = self.frame.size.width / CGFloat(kEmotionToolbarButtonMaxCount);
        let buttonH = self.frame.size.height;
        for i in 0..<kEmotionToolbarButtonMaxCount {
            
            let button = self.subviews[i] as? UIButton;
            let buttonX = CGFloat(i) * buttonW;
            button?.frame = CGRectMake(buttonX, 0, buttonW, buttonH);
        }
        
    }

}
