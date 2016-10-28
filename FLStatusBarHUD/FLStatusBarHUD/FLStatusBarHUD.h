//
//  FLStatusBar.h
//  logistic
//
//  Created by 孔凡列 on 16/2/24.
//  Copyright © 2016年 clarence All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author Clarence
 *
 *  动画执行方式
 */
typedef NS_ENUM(NSInteger,FLAnimationDirection){
    FLAnimationDirectionFromTop,// 从上到下
    FLAnimationDirectionFromLeft,// 从左到右
    FLAnimationDirectionFromBottom,// 从下到上
    FLAnimationDirectionFromRight// 从右到左
};

typedef NS_ENUM(NSInteger,FLStatusBarPositionType){
    FLStatusBarPositionTypeBelowNavigationBar,// 在导航栏下面
    FLStatusBarPositionTypeFrontNavigationBar,// 在导航栏前面
    FLStatusBarPositionTypeDahinterNavigationBar,// 在导航栏后面
    
    FLStatusBarPositionTypeAboveTarBar,// 在tabBar上面
    FLStatusBarPositionTypeFrontTarBar,// 在tabBar前面
    FLStatusBarPositionTypeDahinterTarBar,// 在tabBar后面
    
    FLStatusBarPositionTypeFrontKeyWindow// 在当前窗口前面
};

typedef void(^FLStatusBarTapOpreationBlock)();

@interface FLStatusBarHUD : NSObject
//@property (nonatomic,assign)FLStatusBarPositionType statusBarPositionType;
/**
 *  @author Clarence
 *
 *  动画时间，默认0.25s
 */
@property (nonatomic,assign,readonly)NSTimeInterval animationDuration;
/**
 *  @author Clarence
 *
 *  动画执行方式，默认 FLAnimationDirectionFromTop,必须在show之前设置
 */
@property (nonatomic,assign)FLAnimationDirection animationDirection;

/**
 *  @author Clarence
 *
 *  消息停留时间，默认2s，可以在任何位置设置
 */
@property (nonatomic,assign)NSTimeInterval messageDuration;
/**
 *  @author Clarence
 *
 *  背景颜色，默认白色，可以在任何位置设置
 */
@property (nonatomic,strong)UIColor *backgroundColor;

/**
 *  @author Clarence
 *
 *  文字颜色，默认黑色，可以在任何位置设置
 */
@property (nonatomic,strong)UIColor *messageColor;
/**
 *  @author Clarence
 *
 *  文字字体，默认系统12号，可以在任何位置设置
 */
@property (nonatomic,strong)UIFont *messageFont;
/**
 *  @author Clarence
 *
 *  菊花样式,可以在任何位置设置
 */
@property (nonatomic,assign)UIActivityIndicatorViewStyle activityIndicatorViewStyle;

/**
 *  @author Clarence
 *
 *  状态栏高度,默认40,可以在任何位置设置
 */
@property (nonatomic,assign)CGFloat statusBarHeight;
/**
 *  @author Clarence
 *
 *  显示位置
 */
@property (nonatomic,assign)CGPoint position;

/**
 *  @author Clarence
 *
 *  点击statusBar操作，不实现默认点击动画隐藏
 */
@property (nonatomic,copy)FLStatusBarTapOpreationBlock statusBarTapOpreationBlock;

/**
 *  @author Clarence
 *
 *  提示状态栏
 */
@property (nonatomic,strong,readonly)UIView *statusBar;


+ (instancetype)shareStatusBar;
/**
 @author Clarence
 
 自定义提示弹窗,友情提示：customView只需要设置最终显示的frame，靠边
 
 @param customView    自定义弹窗
 @param view          承接弹窗的view
 @param animationDirection 动画类型
 @param autoDismiss   是否自动隐藏
 */
- (void)fl_showCustomView:(UIView *)customView atView:(UIView *)view animateDirection:(FLAnimationDirection)animationDirection autoDismiss:(BOOL)autoDismiss;

- (void)fl_showCustomView:(UIView *)customView atView:(UIView *)view autoDismiss:(BOOL)autoDismiss;



- (void)fl_showMessage:(NSString *)message image:(UIImage *)image atView:(UIView *)view autoDismiss:(BOOL)autoDismiss;

- (void)fl_showMessage:(NSString *)message image:(UIImage *)image autoDismiss:(BOOL)autoDismiss;

- (void)fl_showMessage:(NSString *)message autoDismiss:(BOOL)autoDismiss;

- (void)fl_showMessage:(NSString *)message;



- (void)fl_showSuccess:(NSString *)message atView:(UIView *)view autoDismiss:(BOOL)autoDismiss;

- (void)fl_showSuccess:(NSString *)message autoDismiss:(BOOL)autoDismiss;

- (void)fl_showSuccess:(NSString *)message;



- (void)fl_showError:(NSString *)message atView:(UIView *)view autoDismiss:(BOOL)autoDismiss;

- (void)fl_showError:(NSString *)message autoDismiss:(BOOL)autoDismiss;

- (void)fl_showError:(NSString *)message;



- (void)fl_showLoading:(NSString *)message atView:(UIView *)view;

- (void)fl_showLoading:(NSString *)message;



- (void)fl_reset;

- (void)fl_hide;

@end
