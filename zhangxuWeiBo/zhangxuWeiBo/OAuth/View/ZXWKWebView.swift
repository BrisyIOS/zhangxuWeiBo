//
//  ZXWKWebView.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit
import WebKit

@available(iOS 8.0, *)
class ZXWKWebView: UIView , WKNavigationDelegate {
    
    var webView : WKWebView!;
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        
        let configuration = WKWebViewConfiguration();
        webView = WKWebView.init(frame: frame, configuration: configuration);
        webView.navigationDelegate = self;
        let url = String(format: "https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", ZXAppKey, ZXRedirectURL);
        let request = NSMutableURLRequest.init(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.UseProtocolCachePolicy, timeoutInterval: 10);
        webView.loadRequest(request);
        addSubview(webView);
        
    }
    
    
    // 当开始加载webView的时候会调用此方法
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        // 显示加载状态
        MBProgressHUD.showMessage("loading...", toView: self);
        
    }
    
    // 当webView加载完毕的时候会调用此方法
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        // 影藏加载状态
        MBProgressHUD.hideHUDForView(self, animated: true);
    }
    
    // 当webView加载失败的时候会调用此方法
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        
        // 影藏加载状态
        MBProgressHUD.hideHUDForView(self, animated: true);
    }
    
    // 在发送请求之前决定是否调转
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        // 获得请求路径
        let url = webView.URL?.absoluteString;
        // 检测URL是否为回调地址(包含了"code=")
        let range = url?.rangeOfString("code=");
        // 如果range不为空，则截取code后面的内容
        if range != nil {
            // 截取code后面的内容
            let code = url?.substringFromIndex((range?.endIndex)!);
            // 访问授权标记
            accessTokenWithCode(code);
            // 禁止加载回调页面
            decisionHandler(WKNavigationActionPolicy.Cancel);
        }

        decisionHandler(WKNavigationActionPolicy.Allow);
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
