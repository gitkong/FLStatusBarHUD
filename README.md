#先看看微博的新消息条数提醒是怎么的
![微博的新消息条数提醒](http://upload-images.jianshu.io/upload_images/1085031-1d50b89d8a48cb3b.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)


#再来看看我做的demo效果，因为只是做类似的，功能拓展，效果不是一样的喔~[gitHub地址](https://github.com/gitkong/FLStatusBarHUD)



![statusBar.gif](http://upload-images.jianshu.io/upload_images/1085031-1143f0dfff212461.gif?imageMogr2/auto-orient/strip)


#功能介绍
 - 可以自定义statusBar，也可以使用默认的
 - 动画类型暂时提供四种，都是简单的平移效果，如果有需求可以留言
 - 默认statusBar大概可分为四种
  -  自定义图标、提示语
  -  显示成功 （有默认图标）
  -  显示失败（有默认图标）
  -  显示加载状态

 - 提供statusBar点击block回调，不实现或者指定为nil 默认点击动画隐藏statusBar
 - 可以设置statusBar停留时间、是否自动隐藏、文字字体及颜色、statusBar背景颜色及背景图片等

#API分析

# 一、方法选择
  - 使用类方法，不用创建实例对象，使用方便，但没办法管理对象属性
  - 使用对象方法，需要创建实例对象，通过单例管理对象属性，当然选对象方法啦！
    -  显示方法肯定需要一个能让调用者自定义的
    -  为了方便调用者使用，提供默认statusBar，多种show方法，不需要自定义就能直接简单使用，快准狠
    -  提供一个fl_reset方法，方便调用者重置为默认设置
    -  提供一个fl_hide方法，隐藏当前的状态栏

# 二、实例属性（除了animationDirection属性必须在show之前设置，其他属性均可在任意位置设置）
  -  消息停留时间，可自定义，默认2s

```
/**
 *  @author Clarence
 *
 *  消息停留时间，默认2s，可以在任何位置设置
 */
@property (nonatomic,assign)NSTimeInterval messageDuration;
```

  -  动画执行时间，默认0.25s，暂时不允许修改，是readonly，参考系统键盘弹出，也是不能修改

```
/**
 *  @author Clarence
 *
 *  动画时间，默认0.25s
 */
@property (nonatomic,assign,readonly)NSTimeInterval animationDuration;
```

  -  statusBar的背景颜色以及背景图片，可自定义，默认背景颜色是白色，无背景图

```
/**
 *  @author Clarence
 *
 *  背景颜色，默认白色，可以在任何位置设置
 */
@property (nonatomic,strong)UIColor *backgroundColor;
/**
 *  @author Clarence
 *
 *  背景图片，可以在任何位置设置
 */
@property (nonatomic,strong)UIImage *backgroundImage;
```

  -  提示语的文字颜色以及字体，可自定义，默认黑色 12号

```
/**
 *  @author Clarence
 *
 *  文字颜色，默认黑色，可以在任何位置设置
 */
@property (nonatomic,strong)UIColor *messageColor;
/**
 *  @author Clarence
 *
 *  文字字体，默认系统12号，可以在任何位置设置
 */
@property (nonatomic,strong)UIFont *messageFont;
```

  -  加载中的菊花样式，可自定义，默认UIActivityIndicatorViewStyleGray

```
/**
 *  @author Clarence
 *
 *  菊花样式,可以在任何位置设置
 */
@property (nonatomic,assign)UIActivityIndicatorViewStyle activityIndicatorViewStyle;
```

  -  动画执行方式，可自定义，必须在show之前设置，默认FLAnimationDirectionFromTop

```
/**
 *  @author Clarence
 *
 *  动画执行方式，默认 FLAnimationDirectionFromTop,必须在show之前设置
 */
@property (nonatomic,assign)FLAnimationDirection animationDirection;
```

  -  statusBar的高度以及显示的位置，可自定义，默认高度40，

```
/**
 *  @author Clarence
 *
 *  状态栏高度,默认40,可以在任何位置设置
 */
@property (nonatomic,assign)CGFloat statusBarHeight;
/**
 *  @author Clarence
 *
 *  显示位置,有默认值，可以在任何位置设置
 */
@property (nonatomic,assign)CGPoint position;
```

  -  statusBar的点击操作，可自定义，默认点击隐藏

```
/**
 *  @author Clarence
 *
 *  点击statusBar操作，不实现默认点击动画隐藏
 */
@property (nonatomic,copy)FLStatusBarTapOpreationBlock statusBarTapOpreationBlock;
```

  -  当前的statusBar，readonly只读，不能修改

```
/**
 *  @author Clarence
 *
 *  提示状态栏
 */
@property (nonatomic,strong,readonly)UIView *statusBar;
```

#总结
- 注意点：
  -  除了animationDirection属性必须在show之前设置，其他属性均可在任意位置设置
  -  自定义statusBar，frame设置只需要设置在最终显示的位置就行，内部已经处理，当然你可以通过设置position修改

- 详细代码分析就不一一在这说啦，很简单的，代码里面有注释，功能点不多，但应该都能满足你的需求啦😁

- 方法有点多，就不粘贴出来了，Demo有详细介绍，关键是API的设计以及封装，致力于一句代码就能实现功能，欢迎大家去[我的简书](http://www.jianshu.com/users/fe5700cfb223/latest_articles)关注我，喜欢就给个like，一直更新~
