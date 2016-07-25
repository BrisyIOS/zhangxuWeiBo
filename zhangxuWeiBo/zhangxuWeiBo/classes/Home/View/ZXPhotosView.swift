//
//  ZXPhotosView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class ZXPhotosView: UIView {

   
    var photos : NSArray? {
        
        didSet {
            print(photos?.count)
            // 可见的控件
            let photosCount = photos?.count;
    
            if photosCount == 0 {
                
                self.hidden = true;
                return;
                
            } else {
                
                self.hidden = false;
            }
            
            // 给图片控件显示图片(遍历所有的子控件)
            for i in 0..<9 {
                
                let photoView = self.subviews[i] as!ZXPhotoView;
                
                if i < photosCount {
                
                    photoView.hidden = false;
                    print(photos![i] as? ZXPhoto);
                    photoView.photo = photos![i] as? ZXPhoto;
                    
                } else {
                    
                    photoView.hidden = true;
                }
            }
        }
    };
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 一次性创建9个
        for i in 0..<9 {
            
            // 创建photoView
            let photoView = ZXPhotoView(frame : CGRectZero);
            photoView.tag = i;
            addSubview(photoView);
         
            // 添加点击事件
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(photoTap(_:)));
            photoView.addGestureRecognizer(tap);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 图片点击事件
    func photoTap(tap : UITapGestureRecognizer?) -> Void {
        
        // 1.创建浏览器对象
        let browser = MJPhotoBrowser();
        // 设置浏览器对象的所有图片
        let zxPhotos = NSMutableArray();
        for i in 0..<self.photos!.count {
            
            // 取出图片模型
            let photo = photos![i] as! ZXPhoto;
            // 创建MJPhoto模型
            let mjphoto = MJPhoto();
            // 设置图片的url
            mjphoto.url = NSURL(string: photo.bmiddle_pic!)!;
            // 设置图片的来源View
            mjphoto.srcImageView = self.subviews[i] as!UIImageView;
            zxPhotos.addObject(mjphoto);
           
        }
        
        // 数组初始化
        browser.photos = NSMutableArray() as [AnyObject];
        // 赋值
        browser.photos = zxPhotos as [AnyObject];

        
        // 设置浏览器默认显示的图片位置
        browser.currentPhotoIndex  = NSInteger.init((tap?.view?.tag)!);
        
        // 显示浏览器
        browser.show();
       
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        if self.photos == nil {
            
            return;
        }
        let photoViewCount = (self.photos?.count)!;

        for i in 0..<photoViewCount {
            
            // 取出子控件
            let photoView = self.subviews[i] as!ZXPhotoView;
            // 设置frame
            photoView.frame.size.width = kPhotoW;
            photoView.frame.size.height = kPhotoH;
            // 一行最好的列数
            let maxCols = photosMaxCols(10);
            // x取决于列数
            let col = i % maxCols!;
            photoView.frame.origin.x = CGFloat(col) * (kPhotoW + kPhotoMargin);
            // y 取决于行数
            let row = i / maxCols!;
            photoView.frame.origin.y = CGFloat(row) * (kPhotoH + kPhotoMargin);
            
        }
    }

}
