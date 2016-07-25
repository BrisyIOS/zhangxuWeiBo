//
//  ZXEmotionTextView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/25.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionTextView: ZXTextView {

    // 拼接表情到最后面
    func appendEmotion(emotion : ZXEmotion?) -> Void {
        
        if ((emotion?.emoji) != nil) {
            // 插入emoji表情
            insertText((emotion?.emoji)!);
        } else {
            // 插入图片表情
            let attributedText = NSMutableAttributedString.init(attributedString: self.attributedText);
            // 创建一个带有图片表情的富文本
            let attach = ZXEmotionAttachment();
            attach.emotion = emotion;
            attach.bounds = CGRectMake(0, -3, (self.font?.lineHeight)!, (self.font?.lineHeight)!);
            let attachString = NSAttributedString.init(attachment: attach);
            // 记录表情的插入位置
            let insertIndex = self.selectedRange.location;
            // 插入表情图片到光标的位置
            attributedText.insertAttributedString(attachString, atIndex: insertIndex);
            // 设置字体
            let range = NSMakeRange(0 , attributedText.length);
            attributedText.addAttribute(NSFontAttributeName, value: self.font!, range: range);
            // 重新赋值，光标会自动移动到文字的最后面
            self.attributedText = attributedText;
            // 让光标会到表情后面的位置
            self.selectedRange = NSMakeRange(insertIndex + 1, 0);
        }
    }
    
    // 具体的文字内容
    func realText() -> String? {
        
        // 用来拼接所有文字
        let string = NSMutableString();
        // 遍历富文本里面的所有内容
        self.attributedText.enumerateAttributesInRange(NSMakeRange(0, self.attributedText.length), options: NSAttributedStringEnumerationOptions.Reverse) { (attrs, range, stop) in
            
            let attach = attrs["NSAttachment"];
            if attach != nil {
                // 富文本
                string.appendString(attach!.emotion!!.chs!);
                
            } else {
                // 普通文本
                let subStr = self.attributedText.attributedSubstringFromRange(range).string;
                string.appendString(subStr);
            }
        }
        
        return string as String;

    }
    
    
}
