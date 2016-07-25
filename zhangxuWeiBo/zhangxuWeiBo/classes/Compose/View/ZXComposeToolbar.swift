//
//  ZXComposeToolbar.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/25.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

enum ZXComposeToolbarButtonType : NSInteger {
    case Camera = 100// 照相机
    case Picture = 200// 照片
    case Mention = 300// 提到
    case Trend = 400// 话题
    case Emotion = 500// 表情
}

protocol ZXComposeToolbarDelegate : NSObjectProtocol {
    
    func composeTool(toolbar : ZXComposeToolbar? , clickedButtonType : ZXComposeToolbarButtonType?);
    
}

class ZXComposeToolbar: UIView {

    weak var delegate : ZXComposeToolbarDelegate?;// 代理
    var isShowEmotionButton : Bool? {
        
        didSet {
            
            if isShowEmotionButton == true {
                // 显示表情键盘
                self.emotionButton?.setImage(UIImage(named: "compose_emoticonbutton_background"), forState: UIControlState.Normal);
                self.emotionButton?.setImage(UIImage(named: "compose_emoticonbutton_background_highlighted"), forState: UIControlState.Highlighted);
                
            } else {
                // 显示键盘按钮
                self.emotionButton?.setImage(UIImage(named: "compose_keyboardbutton_background"), forState: UIControlState.Normal);
                self.emotionButton?.setImage(UIImage(named: "compose_keyboardbutton_background_highlighted"), forState: UIControlState.Highlighted);
            }
        }
    };// 是否要显示表情按钮
    var cameraButton : UIButton?;
    var pictureButton : UIButton?;
    var mentionButton : UIButton?;
    var trendButton : UIButton?;
    var emotionButton : UIButton?;
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        backgroundColor = UIColor.init(patternImage: UIImage(named: "compose_toolbar_background")!);
        // 添加所有的子控件
        cameraButton = addButtonWithIcon("compose_camerabutton_background", highIcon: "compose_camerabutton_background_highlighted", tag: ZXComposeToolbarButtonType.Camera);
        pictureButton = addButtonWithIcon("compose_toolbar_picture", highIcon: "compose_toolbar_picture_highlighted", tag: ZXComposeToolbarButtonType.Picture);
        mentionButton = addButtonWithIcon("compose_mentionbutton_background", highIcon: "compose_mentionbutton_background_highlighted", tag: ZXComposeToolbarButtonType.Mention);
        trendButton = addButtonWithIcon("compose_trendbutton_background", highIcon: "compose_trendbutton_background_highlighted", tag: ZXComposeToolbarButtonType.Trend);
        emotionButton = addButtonWithIcon("compose_emoticonbutton_background", highIcon: "compose_emoticonbutton_background_highlighted", tag: ZXComposeToolbarButtonType.Emotion);

        
    }
    
    
    func addButtonWithIcon(icon : String? , highIcon : String? , tag : ZXComposeToolbarButtonType?) -> UIButton? {
        
        let button = UIButton();
        button.tag = (tag?.rawValue)!;
        button.addTarget(self, action: #selector(buttonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        button.setImage(UIImage(named: icon!), forState: UIControlState.Normal);
        button.setImage(UIImage(named: highIcon!), forState: UIControlState.Highlighted);
        addSubview(button);
        return button;
        
    }
    
    // button点击方法
    func buttonClick(button : UIButton?) -> Void {
        
        if delegate != nil {
            
            delegate?.composeTool(self, clickedButtonType : ZXComposeToolbarButtonType.init(rawValue: (button?.tag)!));
        }
        
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        let count = self.subviews.count;
        let buttonW = self.frame.size.width / CGFloat(count);
        let buttonH = self.frame.size.height;
        for i in 0..<count {
            
            let button = self.subviews[i] as? UIButton;
            let buttonY = CGFloat(0);
            let buttonX = CGFloat(i) * buttonW;
            button?.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
