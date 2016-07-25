//
//  ZXStatusTopView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/18.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXStatusTopView: UIImageView {

    var statusFrame : ZXStatusFrame? {
        
        didSet {
           
            // 设置顶部控件的view
            frame = (statusFrame?.topViewF)!;
            originalView?.statusFrame = statusFrame;
            repostedView?.statusFrame = statusFrame;

        }
    };
    var originalView : ZXStatusOriginalView?;
    var repostedView : ZXStatusRepostedView?;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 设置原创微博的View
        setupOriginalView();
        
        // 设置转发微博的View
        setupRepostedView();
        
        // 设置图片
        self.userInteractionEnabled = true;
        self.image = UIImage.resizableImage("common_card_top_background");
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置原创微博
    func setupOriginalView() -> Void {
        
        originalView = ZXStatusOriginalView();
        addSubview(originalView!);
    }
    
    // 设置转发微博
    func setupRepostedView() -> Void {
        
        repostedView = ZXStatusRepostedView(frame : CGRectZero);
        addSubview(repostedView!);
        
    }

}
