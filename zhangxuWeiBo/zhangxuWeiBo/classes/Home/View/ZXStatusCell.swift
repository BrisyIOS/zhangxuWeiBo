//
//  ZXStatusCell.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/15.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ZXStatusCell: UITableViewCell {
    
    var topView : ZXStatusTopView?;
    var toolbar : ZXStatusToolbar?;
    
    var statusFrame : ZXStatusFrame? {
        
        didSet {
           
            if statusFrame == nil {
                
                return;
            }
            // 传递数据给topView
            topView?.statusFrame = statusFrame;
            // 设置toolbar的frame
            toolbar?.frame = (statusFrame?.toolbarF)!;
            toolbar?.status = statusFrame?.status;

        }
    };
    
    // 根据cell标记取cell
    class func cellWithTableView(tableView : UITableView?) -> AnyObject? {
        
        let ID = "status";
        var cell = tableView?.dequeueReusableCellWithIdentifier(ID);
        if cell == nil {
            
            cell = ZXStatusCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: ID);
        }
        
        return cell;

    }
    
    // 初始化方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        // 清除cell颜色
        self.backgroundColor = UIColor.clearColor();
        
        // 添加顶部的控件
        setupTopView();
        
        // 添加底部的工具条
        setupToolbar();

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 添加顶部的控件
    func setupTopView() -> Void {
        
        topView = ZXStatusTopView(frame : CGRectZero);
        self.contentView.addSubview(topView!);
    }
    
    // 添加底部的工具条
    func setupToolbar() -> Void {
        
        toolbar = ZXStatusToolbar(frame: CGRectZero);
        self.contentView.addSubview(toolbar!);
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
