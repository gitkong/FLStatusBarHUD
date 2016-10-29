/*
 * author 孔凡列
 *
 * gitHub https://github.com/gitkong
 * cocoaChina http://code.cocoachina.com/user/
 * 简书 http://www.jianshu.com/users/fe5700cfb223/latest_articles
 * QQ 279761135
 * 喜欢就给个like 和 star 喔~
 */

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


typedef void(^FLStatusBarTapOpreationBlock)();

@interface FLStatusBarHUD : NSObject
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
 *  背景图片，可以在任何位置设置
 */
@property (nonatomic,strong)UIImage *backgroundImage;

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
 *  显示位置,有默认值，可以在任何位置设置
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


/**
 @author Clarence
 
 单例对象创建
 
 */
+ (instancetype)shareStatusBar;
/**
 @author Clarence
 
 自定义提示statusBar,友情提示：customView只需要设置最终显示的frame，靠边
 
 @param customView    自定义弹窗
 @param view          承接弹窗的view
 @param animationDirection 动画类型
 @param autoDismiss   是否自动隐藏
 */
- (void)fl_showCustomView:(UIView *)customView atView:(UIView *)view animateDirection:(FLAnimationDirection)animationDirection autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:45
 *
 *  自定义statusBar，默认animationDirection = FLAnimationDirectionFromTop
 *
 *  @param customView  自定义statusBar
 *  @param view        承接statusBar的view
 *  @param autoDismiss 是否自动隐藏
 */
- (void)fl_showCustomView:(UIView *)customView atView:(UIView *)view autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:08
 *
 *  默认statusBar，有图片以及文字（居中）
 *
 *  @param message     提示语
 *  @param image       图标
 *  @param view        承接statusBar的view
 *  @param autoDismiss 是否自动隐藏
 */
- (void)fl_showMessage:(NSString *)message image:(UIImage *)image atView:(UIView *)view autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:10
 *
 *  默认statusBar，有图标及文字
    默认添加显示在当前窗口
    默认animationDirection = FLAnimationDirectionFromTop
 *
 *  @param message     提示语
 *  @param image       图标
 *  @param autoDismiss 是否自动隐藏
 */
- (void)fl_showMessage:(NSString *)message image:(UIImage *)image autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:30
 *
 *  默认statusBar，只有提示文字
    默认添加显示在当前窗口
    默认animationDirection = FLAnimationDirectionFromTop
 *
 *  @param message     提示语
 *  @param autoDismiss 是否自动隐藏
 */
- (void)fl_showMessage:(NSString *)message autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:18
 *
 *  默认statusBar，只有提示文字
    默认添加显示在当前窗口 
    默认animationDirection = FLAnimationDirectionFromTop
    默认自动隐藏
 *
 *  @param message 提示语
 */
- (void)fl_showMessage:(NSString *)message;


/**
 *  @author 孔凡列, 16-10-29 09:10:50
 *
 *  默认statusBar，显示成功
    默认有成功图标
    默认animationDirection = FLAnimationDirectionFromTop
 *
 *  @param message     提示语
 *  @param view        承接statusBar的view
 *  @param autoDismiss 是否自动隐藏
 */
- (void)fl_showSuccess:(NSString *)message atView:(UIView *)view autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:30
 *
 *  默认statusBar，显示成功
    默认有成功图标
    默认添加显示在当前窗口
    默认animationDirection = FLAnimationDirectionFromTop
 *
 *  @param message     提示语
 *  @param autoDismiss 是否自动隐藏
 */
- (void)fl_showSuccess:(NSString *)message autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:49
 *
 *  默认statusBar，显示成功
    默认有成功图标
    默认添加显示在当前窗口
    默认animationDirection = FLAnimationDirectionFromTop
    默认自动隐藏
 *
 *  @param message 提示语
 */
- (void)fl_showSuccess:(NSString *)message;


/**
 *  @author 孔凡列, 16-10-29 09:10:28
 *
 *  默认statusBar，显示失败
    默认有失败图标
    默认animationDirection = FLAnimationDirectionFromTop
 *
 *  @param message     提示语
 *  @param view        承接statusBar的view
 *  @param autoDismiss 是否自动隐藏
 */
- (void)fl_showError:(NSString *)message atView:(UIView *)view autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:30
 *
 *  默认statusBar，显示失败
    默认有失败图标
    默认添加显示在当前窗口
    默认animationDirection = FLAnimationDirectionFromTop
 *
 *  @param message     提示语
 *  @param autoDismiss 是否自动隐藏
 */
- (void)fl_showError:(NSString *)message autoDismiss:(BOOL)autoDismiss;
/**
 *  @author 孔凡列, 16-10-29 09:10:49
 *
 *  默认statusBar，显示失败
    默认有失败图标
    默认添加显示在当前窗口
    默认animationDirection = FLAnimationDirectionFromTop
    默认自动隐藏
 *
 *  @param message 提示语
 */
- (void)fl_showError:(NSString *)message;


/**
 *  @author 孔凡列, 16-10-29 09:10:23
 *
 *  默认statusBar，显示正在加载，可以设置菊花样式 activityIndicatorViewStyle
    默认有菊花显示
    默认animationDirection = FLAnimationDirectionFromTop
    默认 不 自动隐藏
 *
 *  @param message 提示语
 *  @param view    承接statusBar的view
 */
- (void)fl_showLoading:(NSString *)message atView:(UIView *)view;
/**
 *  @author 孔凡列, 16-10-29 09:10:13
 *
 *  默认statusBar，显示正在加载，可以设置菊花样式 activityIndicatorViewStyle
    默认有菊花显示
    默认添加显示在当前窗口
    默认animationDirection = FLAnimationDirectionFromTop
    默认 不 自动隐藏
 *
 *  @param message 提示语
 */
- (void)fl_showLoading:(NSString *)message;


/**
 *  @author 孔凡列, 16-10-29 09:10:51
 *
 *  重置所有设置为默认
 */
- (void)fl_reset;
/**
 *  @author 孔凡列, 16-10-29 09:10:51
 *
 *  隐藏当前显示的statusBar
 */
- (void)fl_hide;

@end
