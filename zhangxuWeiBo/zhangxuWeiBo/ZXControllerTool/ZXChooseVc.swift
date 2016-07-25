//
//  ZXChooseVc.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class ZXChooseVc: NSObject {
    
    // 选择根控制器
    class func chooseRootViewController() -> Void {
        
        let key = kCFBundleVersionKey as String;
        print(key);
        // 获取当前软件的版本号
        let currentVersion = NSBundle.mainBundle().infoDictionary![key];
        
        let application = UIApplication.sharedApplication();
        let window = application.keyWindow;
        
        // 沙盒中的版本号
        let defaults = NSUserDefaults.standardUserDefaults();
        let sandBoxVersion = defaults.stringForKey(key);
        
        
        // 比较当前软件的版本号和沙盒中的版本号
        if sandBoxVersion != nil && currentVersion?.compare(sandBoxVersion!) == .OrderedDescending {
            // 存储当前软件的版本号
            defaults.setObject(currentVersion, forKey: key);
            defaults.synchronize();
            
            window?.rootViewController = NewfeatureController();
            
            
        } else {
            
            // 显示状态栏
            application.statusBarHidden = false;
            window?.rootViewController = ZXTabBarController();
        }
        
    }

}
