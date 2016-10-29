//
//  FLStatusBar.m
//  logistic
//
//  Created by 孔凡列 on 16/2/24.
//  Copyright © 2016年 clarence All rights reserved.
//

#import "FLStatusBarHUD.h"
#import "UIView+FLUnits.h"

@interface FLStatusBarHUD ()
@property (nonatomic,strong)UIView *statusBar;
@property (nonatomic,assign)NSTimeInterval animationDuration;
@end


@implementation FLStatusBarHUD

#define FLScreenWidth [UIScreen mainScreen].bounds.size.width
#define FLScreenHeight [UIScreen mainScreen].bounds.size.height
#define FLKeyWindow [UIApplication sharedApplication].keyWindow

/*------------------------全局变量-----------------------*/
/** 全局窗口 */
static UIWindow *_window;
/** 全局按钮 */
static UIButton *_button;
/** loading状态下的label */
static UILabel *_loadingLabel;
/** 定时器 */
static NSTimer *_timer;
/** 指示器 */
static UIActivityIndicatorView *_indicatorView;
/** 背景图 */
static UIImageView *_backgroundImageView;
/*------------------------常量-----------------------*/

/** 按钮左边的间距 */
static CGFloat const FLStatusBarImageEdgeLeftInsert = 10;

/** 文字默认的大小*/
static CGFloat const FLStatusBarTitleFontSize = 12;

/** 动画默认执行时间*/
static CGFloat const FLDefaultAnimationDuration = 0.25;

/** statusBar的默认高度*/
static CGFloat const FLDefaultStatusBarHeight = 40;

/** 消息默认停留时间*/
static CGFloat const FLDefaultMessageDuration = 2;

static FLAnimationDirection _currentAnimationDirection;

static CGPoint _currentPosition;


+ (instancetype)shareStatusBar{
    static FLStatusBarHUD *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        // 默认动画时间
        instance.animationDuration = 0.25;
        // 默认消息停留时间
        instance.messageDuration = 2;
        // 默认动画执行方式
        instance.animationDirection = FLAnimationDirectionFromTop;
        // 默认状态栏高度
        instance.statusBarHeight = FLDefaultStatusBarHeight;
    });
    return instance;
}

- (void)fl_showCustomView:(UIView *)customView atView:(UIView *)view animateDirection:(FLAnimationDirection)animationDirection autoDismiss:(BOOL)autoDismiss{
    // 记录动画类型
    _currentAnimationDirection = animationDirection;
    // 先移除上一个
    [self fl_removeStatusBar];
    // 停止定时器
    [self fl_invalidateTimer];
    // 保存CustomView
    _statusBar = customView;
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:customView.bounds];
    [_statusBar insertSubview:_backgroundImageView atIndex:0];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOperation:)];
    [_statusBar addGestureRecognizer:tap];
    
    [view addSubview:customView];
    // 动画执行
    if (self) {
        [self fl_startAnimationDirection:animationDirection autoDismiss:autoDismiss];
    }
}

- (void)fl_showCustomView:(UIView *)customView atView:(UIView *)view autoDismiss:(BOOL)autoDismiss{
    [self fl_showCustomView:customView atView:view animateDirection:self.animationDirection autoDismiss:autoDismiss];
}

//- (void)setAnimationDuration:(NSTimeInterval)animationDuration{
//    _animationDuration = animationDuration;
//}

- (void)setAnimationDirection:(FLAnimationDirection)animationDirection{
    _animationDirection = animationDirection;
    _currentAnimationDirection = animationDirection;
}

- (void)setMessageDuration:(NSTimeInterval)messageDuration{
    _messageDuration = messageDuration;
}

- (void)setMessageColor:(UIColor *)messageColor{
    _messageColor = messageColor;
    [_button setTitleColor:messageColor forState:UIControlStateNormal];
}

- (void)setMessageFont:(UIFont *)messageFont{
    _messageFont = messageFont;
    _button.titleLabel.font = messageFont;
}

- (void)setPosition:(CGPoint)position{
    _position = position;
    if (_statusBar) {
        [self changeDefaultView:_statusBar height:_statusBar.fl_height];
    }
}

//- (CGPoint)position{
//    return _currentPosition;
//}

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    if (_indicatorView) {
        _indicatorView.activityIndicatorViewStyle = activityIndicatorViewStyle;
    }
}

- (void)setStatusBarHeight:(CGFloat)statusBarHeight{
    _statusBarHeight = statusBarHeight;
    if (_statusBar) {
        [self changeDefaultView:_statusBar height:statusBarHeight];
        if (_button) {
            _button.frame = _statusBar.bounds;
        }
        if (_loadingLabel) {
            _loadingLabel.frame = _statusBar.bounds;
            _indicatorView.fl_y = (statusBarHeight - _indicatorView.bounds.size.height) / 2;
        }
        if (_backgroundImageView) {
            _backgroundImageView.frame = _statusBar.bounds;
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _statusBar.backgroundColor = backgroundColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    if (_backgroundImageView) {
        _backgroundImageView.image = backgroundImage;
    }
}

- (NSTimeInterval)animationDuration{
    return FLDefaultAnimationDuration;
}

//- (void)fl_showMessage:(NSString *)message image:(UIImage *)image origin:(CGPoint)origin atView:(UIView *)view autoDismiss:(BOOL)autoDismiss{
//    
//}

- (void)fl_showMessage:(NSString *)message image:(UIImage *)image atView:(UIView *)view autoDismiss:(BOOL)autoDismiss{
    
    UIView *defaultView = [self fl_defaultViewWithAnimateDirection:self.animationDirection ? self.animationDirection : FLAnimationDirectionFromTop];
    //创建按钮
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.titleLabel.font = self.messageFont ? self.messageFont : [UIFont systemFontOfSize:FLStatusBarTitleFontSize];
    [_button setTitle:message forState:UIControlStateNormal];
    [_button setTitleColor:self.messageColor ? self.messageColor : [UIColor blackColor] forState:UIControlStateNormal];
    if (image) {
        [_button setImage:image forState:UIControlStateNormal];
    }
    _button.titleEdgeInsets = UIEdgeInsetsMake(0, FLStatusBarImageEdgeLeftInsert, 0, 0);
    _button.frame = defaultView.bounds;
    _button.userInteractionEnabled = NO;
    [defaultView addSubview:_button];
    
    [self fl_showCustomView:defaultView atView:view autoDismiss:autoDismiss];
}

- (void)fl_showMessage:(NSString *)message image:(UIImage *)image autoDismiss:(BOOL)autoDismiss{
    [self fl_showMessage:message image:image atView:FLKeyWindow autoDismiss:autoDismiss];
}

- (void)fl_showMessage:(NSString *)message autoDismiss:(BOOL)autoDismiss{
    [self fl_showMessage:message image:nil autoDismiss:autoDismiss];
}

- (void)fl_showMessage:(NSString *)message{
    [self fl_showMessage:message autoDismiss:YES];
}

- (void)fl_showSuccess:(NSString *)message atView:(UIView *)view autoDismiss:(BOOL)autoDismiss{
    [self fl_showMessage:message image:[UIImage imageNamed:@"FLStatusBarHUD.bundle/success"] atView:view autoDismiss:autoDismiss];
}

- (void)fl_showSuccess:(NSString *)message autoDismiss:(BOOL)autoDismiss{
    [self fl_showSuccess:message atView:FLKeyWindow autoDismiss:autoDismiss];
}

- (void)fl_showSuccess:(NSString *)message{
    [self fl_showSuccess:message autoDismiss:YES];
}

- (void)fl_showError:(NSString *)message atView:(UIView *)view autoDismiss:(BOOL)autoDismiss{
    [self fl_showMessage:message image:[UIImage imageNamed:@"FLStatusBarHUD.bundle/error"] atView:view autoDismiss:autoDismiss];
}

- (void)fl_showError:(NSString *)message autoDismiss:(BOOL)autoDismiss {
    [self fl_showError:message atView:FLKeyWindow autoDismiss:autoDismiss];
}

- (void)fl_showError:(NSString *)message{
    [self fl_showError:message autoDismiss:YES];
}

- (void)fl_showLoading:(NSString *)message atView:(UIView *)view{
    UIView *defaultView = [self fl_defaultViewWithAnimateDirection:self.animationDirection];
    _loadingLabel = [[UILabel alloc] init];
    _loadingLabel.text = message;
    _loadingLabel.frame = defaultView.bounds;
    _loadingLabel.textAlignment = NSTextAlignmentCenter;
    _loadingLabel.font = [UIFont systemFontOfSize:FLStatusBarTitleFontSize];
    _loadingLabel.textColor = self.messageColor ? self.messageColor : [UIColor blackColor];
    [defaultView addSubview:_loadingLabel];
    
    //创建网络状态指示器
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle ? self.activityIndicatorViewStyle : UIActivityIndicatorViewStyleGray];
    //开启动画
    [_indicatorView startAnimating];
    CGRect frame = _indicatorView.frame;
    if (message && ![message isEqualToString:@""]) {
        CGSize loadingLabelTextSize = [_loadingLabel.text sizeWithAttributes:@{NSFontAttributeName:_loadingLabel.font}];
        frame.origin.x = (FLScreenWidth - loadingLabelTextSize.width) * 0.5 - _indicatorView.frame.size.width - 10;
    }
    else{
        frame.origin.x = (FLScreenWidth - _indicatorView.frame.size.width) / 2;
    }
    frame.origin.y = ((self.statusBarHeight ? self.statusBarHeight : FLDefaultStatusBarHeight) - _indicatorView.bounds.size.height) / 2;
    _indicatorView.frame = frame;
    
    [defaultView addSubview:_indicatorView];
    
    [self fl_showCustomView:defaultView atView:view autoDismiss:NO];
}

- (void)fl_showLoading:(NSString *)message {
    [self fl_showLoading:message atView:FLKeyWindow];
}


/** 隐藏状态栏 */
- (void)fl_hide {
    if (_indicatorView) {
        //开启动画
        [_indicatorView stopAnimating];
    }
    if (_statusBar) {
        [UIView animateWithDuration:FLDefaultAnimationDuration animations:^{
            _statusBar.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                [self fl_invalidateTimer];
                [self fl_removeStatusBar];
            }
        }];
    }
}

#pragma mark -- private method

/**
 创建默认的view

 @param animateDirection 动画类型

 @return 返回创建默认的view
 */
- (UIView *)fl_defaultViewWithAnimateDirection:(FLAnimationDirection)animateDirection{
    _currentAnimationDirection = animateDirection;
    UIView *defaultView = [[UIView alloc] init];
    // 默认为白色
    defaultView.backgroundColor = [UIColor whiteColor];
    // 初始化frame
    [self changeDefaultView:defaultView height:self.statusBarHeight ? self.statusBarHeight : FLDefaultStatusBarHeight];
    return defaultView;
}

/**
 设置默认view的frame

 @param view   默认的view
 @param height 高度
 */
- (void)changeDefaultView:(UIView *)view height:(CGFloat)height{
    switch (_currentAnimationDirection) {
        case 0:{// 从上到下
            view.frame = CGRectMake(self.position.x ? self.position.x : 0, self.position.y ? self.position.y : 0, FLScreenWidth, height);
            break;
        }
        case 1:{// 从左到右
            view.frame = CGRectMake(self.position.x ? self.position.x : 0, self.position.y ? self.position.y : 0, FLScreenWidth, height);
            break;
        }
        case 2:{// 从下到上
            view.frame = CGRectMake(self.position.x ? self.position.x : 0, self.position.y ? self.position.y : FLScreenHeight - height, FLScreenWidth, height);
            break;
        }
        case 3:{// 从右到左
            view.frame = CGRectMake(self.position.x ? self.position.x : 0, self.position.y ? self.position.y : 0, FLScreenWidth, height);
            break;
        }
    }
    _currentPosition = view.frame.origin;
}

/**
 动画执行

 @param animationDirection 动画类型
 @param autoDismiss        是否自动隐藏
 */
- (void)fl_startAnimationDirection:(FLAnimationDirection)animationDirection autoDismiss:(BOOL)autoDismiss{
    switch (animationDirection) {
        case 0:{// 向上
            _statusBar.fl_y -= _statusBar.fl_height;
            [UIView animateWithDuration:FLDefaultAnimationDuration animations:^{
                _statusBar.transform = CGAffineTransformMakeTranslation(0, _statusBar.fl_height);
            } completion:^(BOOL finished) {
                // 是否自动隐藏
                [self fireTimer:autoDismiss];
            }];
            break;
        }
        case 1:{// 向左
            _statusBar.fl_x -= _statusBar.fl_width;
            [UIView animateWithDuration:FLDefaultAnimationDuration animations:^{
                _statusBar.transform = CGAffineTransformMakeTranslation(_statusBar.fl_width, 0);
            } completion:^(BOOL finished) {
                // 是否自动隐藏
                [self fireTimer:autoDismiss];
            }];
            break;
        }
        case 2:{// 向下
            _statusBar.fl_y += _statusBar.fl_height;
            [UIView animateWithDuration:FLDefaultAnimationDuration animations:^{
                _statusBar.transform = CGAffineTransformMakeTranslation(0, -_statusBar.fl_height);
            } completion:^(BOOL finished) {
                // 是否自动隐藏
                [self fireTimer:autoDismiss];
            }];
            break;
        }
        case 3:{// 向右
            _statusBar.fl_x += _statusBar.fl_width;
            [UIView animateWithDuration:FLDefaultAnimationDuration animations:^{
                _statusBar.transform = CGAffineTransformMakeTranslation(-_statusBar.fl_width, 0);
            } completion:^(BOOL finished) {
                // 是否自动隐藏
                [self fireTimer:autoDismiss];
            }];
            break;
        }
    }
    
}

- (void)fireTimer:(BOOL)flag{
    //停止定时器
    [self fl_invalidateTimer];
    
    if (flag) {
        //开启定时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.messageDuration ? self.messageDuration : FLDefaultMessageDuration target:self selector:@selector(fl_hide) userInfo:nil repeats:NO];
    }
    else{
        //停止定时器
//        [self fl_invalidateTimer];
    }
    
}

/**
 statusBar点击事件

 @param gesR gesR description
 */
- (void)tapOperation:(UIGestureRecognizer *)gesR{
    // 如果有实现，执行block，否则点击隐藏
    if (self.statusBarTapOpreationBlock) {
        self.statusBarTapOpreationBlock();
    }
    else{
        [self fl_hide];
    }
}

/**
 重置
 */
- (void)fl_reset{
    self.messageDuration = FLDefaultMessageDuration;
    self.statusBarHeight = FLDefaultStatusBarHeight;
    self.animationDirection = FLAnimationDirectionFromTop;
    self.position = CGPointMake(0, 0);
    self.messageFont = [UIFont systemFontOfSize:FLStatusBarTitleFontSize];
    self.messageColor = [UIColor blackColor];
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.backgroundColor = [UIColor whiteColor];
}


/**
 移除statusBar
 */
- (void)fl_removeStatusBar{
    if (_statusBar) {
        [_statusBar removeFromSuperview];
        _statusBar = nil;
    }
}

/** 销毁定时器 */
- (void)fl_invalidateTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}




@end
