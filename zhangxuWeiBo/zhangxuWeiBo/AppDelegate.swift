//
//  AppDelegate.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/10.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isConnectStatus: Bool?;
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // 打印版本号
        print(UIDevice.currentDevice().systemVersion);
        
        // 创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds);
        
        // 设置窗口颜色
        window?.backgroundColor = UIColor.whiteColor();
        
        // 延迟加载启动图
        NSThread.sleepForTimeInterval(1);
        
        // 让window成为主窗口
        window?.makeKeyAndVisible();
       
        // 获取账户
        let account = ZXAccountManager.account();
        // 打印沙盒路径
        print(kDocumentPath);
        if account != nil {
            
            // 上次登陆授权过
            ZXChooseVc.chooseRootViewController();
            
        } else {
            // 没有授权过
            window?.rootViewController = ZXOAuthViewController();
        }
    
        // 监听网络状态
        let mgr = AFNetworkReachabilityManager.sharedManager();
        mgr.setReachabilityStatusChangeBlock { (status) in
            
            if status == AFNetworkReachabilityStatus.NotReachable {
                // 没有网络
                self.isConnectStatus = false;
                print("没有网络");
                
            } else {
                // 有网络
                self.isConnectStatus = true;
                print("有网络");
            }
        }
        
        // 设置网络加载状态
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true;
        
        
        
        return true
    }
    
    // 当发生内存警告的时候调用此方法
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        
        // 停止所有下载
        SDWebImageManager.sharedManager().cancelAll();
        // 清除内存缓存
        SDWebImageManager.sharedManager().imageCache.clearMemory();
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

