//
//  ZXOAuthViewController.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit


class ZXOAuthViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        var webView : UIView!;
        // iOS8之后
        if #available(iOS 8.0, *) {
            
            webView = ZXWKWebView(frame : self.view.bounds);
        
        } else {
            // Fallback on earlier versions
            webView = ZXWebView(frame : self.view.bounds);
            
        };
        
        self.view.addSubview(webView);
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
