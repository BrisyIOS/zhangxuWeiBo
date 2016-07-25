//
//  ZXPhotoView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXPhotoView: UIImageView {

    var photo : ZXPhoto? {
        
        didSet {
            
          
            // 下载图片
            let photoURL = NSURL(string: (photo?.thumbnail_pic!)!)!;
            sd_setImageWithURL(photoURL, placeholderImage: UIImage(named: "timeline_image_placeholder"));
            print(photo?.thumbnail_pic!);
            let imageNameExtension = ((photo?.thumbnail_pic)! as NSString).pathExtension.lowercaseString;
            // 忽略大小写进行判断
            if imageNameExtension.hasSuffix("gif") == true {
                
                self.gifView?.hidden = false;
                
            } else {
                
                self.gifView?.hidden = true;
            }
            
        }
    };
    var gifView : UIImageView?;
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 设置属性
        self.userInteractionEnabled = true;
        self.contentMode = UIViewContentMode.ScaleAspectFill;
        // 超出UIImageView边界的内容，都剪掉
        self.clipsToBounds = true;
        
        // gifView
        gifView = UIImageView.init(image: UIImage(named: "timeline_image_gif"));
        addSubview(gifView!);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        
        self.gifView?.frame.origin.x = self.frame.size.width - (self.gifView?.frame.size.width)!;
        self.gifView?.frame.origin.y = self.frame.size.width - (self.gifView?.frame.size.height)!;

    }
    

}
