//
//  ZXTabBar.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

protocol ZXTabBarDelegate : NSObjectProtocol {
    
    func tabBarDidClickedPlusButton(tabBar : ZXTabBar?);
}

class ZXTabBar: UITabBar {

    weak var customDelegate : ZXTabBarDelegate?;
    var plusButton : UIButton!;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 设置tabBar背景图片
        self.backgroundImage = UIImage(named: "tabbar_background");
        // 设置选项卡按钮背景图片
        self.selectionIndicatorImage = UIImage(named: "navigationbar_button_background");
        
        // 添加加号按钮
        setupPlusButton();
 
    }
    
    // 设置加号按钮
    func setupPlusButton() -> Void {
        
        plusButton = UIButton();
        // 设置普通状态下的背景图片
        plusButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal);
        // 设置高亮状态下的背景图片
        plusButton.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted);
        // 设置加号图标(普通状态)
        plusButton.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal);
        // 设置加号图标(高亮状态)
        plusButton.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted);
        // 监听按钮点击
        plusButton.addTarget(self, action: #selector(plusClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        // 添加加号按钮
        addSubview(plusButton);
        
    }
    
    // 监听加号按钮点击
    func plusClick(button : UIButton?) -> Void {
        
        print("plusClick");
        
        // 通知代理处理点击事件
        self.customDelegate?.tabBarDidClickedPlusButton(self);
 
        
    }
    
    // 重新布局子控件
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        // 设置plusButton的frame
        setupPlusButtonFrame();
        
        // 设置所有tabBarButton的frame
        setupAllTabBarButtonsFrame();

        
    }
    
    // 设置plusButton的frame
    func setupPlusButtonFrame() -> Void {
        
        let centerX = self.bounds.size.width * 0.5;
        let centerY = self.bounds.size.height * 0.5;
        let size = plusButton.currentBackgroundImage?.size;
        plusButton.center = CGPointMake(centerX, centerY);
        plusButton.bounds = CGRectMake(0, 0, (size?.width)!, (size?.height)!);

    }
    
    // 设置所有tabBarButton的frame
    func setupAllTabBarButtonsFrame() -> Void {
        
        var index = 0;
       
        // 遍历所有的button
        for tabBarButton in self.subviews {
            
            // 如果不是UITabBarButton，直接跳过
            if !tabBarButton.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                
                continue;
            }
            
            // 根据索引调整位置
            setupTabBarButtonFrame(tabBarButton, index: index);
    
            // 索引增加
            index += 1;
        }
        
    }
    
    
    // 根据索引调整位置
    func setupTabBarButtonFrame(tabBarButton : UIView? , index : NSInteger) -> Void {
        
        
        // item的宽
        let buttonW = self.bounds.size.width / CGFloat(((self.items?.count)! + 1));
        // item的高
        let buttonH = self.bounds.size.height;
        // item的bounds
        tabBarButton?.bounds = CGRectMake(0, 0, buttonW, buttonH);
        // 调整索引位置
        if index >= 2 {
            // item的x 值
            let tabBarButtonX = buttonW * CGFloat(index + 1);
            // item的y 值
            let tabBarButtonY = CGFloat(0);
            // item的frame
            tabBarButton?.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
            
        } else {
            // item的x 值
            let tabBarButtonX = buttonW * CGFloat(index);
            // item的y 值
            let tabBarButtonY = CGFloat(0);
            // item的frame
            tabBarButton?.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
