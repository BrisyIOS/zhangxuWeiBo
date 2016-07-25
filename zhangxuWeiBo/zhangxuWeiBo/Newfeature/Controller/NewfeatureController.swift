//
//  NewfeatureController.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/13.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class NewfeatureController: UIViewController , UIScrollViewDelegate {
    
    var pageControl : UIPageControl!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加scrollView
        setupScrollView();
        
        // 添加pageControl
        setupPageControl();
        
        
        // Do any additional setup after loading the view.
    }
    
    // 添加scrollView
    func setupScrollView() -> Void {
        
        // 添加scrollview
        let scrollView = UIScrollView();
        scrollView.frame = self.view.bounds;
        scrollView.delegate = self;
        self.view.addSubview(scrollView);
        
        // 添加图片
        let imageH = kScreenHeight;
        let imageW = kScreenWidth;
        for i in 0..<ZXNewfeatureImageCount {
            // 创建imageView对象
            let imageView = UIImageView();
            // 设置图片名
            let imageName = String(format: "new_feature_%d" , i + 1);
            // 设置图片
            imageView.image = UIImage(named: imageName);
            // 添加imageView
            scrollView.addSubview(imageView);
            
            // 设置imageView的frame
            let imageViewX = CGFloat(i) * imageW;
            let imageViewY = CGFloat(0)
            let imageViewW = imageW;
            let imageViewH = imageH;
            imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
            
            // 处理最后一个imageView
            if i == ZXNewfeatureImageCount - 1 {
                
                setupLastImageView(imageView);
            }
        }
        
        
        // 设置contenSize
        scrollView.contentSize = CGSizeMake(CGFloat(ZXNewfeatureImageCount) * imageW, 0);
        // 设置分页模式
        scrollView.pagingEnabled = true;
        // 设置水平滚动条隐藏
        scrollView.showsHorizontalScrollIndicator = false;
        // 设置scrollView的背景颜色
        scrollView.backgroundColor = RGB(246 , g: 246 , b: 246);
    }
    
    // 设置最后一张图片
    func setupLastImageView(imageView : UIImageView) -> Void {
        // 开启imageView的交互
        imageView.userInteractionEnabled = true;
        
        // 设置开始按钮
        setupStartButton(imageView);
        
        // 设置分享按钮
        setupShareButton(imageView);
        
    }
    
    
    // 设置开始按钮
    func setupStartButton(imageView : UIImageView) -> Void {
        
        let startButton = UIButton();
        imageView.addSubview(startButton);
        // 设置背景图片(普通状态)
        startButton.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal);
        // 设置背景图片(高亮)
        startButton.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted);
        // 设置frame
        let size = startButton.currentBackgroundImage?.size;
        let centerX = self.view.bounds.size.width * 0.5;
        let centerY = self.view.bounds.size.height * 0.8;
        startButton.center = CGPointMake(centerX, centerY);
        startButton.bounds = CGRectMake(0, 0, (size?.width)!, (size?.height)!);
        // 设置文字
        startButton.setTitle("开始微博", forState: UIControlState.Normal);
        startButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        startButton.addTarget(self, action: #selector(start), forControlEvents: UIControlEvents.TouchUpInside);

    }
    
    
    // 开始微博
    func start() -> Void {
        
        // 显示状态
        let app = UIApplication.sharedApplication();
        // 显示状态栏
        app.statusBarHidden = false;
        // 获取window
        let window = app.keyWindow;
        // 切换windows的rootViewController
        window?.rootViewController = ZXTabBarController();
        
    }
    
    // 设置分享按钮
    func setupShareButton(imageView : UIImageView) -> Void {
        
        // 添加分享按钮
        let shareButton = UIButton();
        imageView.addSubview(shareButton);
        // 设置文字和图标
        shareButton.setTitle("分享给大家", forState: UIControlState.Normal);
        shareButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        shareButton.adjustsImageWhenHighlighted = false;
        shareButton.setImage(UIImage(named: "new_feature_share_false"), forState: UIControlState.Normal);
        shareButton.setImage(UIImage(named: "new_feature_share_true"), forState: UIControlState.Selected);
        shareButton.addTarget(self, action: #selector(shareButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        // 设置titleLabel四周的内边距
        shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        // 设置frame
        let shareButtonCenterX = self.view.bounds.size.width * 0.5;
        let shareButtonY = self.view.bounds.height * 0.7;
        shareButton.center = CGPointMake(shareButtonCenterX, shareButtonY);
        let shareButtonW = CGFloat(200);
        let shareButtonH = CGFloat(35);
        shareButton.bounds = CGRectMake(0, 0, shareButtonW, shareButtonH);

    }
    
    
    func shareButtonClick(shareButton : UIButton) -> Void {
        
        // 选中状态取反
        shareButton.selected = !shareButton.selected;

        
    }
    
    // 添加pageControl
    func setupPageControl() -> Void {
        
        self.pageControl = UIPageControl();
        self.pageControl.numberOfPages = ZXNewfeatureImageCount;
        let centerX = self.view.bounds.size.width * 0.5;
        let centerY = self.view.bounds.size.height - 30;
        self.pageControl.center = CGPointMake(centerX, centerY);
        self.view.addSubview(self.pageControl);
        
        // 设置原点的颜色
        self.pageControl.currentPageIndicatorTintColor = RGB(253, g: 98, b: 42);
        self.pageControl.pageIndicatorTintColor = RGB(189, g: 189, b: 189);

    }
    
    // scrollView滚动会调用此方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let ratio = scrollView.contentOffset.x / scrollView.bounds.size.width;
        let page = NSInteger(ratio + 0.5);
        self.pageControl.currentPage = page;

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
