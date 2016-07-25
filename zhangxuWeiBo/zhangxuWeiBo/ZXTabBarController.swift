//
//  ZXTabBarController.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXTabBarController: UITabBarController , ZXTabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.redColor();
        
        
        // 添加所有的控制器
        addAllControllers();
        
        // 自定义tabBar
        addCustomTabBar();
        
        
        // Do any additional setup after loading the view.
    }
    
    // 添加customTabBar
    func addCustomTabBar() -> Void {
        
        // 自定义tabBar
        let customTabBar = ZXTabBar();
        customTabBar.customDelegate = self;
        // 更换系统自带的tabBar
        setValue(customTabBar, forKeyPath: "tabBar");
        
        
    }
    
    // 添加所有的控制器
    func addAllControllers() -> Void {
        
        // 首页
        let homeVc = HomeController();
        addChildVc(homeVc, title: "首页", imageName: "tabbar_home", selectedImageName: "tabbar_home_selected");
        
        // 消息
        let messageVc = MessageController();
        addChildVc(messageVc, title: "消息", imageName: "tabbar_message_center", selectedImageName: "tabbar_message_center_selected");
        
        // 广场
        let discoverVc = DiscoverController();
        addChildVc(discoverVc, title: "广场", imageName: "tabbar_discover", selectedImageName: "tabbar_discover_selected");
        
        // 我
        let mineVc = MineController();
        addChildVc(mineVc, title: "我", imageName: "tabbar_profile", selectedImageName: "tabbar_profile_selected");
    }
    
     //  添加一个子控制器
    func addChildVc(vc : UIViewController?  , title : String? , imageName : String? , selectedImageName : String?) -> Void {
        
        // 设置标题
        vc?.title = title;
        // 设置图标
        vc?.tabBarItem.image = UIImage(named: imageName!);
        // 创建一个字典用来设置普通状态下的文字属性
        var textAttrs = [String : AnyObject]();
        // 设置tabBarItem的文字颜色
        textAttrs[NSForegroundColorAttributeName] = UIColor.blackColor();
        // 设置tabBarItem的字体大小
        textAttrs[NSFontAttributeName] = UIFont.systemFontOfSize(10);
        // 设置tabBarButton普通状态下的文字属性
        vc?.tabBarItem.setTitleTextAttributes((textAttrs), forState: UIControlState.Normal)
        // 创建一个字典用来设置文字选中状态下的属性
        var selectedTextAttrs = [String : AnyObject]();
        // 设置tabBarButton的文字颜色
        selectedTextAttrs[NSForegroundColorAttributeName] = UIColor.orangeColor();
        // 设置tabBarItem的高亮状态下的文字属性
        vc?.tabBarItem.setTitleTextAttributes(selectedTextAttrs, forState: UIControlState.Selected);
        // 设置选中的图标
        var selectedImage = UIImage(named: selectedImageName!);
        // 设置这张图片用原图，不渲染
        selectedImage = selectedImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal);
        vc?.tabBarItem.selectedImage = selectedImage;
        // 添加tabBar的控制器为子控制器
        let nav = ZXNavigationController(rootViewController : vc!);
        addChildViewController(nav);
        
    }
    
    // 点击加号按钮，跳转到发微博界面
    func tabBarDidClickedPlusButton(tabBar : ZXTabBar?) {
        
        let composeVc = ComposeController();
        let nav = ZXNavigationController(rootViewController : composeVc);
        presentViewController(nav, animated: true, completion: nil);
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
