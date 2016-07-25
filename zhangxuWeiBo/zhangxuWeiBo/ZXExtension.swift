//
//  ZXExtension.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/16.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit



// UIImage的延展
extension UIImage {
    
    // 剪切图片
    class func resizableImage(name : String?) -> UIImage? {
        
        return resizableImage(name!, leftRatio: 0.5, topRatio: 0.5);
    }
    
    
    class func resizableImage(name : String? , leftRatio : CGFloat? , topRatio : CGFloat?) -> UIImage? {
        
        let image = UIImage(named: name!);
        if image == nil {
            
            return nil;
        }
        let left = (image?.size.width)! * leftRatio!;
        let top = (image?.size.height)! * topRatio!;
        return image?.stretchableImageWithLeftCapWidth(NSInteger(left), topCapHeight: NSInteger(top));

    }
}


// NSDate的延展
extension NSDate {
    
    
    // 是否为今天
    func isToday() -> Bool? {
        // 创建日历对象
        let calendar = NSCalendar.currentCalendar();
        // 利用日期对象获取年月日
        let unitFlags: NSCalendarUnit = [.Day , .Month , .Year];
        // 获取当前时间的年月日
        let nowComponents = calendar.components(unitFlags, fromDate: NSDate());
        // 获得self的年月日
        let selfComponents = calendar.components(unitFlags, fromDate: self);
        return Bool(selfComponents.year == nowComponents.year) &&
            (selfComponents.month == nowComponents.month) &&
            (selfComponents.day == nowComponents.day);
        
    }
    
    // 是否为昨天
    func isYesterday() -> Bool? {
        
        let nowDate = NSDate().dateWithYMD();
        let selfDate = dateWithYMD();
        // 获得nowDate和selfDate的差距
        let calcendar = NSCalendar.currentCalendar();
        let components = calcendar.components(NSCalendarUnit.Day, fromDate: selfDate!, toDate: nowDate!, options: NSCalendarOptions.WrapComponents);
        return components.day == 1;

    }
    
    
    func dateWithYMD() -> NSDate? {
        
        let formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy-MM-dd";
        let selfStr = formatter.stringFromDate(self);
        return formatter.dateFromString(selfStr);

    }
    
    // 是否为今年
    func isThisYear() -> Bool? {
        // 创建日期对象
        let calendar = NSCalendar.currentCalendar();
        // 利用日期对象获取年月日
        let unitFlags = NSCalendarUnit.Year;
        // 获得当前时间的年月日
        let nowComponents = calendar.components(unitFlags, fromDate: NSDate());
        // 获得self的年月日
        let selfComponents = calendar.components(unitFlags, fromDate: self);
        return nowComponents.year == selfComponents.year;
    }
    
    // 与现在的时间差
    func deltaWithNow() -> NSDateComponents? {
        // 创建日历对象
        let calendar = NSCalendar.currentCalendar();
        // 利用日历获取时分秒
        let unitFlags : NSCalendarUnit = [.Hour , .Minute , .Second];
        return calendar.components(unitFlags, fromDate: self, toDate: NSDate(), options: NSCalendarOptions.WrapComponents);
    }
    
}


// UIBarButtonItem 的延展
extension UIBarButtonItem {
    
    // 快速创建UIBarButtonItem
    class func itemWithImage(imageName : String , highImageName : String , target : AnyObject? , action : Selector) -> AnyObject? {
        
        // 创建按钮对象
        let btn = UIButton();
        // 设置普通状态下的背景图片
        btn.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal);
        // 设置高亮状态下的背景图片
        btn.setBackgroundImage(UIImage(named: highImageName), forState: UIControlState.Highlighted);
        // 获取图片的尺寸
        let size = btn.currentBackgroundImage?.size;
        // 设置按钮的尺寸
        btn.bounds.size = size!;
        // 监听按钮点击
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside);
        // 返回item
        return UIBarButtonItem.init(customView: btn);
        
    }
}


// 字符串的延展，主要是扩充一些与表情有关的接口
extension NSString {
    
    class func EmojiCodeToSymbol(c : Int64?) -> Int64? {
        
    
        return ((((0x808080F0 | (c! & 0x3F000) >> 4) | (c! & 0xFC0) << 10) | (c! & 0x1C0000) << 18) | (c! & 0x3F) << 24);
        
    }
    
    class func emojiWithIntCode(code : Int64?) -> String? {
      
        var symbol = EmojiCodeToSymbol(code!);
        var string = NSString.init(bytes: &symbol, length: sizeof(NSInteger), encoding: NSUTF8StringEncoding);
        if string == nil {
            
            string = NSString(format: "%C" , code!);
        }

        return string as? String;
    }
    
    class func emojiWithStringCode(stringCode : String?) -> String? {
        
        let stringCode = stringCode?.cStringUsingEncoding(NSUTF8StringEncoding);
        let code = strtoll(stringCode!, nil , 16);
        
        return emojiWithIntCode(code);
    }
    
    // 判断是否是 emoji表情
    func isEmoji() -> Bool? {
        
        var returnValue : Bool = false;
        let hs = characterAtIndex(0);
        if 0xd800 <= hs && hs <= 0xdbff {
            
            if self.length > 1 {
                
                let ls = characterAtIndex(1);
                let mc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00);
                let uc = UInt32.init(mc) + UInt32.init(0x10000)
                if 0x1d000 <= uc && uc <= 0x1f77f {
                    
                    returnValue = true;
                    
                }
               
            }
            
        } else if self.length > 1 {
            
            let ls = characterAtIndex(1);
            if (ls == 0x20e3) {
            
                returnValue = true;
            }
            
        } else {
            
            if 0x2100 <= hs && hs <= 0x27ff {
                
                returnValue = true;
                
            } else if 0x2B05 <= hs && hs <= 0x2b07 {
                
                returnValue = true;
                
            } else if 0x2934 <= hs && hs <= 0x2935 {
                
                returnValue = true;
                
            } else if 0x3297 <= hs && hs <= 0x3299 {
                
                returnValue = true;
                
            } else if hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 {
                
                returnValue = true;
                
            }
        }
        
        
        return returnValue;

    }
    
}
