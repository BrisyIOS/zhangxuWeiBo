//
//  ZXEmotionView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionView: UIButton {

    
    var emotion : ZXEmotion? {
        
        didSet {
            
            if ((emotion?.code) != nil) {
                
                // 取消动画效果
                UIView.setAnimationsEnabled(false);
                // 设置emoji表情
                titleLabel?.font = UIFont.systemFontOfSize(32);
                setTitle(emotion?.emoji, forState: UIControlState.Normal);
                setImage(nil, forState: UIControlState.Normal);
                // 再次开启动画
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __int64_t.init(0.1) * __int64_t.init(NSEC_PER_SEC)), dispatch_get_main_queue(), {
                    
                    UIView.setAnimationsEnabled(true);
                })
            } else {
                
                let icon = String(format: "%@/%@", emotion!.directory!, emotion!.png!);
                var image = UIImage(named: icon);
                image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
                setImage(image, forState: UIControlState.Normal);
                setTitle(nil, forState: UIControlState.Normal);
            }
        }
    };
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        adjustsImageWhenHighlighted = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
