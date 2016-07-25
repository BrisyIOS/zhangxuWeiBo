//
//  ZXAccessTokenParam.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXAccessTokenParam: NSObject {
    
    var client_id : String?;// 申请应用是分配的APPKey
    var client_secret : String?;// 申请应用时分配的appSecret
    var grant_type : String?;// 请求类型
    var code : String?;// 调用授权后得到的code值
    var redirect_uri : String?;// 回调地址

}
