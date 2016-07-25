//
//  ZXWebView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import AFNetworking

class ZXWebView: UIView , UIWebViewDelegate {

   
    var webView : UIWebView!;
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        // 创建webView
        webView = UIWebView(frame: frame);
        // 设置代理
        webView.delegate = self;
        // 请求路径(传入ZXAppKey,ZXRedirectURL)
        let url = String(format: "https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", ZXAppKey, ZXRedirectURL);
        // 创建请求对象,设置缓存策略
        let request = NSMutableURLRequest.init(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10);
        // 发送请求
        webView.loadRequest(request);
        // 添加webView
        addSubview(webView);
       
    }
    
    // 开始加载webview
    func webViewDidStartLoad(webView: UIWebView) {
        
        MBProgressHUD.showMessage("loading...", toView: self);
        
    }
    
    // webView加载完毕
    func webViewDidFinishLoad(webView: UIWebView) {
        
        MBProgressHUD.hideHUDForView(self, animated: true);
    }
    
    // webView加载失败
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        MBProgressHUD.hideHUDForView(self, animated: true);
    }
    
    
    // 每当发送请求的时候回调一次这个方法
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 获得请求路径
        let url = request.URL?.absoluteString;
        // 检测URL是否为回调地址(包含了"code=")
        let range = url?.rangeOfString("code=");
        // 如果range不为空，则截取code后面的内容
        if range != nil {
            // 截取code后面的内容
            let code = url?.substringFromIndex((range?.endIndex)!);
            // 访问授权标记
            accessTokenWithCode(code);
            // 禁止加载回调页面
            return false;
        }
       
        return true;
    }
    
    
    func accessTokenWithCode(code : String?) -> Void {
        
        // 封装请求参数
        let param = ZXAccessTokenParam();
        param.client_id = ZXAppKey;
        param.client_secret = ZXAppSecret;
        param.grant_type = "";
        param.code = code;
        param.redirect_uri = ZXRedirectURL;
        
        // 获取accessToken
        ZXAccountManager.accessTokenWithParam(param, success: { (result) in
            // 将accessToken数据归档
            print(result.access_token);
            ZXAccountManager.saveAccount(result);
            // 切换控制器
            ZXChooseVc.chooseRootViewController();
            
            }) { (error) in
                
                print("请求失败");
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
