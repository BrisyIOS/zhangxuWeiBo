//
//  ZXComposePhotosView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXComposePhotosView: UIView {

   // 添加图片到相册
    func addImage(image : UIImage?) -> Void {
        
        let imageView = UIImageView();
        imageView.contentMode = UIViewContentMode.ScaleAspectFill;
        imageView.clipsToBounds = true;
        imageView.image = image;
        addSubview(imageView);
        
    }
    
    func images() -> NSArray {
        
        let array = NSMutableArray();
        for imageView in self.subviews {
            
            let imageView = imageView as? UIImageView;
            array.addObject(imageView!.image!);
        }
        
        return array;
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        let count = self.subviews.count;
        // 一行的最大列数
        let maxColsPerRow = 4;
        // 每个图片之间的间距
        let margin = CGFloat(10);
        // 每个图片的宽高
        let imageViewW = (self.frame.size.width - CGFloat(maxColsPerRow + 1) * margin) / CGFloat(maxColsPerRow);
        let imageViewH = imageViewW;
        for i in 0..<count {
            
            // 行号
            let row = i / maxColsPerRow;
            // 列号
            let col = i % maxColsPerRow;
            
            let imageView = self.subviews[i] as? UIImageView;
            let imageViewX = CGFloat(col) * (imageViewW + margin) + margin;
            let imageViewY = CGFloat(row) * (imageViewH + margin);
            imageView?.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
            
        }
    }

}
