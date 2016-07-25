//
//  ZXStatusRepostedView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/20.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXStatusRepostedView: UIImageView {

    var statusFrame : ZXStatusFrame? {
        
        didSet {
            
            // 控制转发微博整体的可见性
            let repostedStatus = statusFrame?.status?.retweeted_status;
            if repostedStatus != nil {
                
                hidden = false;
                frame = (statusFrame?.repostedViewF)!;
            } else {
                
                hidden = true;
                return;
            }
            
            // 设置数据
            setupData();
            
            // 设置frame
            setupFrame();

        }
    };
    // 被转发微博的昵称
    private var repostedNameLabel : UILabel?;
    // 被转发微博的正文\内容
    private var repostedContentLabel : UILabel?;
    //  配图(相册)
    private var repostedPhotosView : ZXPhotosView?;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        self.userInteractionEnabled = true;
        self.image = UIImage.resizableImage("timeline_retweet_background");
    
        // 转发微博的昵称
        repostedNameLabel = UILabel();
        repostedNameLabel?.font = UIFont.systemFontOfSize(15);
        repostedNameLabel?.textColor = RGB(66, g: 101, b: 105);
        addSubview(repostedNameLabel!);
        
        // 转发微博正文
        repostedContentLabel = UILabel();
        repostedContentLabel?.font = kRepostedContentLabelFont;
        repostedContentLabel?.textColor = RGB(51, g: 51, b: 66);
        repostedContentLabel?.numberOfLines = 0;
        addSubview(repostedContentLabel!);
        
        // 配图
        repostedPhotosView = ZXPhotosView();
        addSubview(repostedPhotosView!);

        
    }
    
    // 设置数据
    func setupData() -> Void {
        
        let repostedStatus = statusFrame?.status?.retweeted_status;
        // 转发微博的昵称
        repostedNameLabel?.text = String(format: "@%@" , (repostedStatus?.user?.name)!);
        // 转发微博的内容
        repostedContentLabel?.text = repostedStatus?.text;
        // 配图
        print(repostedStatus?.pic_urls);
        repostedPhotosView?.photos = repostedStatus?.pic_urls;
        
    }
    
    
    // 设置frame 
    func setupFrame() -> Void {
        
        frame = (statusFrame?.repostedViewF)!;
        // 转发微博的昵称
        repostedNameLabel?.frame = (statusFrame?.repostedNameLabelF)!;
        // 转发的正文
        repostedContentLabel?.frame = (statusFrame?.repostedContentLabelF)!;
        // 配图
        repostedPhotosView?.frame = (statusFrame?.repostedPhotosViewF)!;

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
