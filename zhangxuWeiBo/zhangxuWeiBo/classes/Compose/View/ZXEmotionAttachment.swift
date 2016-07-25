//
//  ZXEmotionAttachment.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/25.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXEmotionAttachment: NSTextAttachment {
    
    var emotion : ZXEmotion? {
        
        didSet {
            
            let imageName = String(format: "%@/%@" , (emotion?.directory)! , (emotion?.png)!);
            image = UIImage(named: imageName);

        }
    };
    
   
}
