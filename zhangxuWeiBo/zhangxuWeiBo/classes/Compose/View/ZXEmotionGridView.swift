//
//  ZXEmotionGridView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/26.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionGridView: UIView {

    
    var emotions : NSArray? {
        
        didSet {
            
           
            // 添加表情
            let count = (emotions?.count)!;
            
            let currentEmotionViewCount = (emotionViews?.count)!;
            for i in 0..<count {
                
                var emotionView : ZXEmotionView?;
                if i >= currentEmotionViewCount {
                    
                    emotionView = ZXEmotionView();
                    emotionView?.addTarget(self, action: #selector(emotionClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
                    addSubview(emotionView!);
                    emotionViews?.addObject(emotionView!);
                } else {
                    
                    emotionView = emotionViews![i] as? ZXEmotionView;
                }
                
                // 传递模型数据
                emotionView?.emotion = emotions![i] as? ZXEmotion;
                emotionView?.hidden = false;
                
            }
            
            // 隐藏多余的emotionView
            if currentEmotionViewCount > count {
                
                for i in count..<currentEmotionViewCount {
                    
                    let emotionView = emotionViews![i] as? ZXEmotionView;
                    emotionView?.hidden = true;
                }
            }
        }
       
    };
    private var deleteButton : UIButton?;
    lazy var emotionViews : NSMutableArray? = {
        
        let emotionViews = NSMutableArray();
        return emotionViews;
        
    }();
   
    private var popView : ZXEmotionPopView? {
        
        didSet {
            

            if popView == nil {
                
                popView = ZXEmotionPopView();
                
            }
        }
    };
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        // 添加删除按钮
        deleteButton = UIButton();
        deleteButton?.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal);
        deleteButton?.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted);
        deleteButton?.addTarget(self, action: #selector(deleteClick), forControlEvents: UIControlEvents.TouchUpInside);
        addSubview(deleteButton!);
        
        // 给自己添加一个长按手势
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPress(_:)));
        addGestureRecognizer(longPress);

    }
    
    
    func emotionClick(emotionView : ZXEmotionView?) -> Void {
       
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64.init(UInt64.init(0.25) * NSEC_PER_SEC)), dispatch_get_main_queue()) { 
            
            self.selecteEmotion(emotionView?.emotion);
        }

    }
    
    
    func longPress(longPress : UILongPressGestureRecognizer?) -> Void {
        
        // 捕获触控点
        let point = longPress?.locationInView(longPress?.view);
        // 检测触摸点落在哪个表情上
        let emotionView = emotionViewWithPoint(point);
        if longPress?.state == UIGestureRecognizerState.Ended {
            
            // 移除表情弹出控件
            self.popView?.dismiss();
            // 选中表情
            selecteEmotion(emotionView?.emotion);
            
        } else {
            
            self.popView?.showFromEmotionView(emotionView);
        }
    }
    
    
    func selecteEmotion(emotion : ZXEmotion?) -> Void {
    
        // 保存使用记录
        ZXEmotionManager.addRecentEmotion(emotion);
        // 发出一个选中表情的通知
        NSNotificationCenter.defaultCenter().postNotificationName(ZXEmotionDidSelectedNotification, object: nil, userInfo: [ZXSelectedEmotion : emotion!]);
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func deleteClick() -> Void {
        
        // 发出一个选中表情的通知
        NSNotificationCenter.defaultCenter().postNotificationName(ZXEmotionDidSelectedNotification, object: nil, userInfo: nil);

    }
    
    // 根据触摸点返回对应的表情控件
    func emotionViewWithPoint(point : CGPoint?) -> ZXEmotionView? {
        
        var foundEmotionView : ZXEmotionView?;
        self.emotionViews?.enumerateObjectsUsingBlock({ (emotionView, idx, stop) in
            
            if CGRectContainsPoint(emotionView.frame, point!) && emotionView.hidden == false {
                
                foundEmotionView = emotionView as? ZXEmotionView;
               
            }
        })
        
        return foundEmotionView;
        
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        let leftInset = CGFloat(15);
        let topInset = CGFloat(15);
        
        // 排序所有表情
        let count = self.emotionViews?.count;
        let emotionViewW = (self.frame.size.width - 2 * leftInset) / CGFloat(kEmotionMaxCols);
        let emotionViewH = (self.frame.size.height - topInset) / CGFloat(kEmotionMaxRows);
        print(count);
        for i in 0..<count! {
            
            let emotionView = self.emotionViews![i] as? ZXEmotionView;
            let emotionViewX = leftInset + CGFloat(i % kEmotionMaxCols) * emotionViewW;
            let emotionViewY = topInset + CGFloat(i / kEmotionMaxCols) * emotionViewH;
            emotionView?.frame = CGRectMake(emotionViewX, emotionViewY, emotionViewW, emotionViewH);
            
        }
        
        // 删除按钮
        let deleteButtonW = emotionViewW;
        let deleteButtonH = emotionViewH;
        let deleteButtonX = self.frame.size.width - leftInset - deleteButtonW;
        let deleteButtonY = self.frame.size.height - deleteButtonH;
        deleteButton?.frame = CGRectMake(deleteButtonX, deleteButtonY, deleteButtonW, deleteButtonH);
        
    }
    

}
