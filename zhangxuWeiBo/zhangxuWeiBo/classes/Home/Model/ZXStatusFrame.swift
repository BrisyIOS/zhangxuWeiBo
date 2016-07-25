//
//  ZXStatusFrame.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/15.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class ZXStatusFrame: NSObject {
   
    // 微博数据模型
    var status : ZXStatus? {
        // 根据数据计算子控件的frame
        didSet {
            
            // 计算顶部控件的frame
            setupTopViewFrame();
            
            // 计算底部工具条的frame
            setupToolbarFrame();
          
            // 计算cell的高度
            cellHeight = CGRectGetMaxY(toolbarF!);
    
        }
    };
    // 顶部的view的frame
    var topViewF : CGRect?;
    // 原创微博的view的frame
    var originalViewF : CGRect?;
    // 头像的父视图
    var iconSupViewF : CGRect?;
    // 头像的frame
    var iconViewF : CGRect?;
    // 会员图标的frame
    var vipViewF : CGRect?;
    var vRankViewF : CGRect?
    // 昵称的frame
    var nameLabelF : CGRect?;
    // 内容的frame
    var contentLabelF : CGRect?;
    // 配图的frame
    var photosViewF : CGRect?;
    // 底部的工具条
    var toolbarF : CGRect?;
    // 被转发微博View的frame
    var repostedViewF : CGRect?;
    // 被转发微博昵称的frame
    var repostedNameLabelF : CGRect?;
    // 被转发微博内容的frame
    var repostedContentLabelF : CGRect?;
    // 被转发微博配图的frame
    var repostedPhotosViewF : CGRect?;
    // cell的高度
    var cellHeight : CGFloat?;
    
    // 设置顶部View的frame
    func setupTopViewFrame() -> Void {
        
        // 计算原创微博的frame
        setupOriginalViewFrame();
        
        // 计算转发微博的frame
        setupRepostedViewFrame();
        
        // 计算顶部控件的frame
        let repostedStatus = self.status?.retweeted_status;
        var topViewH = CGFloat(0);
        // 有转发微博
        if (repostedStatus != nil) {
            
            topViewH = CGRectGetMaxY(repostedViewF!);
            
        }
            
            // 无转发微博
        else {
            
            topViewH = CGRectGetMaxY(originalViewF!);
        }
        
        let topViewX = CGFloat(0);
        let topViewY = kCellMargin;
        let topViewW = kScreenWidth;
        topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
        
    }
    
    
    // 计算底部工具条的frame
    func setupToolbarFrame() -> Void {
      
        let toolbarX = CGFloat(0);
        let toolbarY = CGRectGetMaxY(topViewF!);
        let toolbarW = kScreenWidth;
        let toolbarH = CGFloat(35);
        toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        
    }
    
    
    // 计算原创微博的frame
    func setupOriginalViewFrame() -> Void {
        
        // 头像父视图
        let iconSupViewX = kCellPadding;
        let iconSupViewY = kCellPadding;
        let iconSupViewW = CGFloat(35);
        let iconSupViewH = CGFloat(35);
        iconSupViewF = CGRectMake(iconSupViewX, iconSupViewY, iconSupViewW, iconSupViewH);
     
        // 头像
        let iconViewX = CGFloat(0);
        let iconViewY = CGFloat(0);
        let iconViewW = CGFloat(35);
        let iconViewH = CGFloat(35);
        iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
        
        // 会员等级图标
        let image = UIImage(named: "avatar_vip");
        let vRankViewX = iconSupViewW - (image?.size.width)! * 0.8;
        let vRankViewY = iconSupViewH  - (image?.size.height)! * 0.8;
        let vRankViewW = (image?.size.width)! * 0.8;
        let vRankViewH = (image?.size.height)! * 0.8;
        vRankViewF = CGRectMake(vRankViewX, vRankViewY, vRankViewW, vRankViewH);
        
        // 昵称
        let nameLabelX = CGRectGetMaxX(iconSupViewF!) + kCellPadding;
        let nameLabelY = iconSupViewY;
        var attrs = [String : AnyObject]();
        attrs[NSFontAttributeName] = UIFont.systemFontOfSize(16);
        let nameLabelSize = ((status?.user?.name)! as NSString).sizeWithAttributes(attrs);
        nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelSize.width, nameLabelSize.height);
        
        // 会员图标
        let vipViewX = CGRectGetMaxX(nameLabelF!) + kCellPadding;
        let vipViewY = nameLabelY;
        let vipViewW = CGFloat(14);
        let vipViewH = nameLabelSize.height;
        vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
        
        // 正文内容
        let contentLabelX = iconSupViewX;
        let contentLabelY = CGRectGetMaxY(iconSupViewF!) + kCellPadding;
        let contentLabelMaxW = kScreenWidth - 2 * kCellPadding;
        let contentLabelMaxSize = CGSizeMake(contentLabelMaxW, CGFloat(MAXFLOAT));
        var contentLabelAttrs = [String : AnyObject]();
        contentLabelAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(16.0);
        let contentLabelRect = ((status?.text!)! as NSString).boundingRectWithSize(contentLabelMaxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: contentLabelAttrs, context: nil);
        contentLabelF = CGRectMake(contentLabelX, contentLabelY, contentLabelRect.width, contentLabelRect.height);
        
        // 配图
        let photosCount = status?.pic_urls?.count;
        
        var originalViewH = CGFloat(0);
        // 有配图
        if photosCount != nil {
            
            let photosViewX = contentLabelX;
            let photosViewY = CGRectGetMaxY(contentLabelF!) + kCellPadding;
            // 计算配图的尺寸
            let photosViewSize = photosSizeWithCount(photosCount);
            photosViewF = CGRectMake(photosViewX, photosViewY, photosViewSize!.width, photosViewSize!.height);
            originalViewH = CGRectGetMaxY(photosViewF!) + kCellPadding;
        }
            
            // 没有配图
        else {
            
            originalViewH = CGRectGetMaxY(contentLabelF!) + kCellPadding;
            
        }
        
        // 原创微博的整体
        let originalViewX = CGFloat(0);
        let originalViewY = CGFloat(0);
        let originalViewW = kScreenWidth;
        originalViewF = CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
        
    }
    
    // 根据配图的个数计算配图的frame
    func photosSizeWithCount(photosCount : NSInteger?) -> CGSize? {
        
        // 一行最多的列数
        let maxCols = photosMaxCols(photosCount);
        
        // 列数
        var cols = 0;
        if photosCount >= maxCols {
            
            cols = maxCols!;
        } else {
            
            cols = photosCount!;
        }
        
        // 行数
        var rows = 0;
        rows = photosCount! / maxCols!;
        if photosCount! % maxCols! != 0 {
            
            rows = rows + 1;
        }

        
        // 配图的宽度取决于图片的列数
        let photosViewW = CGFloat(cols) * kPhotoW + (CGFloat(cols) - 1) * kPhotoMargin;
        let photosViewH = CGFloat(rows) * kPhotoH + CGFloat(rows - 1) * kPhotoMargin;
        return CGSizeMake(photosViewW, photosViewH);
        
    }
    
    
    
    // 计算转发微博的frame
    func setupRepostedViewFrame() -> Void {
      
        let repostedStatus = status?.retweeted_status;
        if (repostedStatus == nil) {
            
            return;
        }
        
        // 昵称
        let repostedNameLabelX = kCellPadding;
        let repostedNameLabelY = kCellPadding;
        let name = String(format: "@%@" , (repostedStatus?.user?.name)!);
        var repostedNameLabelAttrs = [String : AnyObject]();
        repostedNameLabelAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(15);
        let repostedNameLabelSize = (name as NSString).sizeWithAttributes(repostedNameLabelAttrs);
        repostedNameLabelF = CGRectMake(repostedNameLabelX, repostedNameLabelY, repostedNameLabelSize.width, repostedNameLabelSize.height);
        
        // 正文内容
        let repostedContentLabelX = repostedNameLabelX;
        let repostedContentLabelY = CGRectGetMaxY(repostedNameLabelF!) + kCellPadding;
        let repostedContentLabelMaxW = kScreenWidth - 2 * kCellPadding;
        let repostedContentLabelMaxSize = CGSizeMake(repostedContentLabelMaxW, CGFloat(MAXFLOAT));
        var repostedContentLabelAttrs = [String : AnyObject]();
        repostedContentLabelAttrs[NSFontAttributeName] = kRepostedContentLabelFont;
        print(repostedStatus);
        let repostedContentLabelRect = ((repostedStatus?.text)! as NSString).boundingRectWithSize(repostedContentLabelMaxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: repostedContentLabelAttrs, context: nil);
        repostedContentLabelF = CGRectMake(repostedContentLabelX, repostedContentLabelY, repostedContentLabelRect.width, repostedContentLabelRect.height);
        
        // 配图
        let photosCount = status?.retweeted_status?.pic_urls?.count;
        var repostedViewH = CGFloat(0);
        if (photosCount != nil) {
            
            // 有配图
            let repostedPhotosViewX = repostedContentLabelX;
            let repostedPhotosViewY = CGRectGetMaxY(repostedContentLabelF!) + kCellPadding;
            // 计算配图的尺寸
            let repostedPhotosViewSize = photosSizeWithCount(photosCount);
            repostedPhotosViewF = CGRectMake(repostedPhotosViewX, repostedPhotosViewY, (repostedPhotosViewSize?.width)!, (repostedPhotosViewSize?.height)!);
            repostedViewH = CGRectGetMaxY(repostedPhotosViewF!) + kCellPadding;
        }
            
            // 没有配图
        else {
            
            repostedViewH = CGRectGetMaxY(repostedContentLabelF!) + kCellPadding;
            
        }
        // 整体
        let repostedViewX = CGFloat(0);
        let repostedViewY = CGRectGetMaxY(originalViewF!);
        let repostedViewW = kScreenWidth;
        repostedViewF = CGRectMake(repostedViewX, repostedViewY, repostedViewW, repostedViewH);
        

    }
    
    
    override init() {
        
        super.init();
        
        
    }
   

}
