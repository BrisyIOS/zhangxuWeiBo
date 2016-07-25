//
//  ZXEmotionListView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class ZXEmotionListView: UIView , UIScrollViewDelegate {

    var emotions : NSArray? {
        
        didSet {
            
            
            // 设置总页数
            let totalPages = ((emotions?.count)! + emotionMaxCountPerPage()! - 1) / emotionMaxCountPerPage()!;
            let currentGridViewCount = self.scrollView?.subviews.count;
            self.pageControl?.numberOfPages = totalPages;
            self.pageControl?.currentPage = 0;
            print(totalPages);
            // 决定scrollView显示多少页表情
            for i in 0..<totalPages {
                
                // 获得i位置对应的ZXEmotionGridView
                var gridView : ZXEmotionGridView?;
                if i >= currentGridViewCount {
                    
                    gridView = ZXEmotionGridView();
                    scrollView?.addSubview(gridView!);
                    
                }
                
                else {
                    
                    gridView = scrollView?.subviews[i] as? ZXEmotionGridView;
                    
                }
                
                // 设置表情数据
                let loc = i * emotionMaxCountPerPage()!;
                var len = emotionMaxCountPerPage()!;
                if (loc + len) > emotions?.count {
                    
                    len = (emotions?.count)! - loc;
                    
                    if len <= 0 {
                        
                        return;
                    }
                }
                
                let gridViewEmotionsRange = NSMakeRange(loc, len);
                let gridViewEmotions = emotions?.subarrayWithRange(gridViewEmotionsRange);
                gridView?.emotions = gridViewEmotions;
                gridView?.hidden = false;
                
            }
            print(scrollView?.subviews.count);
            // 隐藏后面不需要用到的gridView
            if currentGridViewCount > totalPages {
                
                for i in totalPages..<currentGridViewCount! {
                    
                    let gridView = scrollView?.subviews[i] as? ZXEmotionGridView;
                    gridView?.hidden = true;
                    
                }
            }
            
            
            // 重新布局子控件
            setNeedsLayout();
            
            // 表情滚动到最前面
            scrollView?.contentOffset = CGPointZero;
            
            
        }
    }
    var scrollView : UIScrollView?;
    var pageControl : UIPageControl?;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 显示所有表情的UIScrollView
        scrollView = UIScrollView();
        scrollView?.showsVerticalScrollIndicator = false;
        scrollView?.showsHorizontalScrollIndicator = false;
        scrollView?.pagingEnabled = true;
        scrollView?.delegate = self;
        addSubview(scrollView!);

        // 显示页码的UIPageControl
        pageControl = UIPageControl();
        pageControl?.hidesForSinglePage = true;
        pageControl?.setValue(UIImage(named: "compose_keyboard_dot_selected"), forKey: "_currentPageImage");
        pageControl?.setValue(UIImage(named: "compose_keyboard_dot_normal"), forKey: "_pageImage");
        addSubview(pageControl!);


    }
    
    
    func emotionMaxCountPerPage() -> NSInteger? {
        
        return kEmotionMaxRows * kEmotionMaxCols - 1;
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        // 1.UIPageControl的frame
        let pageControlW = self.frame.size.width;
        let pageControlH = CGFloat(35);
        let pageControlY = self.frame.size.height - (self.pageControl?.frame.size.height)!;
        pageControl?.frame = CGRectMake(0, pageControlY, pageControlW, pageControlH);
        
        

        // 2.UIScrollView的frame
        let scrollViewW = self.frame.size.width;
        let scrollViewH = pageControlY;
        scrollView?.frame = CGRectMake(0, 0, scrollViewW, scrollViewH);
        
        // 3.设置UIScrollView内部控件的尺寸
        let count = scrollView?.subviews.count;
        let gridW = scrollViewW;
        let gridH = scrollViewH;
        scrollView?.contentSize = CGSizeMake(CGFloat(count!) * gridW, 0);
        
        for i in 0..<count! {
        
            let gridView = scrollView?.subviews[i] as? ZXEmotionGridView;
            let gridViewX = CGFloat(i) * gridW;
            gridView?.frame = CGRectMake(gridViewX, 0, gridW, gridH);
        }

    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        pageControl?.currentPage = NSInteger.init(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
