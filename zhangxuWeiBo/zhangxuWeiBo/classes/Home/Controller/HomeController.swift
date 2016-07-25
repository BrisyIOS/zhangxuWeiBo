//
//  HomeController.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    var titleButton : ZXTitleButton?;
    lazy var statusFrames : NSMutableArray? = {
        
        let statusFrames = NSMutableArray();
        return statusFrames;
    }();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置navigationBar不透明
        self.navigationController?.navigationBar.translucent = false;
        self.edgesForExtendedLayout = UIRectEdge.None;
        
        // 设置导航栏内容
        setupNav();
      
        // 添加刷新控件
        setupRefresh();
        
    }
    
    
    // 添加刷新控件
    func setupRefresh() -> Void {
        
        // 添加下拉刷新控件
        let header = MJRefreshNormalHeader();
        header.setRefreshingTarget(self, refreshingAction: #selector(loadNewStatus));
        self.tableView.mj_header = header;
        self.tableView.mj_header.beginRefreshing();
    
        // 添加上啦刷新控件
        let footer = MJRefreshAutoNormalFooter();
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreStatus));
        self.tableView.mj_footer = footer;
        // 设置tableView的背景颜色
        self.tableView.backgroundColor = RGB(219, g: 219, b: 219);
        // 设置tableview的分割线样式
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        // 添加底部的额外区域
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CGFloat(8), 0);
       
    }
    
    // 下拉刷新新微博
    func loadNewStatus() -> Void {
        
        
        // 清空badgeValue
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0;
        // 封装请求参数
        let param = ZXHomeStatusParam.param() as!ZXHomeStatusParam;
        // 取出最前面的那条微博
        let frame = statusFrames?.firstObject as?ZXStatusFrame;
       
        if ((frame) != nil) {
            
            param.since_id = NSNumber.init(integer: ((frame?.status?.idstr)! as NSString).integerValue);
        }

        // 获得微博数据
        ZXStatusManager.homeStatusesWithParam(param, success: { (result) in
            
            let newFrames = NSMutableArray();
          
            for status in result.statuses! {
                
                let frame = ZXStatusFrame();
                frame.status = status as? ZXStatus
                newFrames.addObject(frame);
                
            }
            
            // 创建一个临时数组
            let tempFrames = NSMutableArray();
            // 添加最新的模型数据
            tempFrames.addObjectsFromArray(newFrames as [AnyObject]);
            // 追加以前的旧模型数据
            tempFrames.addObjectsFromArray(self.statusFrames! as [AnyObject]);
            self.statusFrames = tempFrames;
            // 刷新表格
            self.tableView.reloadData();
            // 停止刷新表格
            self.tableView.mj_header.endRefreshing();
            // 显示最新微博的数量
            self.showNewStatusCount(result.statuses?.count);

         
            }) { (error) in
                
                print(error);
                self.tableView.mj_header.endRefreshing();
        }
    }
    
    
    func showNewStatusCount(count : NSInteger?) -> Void {
        
       
        // 1.创建label
        let label = UILabel();
        label.textAlignment = NSTextAlignment.Center;
        label.textColor = UIColor.whiteColor();
        label.backgroundColor = UIColor.init(patternImage: UIImage(named: "timeline_new_status_background")!);
        self.navigationController!.view.addSubview(label);
        // 添加label到navigationBar的下面
        self.navigationController?.view.insertSubview(label, belowSubview: (self.navigationController?.navigationBar)!);
        // 设置文字
        if count != 0 {
            
            label.text = String(format: "共有%d条新的微博数据" , count!);
        } else {
            
            label.text = "没有新的微博数据";
        }
        
        // 计算位置
        let labelW = self.navigationController?.view.frame.width;
        let labelH = CGFloat(35);
        let labelX = CGFloat(0);
        let labelY = CGFloat(64) - labelH;
        label.frame = CGRectMake(labelX, labelY, labelW!, labelH);
        label.alpha = 1.0;
        
        // 让label慢慢下来
        UIView.animateWithDuration(0.5, animations: { 
            
                // 往下移动一个label的高度
            label.transform = CGAffineTransformMakeTranslation(0, labelH)
            }) { (finished) in
                
                // 颜值一段时间之后，让label慢慢回去
                UIView.animateWithDuration(0.5, delay: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: { 
                    
                        // label回到原来的位置
                    label.transform = CGAffineTransformIdentity;
                    // 让透明度慢慢变为0；
                    label.alpha = 0.0;
                    }, completion: { (finished) in
                        // 将label从父控件中移除
                        label.removeFromSuperview();
                })
        }
    }
    
    // 上啦刷新更多微博
    func loadMoreStatus() -> Void {
        
        // 1.封装请求参数
        let param = ZXHomeStatusParam.param() as?ZXHomeStatusParam;
        // 取出最后面的那条微博
        let frame = statusFrames?.lastObject as?ZXStatusFrame;
        if frame != nil {
            
            param?.max_id = NSNumber.init(integer: ((frame?.status?.idstr)! as NSString).integerValue - 1);
            
            
        }
        
        // 加载更多的微博数据
        ZXStatusManager.homeStatusesWithParam(param, success: { (result) in
            
            let newFrames = NSMutableArray();
            for status in result.statuses! {
                
                let frame = ZXStatusFrame();
                frame.status = status as? ZXStatus;
                newFrames.addObject(frame);
            }
            
            // 添加最新的模型数据
            self.statusFrames?.addObjectsFromArray(newFrames as [AnyObject]);
            
            // 刷新表格
            self.tableView.reloadData();
            // 停止刷新
            self.tableView.mj_footer.endRefreshing();
            
            
            }) { (error) in
                
                print(error);
                print("请求失败");
                // 请求失败，停止刷新
                self.tableView.mj_footer.endRefreshing();
        }

    }
    
    
    // 设置导航栏内容
    func setupNav() -> Void {
        
        let name = ZXAccountManager.account()?.name;
        if (name != nil) {
            
            self.titleButton?.setTitle(name, forState: UIControlState.Normal);
        } else {
            
            self.titleButton?.setTitle("首页", forState: UIControlState.Normal);
        }
        
        self.titleButton?.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal);
        self.titleButton?.bounds.size.height = CGFloat(38);
        self.titleButton?.addTarget(self, action: #selector(titleButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside);
        self.navigationItem.titleView = self.titleButton;
        
        // 设置左右的按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWithImage("navigationbar_friendsearch", highImageName: "navigationbar_friendsearch_highlighted", target: self, action: #selector(friendSearch)) as? UIBarButtonItem;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.itemWithImage("navigationbar_pop", highImageName: "navigationbar_pop_highlighted", target: self, action: #selector(pop)) as? UIBarButtonItem;

    }
    
    
    func friendSearch() -> Void {
        
        print("friendSearch");
    }
    
    
    func pop() -> Void {
        
        print("pop");
    }
    
    func titleButtonClick(button : ZXTitleButton?) -> Void {
        
        
    }
    
    
    // 返回多少分区
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1;
    }
    
    // 返回多行
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.statusFrames?.count)!;
    }
    
    // 返回cell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = ZXStatusCell.cellWithTableView(tableView) as! ZXStatusCell;
        cell.statusFrame = self.statusFrames![indexPath.row] as?ZXStatusFrame;
        
        return cell;

    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       
        let frame = statusFrames![indexPath.row] as? ZXStatusFrame;
        
        if frame == nil {
            
            return 0;
        }
        
        return (frame!.cellHeight)!;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
