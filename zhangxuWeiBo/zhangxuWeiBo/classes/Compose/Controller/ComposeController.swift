//
//  ComposeController.swift
//  zhangxuWeiBo
//
//  Created by zhangxu on 16/6/11.
//  Copyright © 2016年 zhangxu. All rights reserved.
//

import UIKit

class ComposeController: UIViewController , UITextViewDelegate , ZXComposeToolbarDelegate , UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var textView : ZXEmotionTextView?;
    var isChangingKeyboard : Bool?;
    var toolbar : ZXComposeToolbar?;
    var photosView : ZXComposePhotosView?;
    var keyboard : ZXEmotionKeyboard? {
        
        get {
            
            var newKeyboard : ZXEmotionKeyboard?;
            newKeyboard = ZXEmotionKeyboard.keyboard() as? ZXEmotionKeyboard;
            let keyboardW = kScreenWidth;
            let keyboardH = CGFloat(216);
            newKeyboard?.frame = CGRectMake(0, 0, keyboardW, keyboardH);
            
            return newKeyboard;
        }
    };
    
    deinit {
        // 删除通知
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置navigationBar
        setupNavBar();
        
        // 设置输入控件
        setupTextView();
        
        // 设置toolbar
        setupToolbar();
        
        // 监听表情选中的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(emotionDidSelected(_:)), name: ZXEmotionDidSelectedNotification, object: nil);
        
        // 监听删除按钮点击的通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(emotionDidDeleted(_:)), name: ZXEmotionDidDeletedNotification, object: nil);

        // Do any additional setup after loading the view.
    }
    
    // 监听表情选中的通知
    func emotionDidSelected(notification : NSNotification?) -> Void {
        
        
        let emotion = notification?.userInfo![ZXSelectedEmotion] as? ZXEmotion;
       
        // 拼接表情
        textView?.appendEmotion(emotion);
        
        // 检测文字长度
        textViewDidChange(textView!);
       
    }
    
    // 监听表情删除的通知
    func emotionDidDeleted(notification : NSNotification?) -> Void {
        
        // 往回删
        textView?.deleteBackward();

    }
    
    
    // 设置navigationBar
    func setupNavBar() -> Void {
        
        let name = ZXAccountManager.account()?.name;
        if name != nil {
            
            // 构建文字
            let prefix = "发微博";
            let text = String(format: "%@\n%@" , prefix , name!);
            let string = NSMutableAttributedString.init(string: text);
            string.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(15), range: (text as NSString).rangeOfString(name!));
            // 创建label
            let titleLabel = UILabel();
            titleLabel.attributedText = string;
            titleLabel.numberOfLines = 0;
            titleLabel.textAlignment = NSTextAlignment.Center;
            let titleLabelW = CGFloat(100);
            let titleLabelH = CGFloat(44);
            titleLabel.bounds = CGRectMake(0, 0, titleLabelW, titleLabelH);
            self.navigationItem.titleView = titleLabel;
            
        } else {
            
            self.title = "发微博";
        }
        
        self.view.backgroundColor = UIColor.whiteColor();
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.Bordered, target: self, action: #selector(cancel));
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发送", style: UIBarButtonItemStyle.Bordered, target: self, action: #selector(send));
        self.navigationItem.rightBarButtonItem?.enabled = false;


    }
    
    // 取消发微博
    func cancel() -> Void {
        
        dismissViewControllerAnimated(true, completion: nil);
    }
    
    // 发微博
    func send() -> Void {
        
        
    }
    
    
    // 设置输入控件
    func setupTextView() -> Void {
        
        // 创建输入控件
        textView = ZXEmotionTextView();
        textView?.alwaysBounceVertical = true;
        textView?.frame = self.view.bounds;
        textView?.delegate = self;
        self.view.addSubview(textView!);
        
        
        // 设置提醒文字
        textView?.placehoder = "分享新鲜事...";
        // 设置字体
        textView?.font = UIFont.systemFontOfSize(15);
        // 监听键盘
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil);

    }
    
    // 视图已经出现的时候叫出键盘
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated);
        
        // 成为第一响应者（叫出键盘）
        self.textView?.becomeFirstResponder();

    }
    
    // 开始拖拽的时候打开编辑
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        self.view.endEditing(true);
    }
    
    
    func textViewDidChange(textView: UITextView) {
        print(textView.attributedText);
        self.navigationItem.rightBarButtonItem?.enabled = textView.hasText();
    }
    
    
    // 添加工具条
    func setupToolbar() -> Void {
        
        // 1.创建
        toolbar = ZXComposeToolbar();
        toolbar?.delegate = self;
        self.view.addSubview(toolbar!);
        // 设置frame
        let toolbarW = kScreenWidth;
        let toolbarH = CGFloat(44);
        let toolbarX = CGFloat(0);
        let toolbarY = kScreenHeight - toolbarH;
        toolbar?.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);


    }
    
    // 键盘将要弹出的时候调用此方法
    func keyboardWillShow(notification : NSNotification?) -> Void {
        
        // 键盘弹出需要的时间
        let duration = notification?.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue;
        // 动画
        UIView.animateWithDuration(duration!) { 
            
            // 取出键盘高度
            let keyboardF = notification?.userInfo![UIKeyboardFrameEndUserInfoKey]?.CGRectValue();
            let keyboardH = keyboardF?.size.height;
            self.toolbar?.transform = CGAffineTransformMakeTranslation(0, -keyboardH!);
            
        }

    }
    
    // 键盘将要掩藏的时候会调用此方法
    func keyboardWillHide(notification : NSNotification?) -> Void {
        
        if self.isChangingKeyboard == true {
            
            return;
        }
        
        // 键盘弹出需要的时间
        let duration = notification?.userInfo![UIKeyboardAnimationDurationUserInfoKey]?.doubleValue;
    
        // 动画
        UIView.animateWithDuration(duration!) {
            
            self.toolbar?.transform = CGAffineTransformIdentity;
        }

    }
    
    
    func composeTool(toolbar: ZXComposeToolbar?, clickedButtonType: ZXComposeToolbarButtonType?) {
        
        
        switch clickedButtonType! {
        case .Camera:
            
            openCamera();
            
        case .Picture:
            
            openAlbum();
            
        case .Emotion:
            
            openEmotion();
            
        default:
            
            break;
        }

    }
    
    // 打开相机
    func openCamera() -> Void {
        
        
    }
    
    // 打开相册
    func openAlbum() -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == false {
            
            return;
        }
        
        let ipc = UIImagePickerController();
        ipc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        ipc.delegate = self;
        presentViewController(ipc, animated: true, completion: nil);
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        picker.dismissViewControllerAnimated(true, completion: nil);
        // 取出选中的图片
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        // 添加到图片到相册中
        self.photosView?.addImage(image);

    }
    
    // 打开表情
    func openEmotion() -> Void {
        
        // 正在切换键盘
        self.isChangingKeyboard = true;
        
        if ((self.textView?.inputView) != nil) {
            
            self.textView?.inputView = nil;
            
            // 显示表情图片
            self.toolbar?.isShowEmotionButton = true;
        } else {
            
            self.textView?.inputView = self.keyboard;
            
            // 不显示表情图片
            self.toolbar?.isShowEmotionButton = false;
        }
        
        // 关闭键盘
        self.textView?.resignFirstResponder();
        self.isChangingKeyboard = false;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __int64_t.init(Int64.init(0.1) * Int64.init(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            
            // 打开键盘
            self.textView?.becomeFirstResponder();
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
}
