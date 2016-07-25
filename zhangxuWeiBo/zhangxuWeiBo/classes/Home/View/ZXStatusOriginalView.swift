//
//  ZXStatusOriginalView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXStatusOriginalView: UIView {

    var statusFrame : ZXStatusFrame? {
        
        didSet {
            
            
            // 设置数据
            setupData();
            
            // 设置frame
            setupFrame();

        }
    };
    var iconSupView : UIImageView?;
    var iconView : UIImageView?;
    var vRankView : UIImageView?;
    var vipView : UIImageView?;
    var nameLabel : UILabel?;
    var timeLabel : UILabel?;
    var sourceLabel : UILabel?;
    var contentLabel : UILabel?;
    var photosView : ZXPhotosView?
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        self.backgroundColor = UIColor.clearColor();
        
        // 头像的父视图
        iconSupView = UIImageView();
        addSubview(iconSupView!);
        
        // 头像
        iconView = UIImageView();
        iconView?.layer.cornerRadius = CGFloat(35/2);
        iconView?.layer.masksToBounds = true;
        iconSupView!.addSubview(iconView!);
        
        // 会员等级
        vRankView = UIImageView();
        iconSupView!.addSubview(vRankView!);
        
        // 会员图标
        vipView = UIImageView();
        vipView?.contentMode = UIViewContentMode.Center;
        addSubview(vipView!);
        
        // 昵称
        nameLabel = UILabel();
        nameLabel?.font = UIFont.systemFontOfSize(15);
        addSubview(nameLabel!);
        
        // 时间
        timeLabel = UILabel();
        timeLabel?.font = UIFont.systemFontOfSize(12);
        timeLabel?.textColor = UIColor.orangeColor();
        addSubview(timeLabel!);
        
        // 来源
        sourceLabel = UILabel();
        sourceLabel?.font = UIFont.systemFontOfSize(12);
        sourceLabel?.textColor = UIColor.grayColor();
        addSubview(sourceLabel!);
        
        // 正文内容
        contentLabel = UILabel();
        contentLabel?.font = UIFont.systemFontOfSize(16);
        contentLabel?.numberOfLines = 0;
        addSubview(contentLabel!);
        
        // 配图
        photosView = ZXPhotosView();
        addSubview(photosView!);
        
    }
    
    // 设置数据
    func setupData() -> Void {
        
        let status = statusFrame?.status;
        let user = status?.user;
     
        // 头像
        let iconURL = NSURL(string: (user?.profile_image_url)!);
        iconView?.sd_setImageWithURL(iconURL, placeholderImage: UIImage(named: "avatar_default_small"));
        // 会员图标
        if ((user?.isVIP()) == true) {
           // 设置会员图标
            let imageName = String(format: "common_icon_membership_level%d" , (user?.mbrank?.integerValue)!);
            vipView?.image = UIImage(named: imageName);
            vipView?.hidden = false;
            nameLabel?.textColor = UIColor.orangeColor();
//            // 设置会员等级图标
//            vRankView?.image = UIImage(named: "avatar_vip");
            vRankView?.hidden = false;
            
        } else {
            
            vipView?.hidden = true;
            vRankView?.hidden = true;
            nameLabel?.textColor = UIColor.blackColor();
            
        }
        
        // 昵称
        nameLabel?.text = user?.name;
        // 时间
        timeLabel?.text = status?.created_at;
        // 来源
        sourceLabel?.text = status?.source;
        // 正文
        contentLabel?.text = status?.text;
        
        // 配图
        photosView?.photos = status?.pic_urls;
        
        
    }
    
    
    // 设置frame
    func setupFrame() -> Void {
        
        frame = (statusFrame?.originalViewF)!;
        
        // 头像的父视图
        iconSupView?.frame = (statusFrame?.iconSupViewF)!;
        // 头像
        iconView?.frame = (statusFrame?.iconViewF)!;
        
        // 会员等级
        vRankView?.frame = (statusFrame?.vRankViewF)!
        
        // 会员图标
        vipView?.frame = (statusFrame?.vipViewF)!;
        
        // 昵称
        nameLabel?.frame = (statusFrame?.nameLabelF)!;
        
        // 时间
        let timeLabelX = (nameLabel?.frame.origin.x)!;
        let timeLabelY = CGRectGetMaxY(nameLabel!.frame) + kCellPadding * 0.5;
        let time = statusFrame?.status?.created_at;
        var timeAttrs = [String : AnyObject]();
        timeAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(12);
        let timeLabelSize = (time! as NSString).sizeWithAttributes(timeAttrs);
        timeLabel?.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelSize.width, timeLabelSize.height);
        
      
        // 来源
        let sourceLabelX = CGRectGetMaxX(timeLabel!.frame) + kCellPadding;
        let sourceLabelY = timeLabelY;
        let source = statusFrame?.status?.source;
        var sourceAttrs = [String : AnyObject]();
        sourceAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(12);
        let sourceLabelSize = (source! as NSString).sizeWithAttributes(sourceAttrs);
        sourceLabel?.frame = CGRectMake(sourceLabelX, sourceLabelY, sourceLabelSize.width, sourceLabelSize.height);
        
        // 正文
        contentLabel?.frame = (statusFrame?.contentLabelF)!;
        
        // 配图
        photosView?.frame = (statusFrame?.photosViewF)!;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
