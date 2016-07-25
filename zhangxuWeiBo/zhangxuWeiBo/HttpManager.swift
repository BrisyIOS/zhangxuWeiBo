//
//  HttpManager.swift
//  JingChengRestaurant-Swift
//
//  Created by zhangxu on 16/7/23.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import AFNetworking

// 定义枚举类型
enum RequestType : String {
    case GET = "GET"
    case POST = "POST"
}

class HttpManager: AFHTTPSessionManager {
    
    // let是线程安全的
    static let shareInstance : HttpManager = {
        let tools = HttpManager()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    
}

extension HttpManager {
    
    func request(methodType : RequestType, urlString : String, parameters : NSMutableDictionary?, finished : (result : AnyObject?, error : NSError?) -> ()) {
        
        // 1.定义成功的回调闭包
        let successCallBack = { (task : NSURLSessionDataTask, result : AnyObject?) -> Void in
            finished(result: result, error: nil)
        }
        
        // 2.定义失败的回调闭包
        let failureCallBack = { (task : NSURLSessionDataTask?, error : NSError) -> Void in
            finished(result: nil, error: error)
        }
        
        // 3.发送网络请求
        if methodType == .GET {
            GET(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        } else {
            POST(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
        
    }
}
