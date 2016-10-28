//
//  ViewController.m
//  FLStatusBarHUD
//
//  Created by clarence on 16/10/28.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "ViewController.h"
#import "FLStatusBarHUD.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *arrM;
@end

@implementation ViewController{
    // 是否手动处理statusBar点击
    BOOL _clicked;
    // 隐藏开启与否
    BOOL _flag;
    // 是否自定义view
    BOOL _selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_flag ? @"关闭自定隐藏" : @"开启自动隐藏" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"实现statusBar点击" style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClick)];
    UIButton *titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [titleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [titleBtn setTitle:@"切换默认view" forState:UIControlStateNormal];
    [titleBtn setTitle:@"切换自定义view" forState:UIControlStateSelected];
    [titleBtn addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.titleView = titleBtn;
    
}

- (void)titleViewClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    _selected = !_selected;
}

- (void)leftItemClick{
    //    [[FLStatusBarHUD shareStatusBar] fl_hide];
    _clicked = !_clicked;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:!_clicked ? @"实现statusBar点击" : @"不实现statusBar点击" style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClick)];
}

- (void)rightItemClick{
    _flag = !_flag;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:_flag ? @"关闭自定隐藏" : @"开启自动隐藏" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
}

#pragma mark - Table view data source & delegate
static NSString * resueId = @"cell";

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrM.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resueId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resueId];
    }
    cell.textLabel.text = self.arrM[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FLAnimationDirection type = FLAnimationDirectionFromTop;
    if (indexPath.row == 4) {
        //        [[FLStatusBarHUD shareStatusBar] fl_hide];
        [[FLStatusBarHUD shareStatusBar] fl_reset];
        return;
    }
    else if (indexPath.row == 5){
        [FLStatusBarHUD shareStatusBar].statusBarHeight = 64;
        [FLStatusBarHUD shareStatusBar].messageDuration = 5;
        [FLStatusBarHUD shareStatusBar].messageColor = [UIColor redColor];
        [FLStatusBarHUD shareStatusBar].messageFont = [UIFont systemFontOfSize:16];
        [[FLStatusBarHUD shareStatusBar] fl_showSuccess:@"成功啦" atView:self.view autoDismiss:_flag];
        [FLStatusBarHUD shareStatusBar].position = CGPointMake(0, 64);
        
        return;
    }
    else if (indexPath.row == 6){
        [[FLStatusBarHUD shareStatusBar] fl_showError:@"失败啦" autoDismiss:_flag];
        [FLStatusBarHUD shareStatusBar].statusBarHeight = 64;
        [FLStatusBarHUD shareStatusBar].messageDuration = 2;
        [FLStatusBarHUD shareStatusBar].messageColor = [UIColor greenColor];
        [FLStatusBarHUD shareStatusBar].messageFont = [UIFont systemFontOfSize:12];
        
        return;
    }
    else if (indexPath.row == 7){
        [[FLStatusBarHUD shareStatusBar] fl_showLoading:@""];
        [FLStatusBarHUD shareStatusBar].activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        return;
    }
    else if (indexPath.row == 8){
        [FLStatusBarHUD shareStatusBar].activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        [[FLStatusBarHUD shareStatusBar] fl_showLoading:@"加载中。。。"];
        [FLStatusBarHUD shareStatusBar].backgroundColor = [UIColor grayColor];
        return;
    }
    else if (indexPath.row == 9){
        [[FLStatusBarHUD shareStatusBar] fl_showMessage:@"显示消息" autoDismiss:_flag];
        [FLStatusBarHUD shareStatusBar].statusBarHeight = 64;
        return;
    }
    if (!_selected) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        switch (indexPath.row) {
            case 0:{
                view.frame = CGRectMake(0, 64, 100, 44);
                type = FLAnimationDirectionFromTop;
                break;
            }
            case 1:{
                view.frame = CGRectMake(0, 0, 100, 44);
                type = FLAnimationDirectionFromLeft;
                break;
            }
            case 2:{
                view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 44, 100, 44);
                type = FLAnimationDirectionFromBottom;
                break;
            }
            case 3:{
                view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100, 0, 100, 44);
                type = FLAnimationDirectionFromRight;
                break;
            }
        }
        // [UIApplication sharedApplication].keyWindow
        // self.navigationController.navigationBar
        [[FLStatusBarHUD shareStatusBar] fl_showCustomView:view atView:self.view animateDirection:type autoDismiss:_flag];
    }
    else{
        switch (indexPath.row) {
            case 0:{
                type = FLAnimationDirectionFromTop;
                break;
            }
            case 1:{
                type = FLAnimationDirectionFromLeft;
                break;
            }
            case 2:{
                type = FLAnimationDirectionFromBottom;
                break;
            }
            case 3:{
                type = FLAnimationDirectionFromRight;
                break;
            }
        }
        // 必须在show之前设置
        [FLStatusBarHUD shareStatusBar].animationDirection = type;
        [[FLStatusBarHUD shareStatusBar] fl_showMessage:@"默认statusBar显示消息" autoDismiss:_flag];
        [FLStatusBarHUD shareStatusBar].messageDuration = 2;
        [[FLStatusBarHUD shareStatusBar] setBackgroundColor:[UIColor grayColor]];
    }
    
    if (_clicked) {
        // 实现点击
        [FLStatusBarHUD shareStatusBar].statusBarTapOpreationBlock = ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"点我啦" message:nil delegate:nil cancelButtonTitle:@"恩恩~" otherButtonTitles:nil];
            [alertView show];
        };
    }
    else{
        [FLStatusBarHUD shareStatusBar].statusBarTapOpreationBlock = nil;
    }
    
}


- (NSMutableArray *)arrM{
    if (_arrM == nil) {
        _arrM = [NSMutableArray arrayWithObjects:@"动画从上到下",@"动画从左到右",@"动画从下到上",@"动画从右到左",@"隐藏并重置",@"显示成功--默认statusBar,设置position 停留5s",@"显示失败--默认statusBar",@"显示加载中(不带文字)--默认statusBar",@"显示加载中(带文字)--默认statusBar",@"显示消息--默认statusBar", nil];
    }
    return _arrM;
}

@end

