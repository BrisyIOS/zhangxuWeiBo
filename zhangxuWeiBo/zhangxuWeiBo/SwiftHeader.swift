//
//  SwiftHeader.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//


import UIKit

// 屏幕宽度
let kScreenWidth = UIScreen.mainScreen().bounds.width;
// 屏幕高度
let kScreenHeight = UIScreen.mainScreen().bounds.height;
// 是否为iOS8版本
let IOS8 = Double(UIDevice.currentDevice().systemVersion) >= 8.0;
// document路径
let kDocumentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0];
// APPkey可以信息
let ZXAppKey = "594327966";
let ZXAppSecret = "e7536dd658b432a88080fd2a91f59082";
let ZXRedirectURL = "http://www.baidu.com";


let kCellMargin = CGFloat(8);
let kCellPadding = CGFloat(10);
let kPhotoW = CGFloat(70);
let kPhotoMargin = CGFloat(10);
let kPhotoH = CGFloat(70);


let kRepostedContentLabelFont = UIFont.systemFontOfSize(13);


let kEmotionMaxRows = 3;
let kEmotionMaxCols = 7;

let ZXEmotionDidSelectedNotification = "ZXEmotionDidSelectedNotification";
let ZXSelectedEmotion = "ZXSelectedEmotion";
let ZXEmotionDidDeletedNotification = "ZXEmotionDidDeletedNotification";



// 新特性图片个数
let ZXNewfeatureImageCount = 4;
// 是否为4英寸
let INCH_4 = Bool(kScreenHeight == 568.0);
// 根据rgb设置颜色
func RGB(r : CGFloat , g : CGFloat , b : CGFloat) -> UIColor {
    
    let color = UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0);
    return color;
}

// 返回最大列数
func photosMaxCols(photosCount : NSInteger?) -> NSInteger? {
    
    if photosCount == 4 {
        
        return 2;
    } else {
        
        return 3;
    }
}



