//
//  ZXStatusToolbar.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXStatusToolbar: UIImageView {

   
    var status : ZXStatus? {
        
        didSet {
           
            // 转发
            setupBtnTitle(repostBtn, count: status?.reposts_count?.integerValue, originalTitle: "转发");
            
            // 评论
            setupBtnTitle(commentBtn, count: status?.comments_count?.integerValue, originalTitle: "评论");
            
            // 赞
            setupBtnTitle(attitudeBtn, count: status?.attitudes_count?.integerValue, originalTitle: "赞");

        }
    };
    
    private lazy var btns : NSMutableArray? = {
        
        let btns = NSMutableArray();
        return btns;
    }();
    private lazy var dividers : NSMutableArray? = {
       
        let dividers = NSMutableArray();
        return dividers;
    }();
    private var repostBtn : UIButton?;
    private var commentBtn : UIButton?;
    private var attitudeBtn : UIButton?;
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
      
        // 设置图片
        image = UIImage.resizableImage("common_card_bottom_background");
        userInteractionEnabled = true;
        // 添加3个按钮
        repostBtn = setupBtnWithIcon("timeline_icon_retweet", title: "转发");
        commentBtn = setupBtnWithIcon("timeline_icon_comment", title: "评论");
        attitudeBtn = setupBtnWithIcon("timeline_icon_unlike", title: "赞");
        
        // 添加分割线
        setupDivider();
        setupDivider();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置背景图片和文字
    func setupBtnWithIcon(imageName : String? , title : String?) -> UIButton? {
        
        let btn = UIButton();
        btn.setImage(UIImage(named: imageName!), forState: UIControlState.Normal);
        btn.setTitle(title!, forState: UIControlState.Normal);
        btn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal);
        btn.titleLabel?.font = UIFont.systemFontOfSize(13);
        
        // 设置高亮时的背景
        btn.setBackgroundImage(UIImage(named: "common_card_bottom_background_highlighted"), forState: UIControlState.Highlighted);
        btn.adjustsImageWhenHighlighted = false;
        
        // 设置间距
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        addSubview(btn);
        
        // 将按钮添加到数组中
        self.btns?.addObject(btn);
        
        return btn;

    }
    
    
    func setupDivider() -> Void {
        
        let divider = UIImageView();
        divider.image = UIImage(named: "timeline_card_bottom_line");
        addSubview(divider);
        self.dividers?.addObject(divider);
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        // 设置按钮的frame
        let btnCount = (self.btns?.count)!;
        let btnW = self.frame.size.width / CGFloat(btnCount);
        let btnH = self.frame.size.height;
        for i in 0..<btnCount {
            
            let btn = self.btns![i] as!UIButton;
            btn.frame.size.width = btnW;
            btn.frame.size.height = btnH;
            btn.frame.origin.y = CGFloat(0);
            btn.frame.origin.x = btnW * CGFloat(i);
            
        }
        
        // 设置分割线
        let dividerCount = (self.dividers?.count)!;
        for i in 0..<dividerCount {
            
            let divider = self.dividers![i] as!UIImageView;
            let dividerW = CGFloat(1);
            let dividerH = btnH;
            let dividerCenterX = CGFloat(i + 1) * btnW;
            let dividerCenterY = btnH * 0.5;
            divider.center = CGPointMake(dividerCenterX, dividerCenterY);
            divider.bounds = CGRectMake(0, 0, dividerW, dividerH);
            
        }
    }
    
    
    func setupBtnTitle(btn : UIButton? , count : NSInteger? , originalTitle : String?) -> Void {
        print(count);
        if (count != nil) {
            
            var title : String?;
            if count >= 10000 {
                
                let countDouble = CGFloat(count!) / 10000.0;
                title = String(format: "%.1f万" , countDouble);
                // 将字符串中.0去掉
                title = title?.stringByReplacingOccurrencesOfString(".0", withString: "");
                
            } else {
                
                title = String(format: "%d" , count!);
            }
            
            btn?.setTitle(title!, forState: UIControlState.Normal);
            
            
        } else {
            
            btn?.setTitle(originalTitle, forState: UIControlState.Normal);
        }

    }

}
