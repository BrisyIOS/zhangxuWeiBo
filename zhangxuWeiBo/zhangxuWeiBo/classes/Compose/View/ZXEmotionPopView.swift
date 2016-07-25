//
//  ZXEmotionPopView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionPopView: UIView {
    
    private var emotionView : ZXEmotionView?;
    
//    class func popView() -> AnyObject? {
//        
//        
//    }
    
    func showFromEmotionView(emotionView : ZXEmotionView?) -> Void {
        
        if emotionView == nil {
            
            return;
        }
        
        // 显示表情
        self.emotionView?.emotion = emotionView?.emotion;
        // 添加到窗口上
        let window = UIApplication.sharedApplication().windows.last;
        window?.addSubview(self);
        // 设置位置
        let centerX = emotionView?.center.x;
        let centerY = (emotionView?.center.y)! - self.frame.size.height * 0.5;
        let center = CGPointMake(centerX!, centerY);
        self.center = (window?.convertPoint(center, fromWindow: emotionView?.superview as? UIWindow))!;

        
    }
    
    
    func dismiss() -> Void {
        
        removeFromSuperview();
    }
    
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect);
        UIImage(named: "emoticon_keyboard_magnifier")?.drawInRect(rect);
    }

}
