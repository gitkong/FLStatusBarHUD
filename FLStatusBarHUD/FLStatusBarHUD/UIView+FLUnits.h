//
//  UIView+FLUnits.h
//  @author Clarence-lie, 16-07-06 23:07:24
//  Created by 孔凡列 on 16/7/6.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (FLUnits)

//@property (nonatomic,assign)CGFloat fl_borderWidth;

//@property (nonatomic,strong)UIColor *fl_borderColor;

// IBInspectable 可以使得在xib或者sb中看到自定义的属性，进行修改,此时属性名必须和系统一致
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor  * _Nonnull borderColor;
//
/**
 *  @author 孔凡列, 16-09-18 05:09:45
 *
 *  注意：1.此时这个属性需要设置能否滚动、背景颜色的时候，需要写在最后
         2.此方法如果在滚动视图中使用（滚动视图带圆角），会导致整个滚动视图变模糊，解决办法：不做光栅化处理
 */
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic,assign)CGFloat fl_x;

@property (nonatomic,assign)CGFloat fl_y;

@property (nonatomic,assign)CGFloat fl_centerX;

@property (nonatomic,assign)CGFloat fl_centerY;

@property (nonatomic,assign)CGFloat fl_width;

@property (nonatomic,assign)CGFloat fl_height;

@property (nonatomic,assign)CGPoint fl_origin;

@property (nonatomic,assign)CGSize fl_size;

- (CGFloat)fl_left;

- (CGFloat)fl_right;

- (CGFloat)fl_top;

- (CGFloat)fl_bottom;

//水平居中
- (void)fl_alignHorizontal;
//垂直居中
- (void)fl_alignVertical;

@end


@interface UIView(Extension)
#pragma mark - YES-显示无数据页面
//@property (nonatomic,assign)BOOL fl_showNoDataView;

// 暂不开放
//@property (nonatomic,copy)void (^fl_opreation)(id target);
//
//- (void)fl_showNoDataView:(BOOL)isShow operation:(void (^)(id target))operation;

#pragma mark --- 找第一响应者

- (_Nonnull instancetype)fl_findFirstResponder;

#pragma mark --- 找到响应的控制器
- (nullable UIViewController *)fl_viewController;

#pragma mark --- 判断self和view是否重合

- (BOOL)fl_intersectsWithView:( UIView * _Nonnull )view;

#pragma mark --- 快速根据xib创建对应的view（xib的名字必须和类的名相同）

+ (_Nonnull instancetype)fl_viewFromXib;

#pragma mark --- 指定半径剪裁

+ (_Nonnull instancetype)fl_circleViewWithRadius:(CGFloat)radius;

@end



