//
//  ZXTitleButton.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/14.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


let titleButtonImageW = CGFloat(30);

class ZXTitleButton: UIButton {

    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        // 设置文字颜色
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        // 设置字体大小
        titleLabel?.font = UIFont.boldSystemFontOfSize(20);
        // 高亮时不要让imageView变灰
        adjustsImageWhenHighlighted = false;
        // 设置imageView居中
        imageView?.contentMode = UIViewContentMode.Center;
        // 设置文字右对齐
        titleLabel?.textAlignment = NSTextAlignment.Right;
        // 背景
        setBackgroundImage(UIImage(named: "navigationbar_filter_background_highlighted"), forState: UIControlState.Highlighted);
        
    }
    
    // 调整图片的frame
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        
        let imageW = titleButtonImageW;
        let imageH = self.bounds.size.height;
        let imageX = self.bounds.size.width - imageW;
        let imageY = CGFloat(0);
        return CGRectMake(imageX, imageY, imageW, imageH);
    }
    
    // 调整title的frame
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        
        let titleX = CGFloat(0);
        let titleY = CGFloat(0);
        let titleW = self.bounds.size.width - titleButtonImageW;
        let titleH = self.bounds.size.height;
        return CGRectMake(titleX, titleY, titleW, titleH);

    }
    
    // 计算按钮的宽度
    override func setTitle(title: String?, forState state: UIControlState) {
        
        super.setTitle(title, forState: state);
   
        var attributes = [String : AnyObject]();
        // 设置字体
        attributes[NSFontAttributeName] = self.titleLabel?.font;
        let titleSize = (title! as NSString).sizeWithAttributes(attributes);
        // 计算整个按钮的宽度
        self.bounds.size.width = titleSize.width + 2 * titleButtonImageW;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
