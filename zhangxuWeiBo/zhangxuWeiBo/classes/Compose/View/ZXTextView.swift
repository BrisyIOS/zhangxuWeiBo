//
//  ZXTextView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/25.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXTextView: UITextView {

    
    var placehoder : String? {
        
        didSet {
            
            // 设置文字
            self.placehoderLabel?.text = placehoder;
            
            if placehoderLabel?.text == nil {
                
                return;
            }
            
            
            // 重新计算子控件的frame
            setNeedsLayout();
            
        }
    };
    var placehoderColor : UIColor? {
        
        didSet {
            
            // 设置颜色
            self.placehoderLabel?.textColor = placehoderColor;

        }
    };
    private var placehoderLabel : UILabel?;
    // 监听内部文字的改变
    override var text: String! {
        
        didSet {
            
            
            textDidChange();
        }
    }
    
    override var font: UIFont? {
        
        didSet {
            
            self.placehoderLabel?.font = font;
            // 重新计算子控件的frame
            setNeedsLayout();

            
        }
    }
    
    override var attributedText: NSAttributedString! {
        
        didSet {
            
            textDidChange();
        }
    }
    
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        
        super.init(frame: frame, textContainer: textContainer);
        // 清空颜色
        backgroundColor = UIColor.clearColor();
        // 添加一个显示提醒文字的label（显示占位文字的label）
        placehoderLabel = UILabel();
        placehoderLabel?.numberOfLines = 0;
        placehoderLabel?.backgroundColor = UIColor.clearColor();
        addSubview(placehoderLabel!);

        // 设置颜色的占位文字颜色
        placehoderLabel?.textColor = UIColor.lightGrayColor();
        // 设置默认的字体
        font = UIFont.systemFontOfSize(14);
        
        // 监听文字改变
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(textDidChange), name: UITextViewTextDidChangeNotification, object: self);

    }
    
    
    func textDidChange() -> Void {
        
        placehoderLabel?.hidden = hasText();
       
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews();
        
        let placehoderLabelX = CGFloat(5);
        let placehoderLabelY = CGFloat(8);
        let placehoderLabelW = self.frame.size.width - 2 * placehoderLabelX;
        let maxSize = CGSizeMake(placehoderLabelW, CGFloat(MAXFLOAT));
        let placeAttrs = [String : AnyObject]();
        let placehoderLabelRect = (placehoder! as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: placeAttrs, context: nil);
        let placehoderLabelH = placehoderLabelRect.size.height;
        placehoderLabel?.frame = CGRectMake(placehoderLabelX, placehoderLabelY, placehoderLabelW, placehoderLabelH);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
