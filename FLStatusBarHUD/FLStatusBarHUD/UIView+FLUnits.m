//
//  UIView+FLUnits.m
//
//  Created by 孔凡列 on 16/7/6.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "UIView+FLUnits.h"
#import <objc/runtime.h>
@implementation UIView (FLUnits)

- (void)setFl_borderWidth:(CGFloat)fl_borderWidth{
    self.layer.borderWidth = fl_borderWidth;
}


- (CGFloat)fl_borderWidth{
    
    return self.layer.borderWidth;
}

- (void)setFl_borderColor:(UIColor *)fl_borderColor{
    self.layer.borderColor = fl_borderColor.CGColor;
}


- (UIColor *)fl_borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)fl_x
{
    return self.frame.origin.x;
}

- (CGFloat)fl_y
{
    return self.frame.origin.y;
}

- (CGFloat)fl_centerX{
    return self.center.x;
}

- (CGFloat)fl_centerY{
    return self.center.y;
}

- (CGFloat)fl_width
{
    return self.frame.size.width;
}

- (CGFloat)fl_height
{
    return self.frame.size.height;
}

- (CGPoint)fl_origin
{
    return self.frame.origin;
}

- (CGSize)fl_size
{
    return self.frame.size;
}

- (void)setFl_x:(CGFloat)fl_x{
    self.frame = (CGRect){
        .origin = {.x = fl_x, .y = self.fl_y},
        .size   = {.width = self.fl_width, .height = self.fl_height}
    };
}

- (void)setFl_y:(CGFloat)fl_y{
    self.frame = (CGRect){
        .origin = {.x = self.fl_x, .y = fl_y},
        .size   = {.width = self.fl_width, .height = self.fl_height}
    };
}

- (void)setFl_centerX:(CGFloat)fl_centerX{
    CGPoint center = self.center;
    center.x = fl_centerX;
    self.center = center;
}

- (void)setFl_centerY:(CGFloat)fl_centerY{
    CGPoint center = self.center;
    center.y = fl_centerY;
    self.center = center;
}


- (void)setFl_width:(CGFloat)fl_width{
    self.frame = (CGRect){
        .origin = {.x = self.fl_x, .y = self.fl_y},
        .size   = {.width = fl_width, .height = self.fl_height}
    };
}

- (void)setFl_height:(CGFloat)fl_height{
    self.frame = (CGRect){
        .origin = {.x = self.fl_x, .y = self.fl_y},
        .size   = {.width = self.fl_width, .height = self.fl_height}
    };
}

- (void)setFl_origin:(CGPoint)fl_origin{
    self.frame = (CGRect){
        .origin = {.x = fl_origin.x, .y = fl_origin.y},
        .size   = {.width = self.fl_width, .height = self.fl_height}
    };
}

- (void)setFl_size:(CGSize)fl_size{
    self.frame = (CGRect){
        .origin = {.x = self.fl_x, .y = self.fl_y},
        .size   = {.width = self.fl_width, .height = self.fl_height}
    };
}


- (void)setBorderWidth:(CGFloat)borderWidth
{
    
    if (borderWidth < 0) {
        return;
    }
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

/**
 *  @author 孔凡列, 16-09-18 05:09:45
 *
 *  注意：此方法如果在滚动视图中使用（滚动视图带圆角），会导致整个滚动视图变模糊，解决办法：不做光栅化处理
 *
 *  @param cornerRadius 圆角
 */
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    // maskTobounds 会导致离屏渲染，影响性能
    self.layer.masksToBounds = YES;
    
    // 使用光栅化技术（会导致离屏渲染，影响性能，滚动视图中需要），将圆角缓存起来，避免如果此时控件是在滚动视图中
    if ([self.class isSubclassOfClass:[UIScrollView class]]) {
        UIScrollView *view = (UIScrollView *)self;
        if (view.scrollEnabled == YES) {
            self.layer.shouldRasterize = YES;
            self.layer.rasterizationScale = self.layer.contentsScale;
            NSLog(@"hello scrollView");
        }
        else{
            NSLog(@"hello notScroll-scrollView");
            self.layer.shouldRasterize = NO;
        }
        
        
    }
    else{
        NSLog(@"normal view");
        self.layer.shouldRasterize = NO;
    }
    
    // maskToBounds 导致离屏渲染，也是一种模糊，优化使用手动绘制模糊路径,如果是阴影也需要(self.layer.shadowPath)
//    self.layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath
    // 设置背景颜色为白色，如果不设置背景颜色，系统默认是透明的，需要优化，避免出现图层混合
    if (![self respondsToSelector:@selector(setBackgroundColor:)]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
}

- (CGFloat)borderWidth
{
    return self.borderWidth;
}

- (UIColor *)borderColor
{
    return self.borderColor;
    
}

- (CGFloat)cornerRadius
{
    return self.cornerRadius;
}

- (CGFloat)fl_left
{
    return self.frame.origin.x;
}

- (CGFloat)fl_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)fl_top
{
    return self.frame.origin.y;
}

- (CGFloat)fl_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)fl_alignHorizontal
{
    if (self.superview.fl_width == 0.0f) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@  必须添加到父视图中后才能设置fl_alignHorizontal",[self class]]);
    }
    NSAssert(self.superview.fl_width != 0.0f, @"必须添加到父视图中后才能设置fl_alignHorizontal");
    self.fl_x = (self.superview.fl_width - self.fl_width) * 0.5;
}

- (void)fl_alignVertical
{
    if (self.superview.fl_height == 0.0f) {
        NSLog(@"%@",[NSString stringWithFormat:@"%@  必须添加到父视图中后才能设置fl_alignVertical",[self class]]);
    }
    NSAssert(self.superview.fl_height != 0.0f, @"必须添加到父视图中后才能设置fl_alignVertical");
    self.fl_y = (self.superview.fl_height - self.fl_height) * 0.5;
}

@end



@implementation UIView(Extension)

static char fl_showNoDataView;

static char fl_opreation;

- (void)setFl_showNoDataView:(BOOL)fl_showNoDataView{
    objc_setAssociatedObject(self, &fl_showNoDataView, [NSString stringWithFormat:@"%d",fl_showNoDataView], OBJC_ASSOCIATION_ASSIGN);
    UIView *noDataView = ({
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.tag = 10086;
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sybanner01"]];
        imageView.bounds = CGRectMake(0, 0, self.fl_width / 3, self.fl_width / 3);
        imageView.center = CGPointMake(self.fl_centerX, self.fl_centerY - 20);
        [view addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, self.fl_width, 60);
        label.textColor = [UIColor lightGrayColor];
        label.text = @"什么都没有哟~";
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.center = CGPointMake(self.fl_centerX, imageView.fl_bottom + 30);
        [view addSubview:label];
        
        view;
    });
    if (fl_showNoDataView) {
        for (UIView *view in self.subviews) {
            if (view.tag == 10086) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:noDataView];
    }
    else{
        
        [noDataView removeFromSuperview];
        for (UIView *view in self.subviews) {
            if (view.tag == 10086) {
                [view removeFromSuperview];
            }
        }
    }
}

- (BOOL)fl_showNoDataView{
    return [objc_getAssociatedObject(self, &fl_showNoDataView) boolValue];
}


/* 待完善 */
- (void)setFl_opreation:(void (^)(id))fl_opreation{
    objc_setAssociatedObject(self, &fl_opreation, fl_opreation, OBJC_ASSOCIATION_COPY);
    
}

- (void (^)(id))fl_opreation{
    return objc_getAssociatedObject(self, &fl_opreation);
}


- (void)fl_showNoDataView:(BOOL)isShow operation:(void (^)(id target))operation{
    UIView *noDataView = ({
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.tag = 10086;
        view.backgroundColor = [UIColor whiteColor];
        UIButton *imageView = [[UIButton alloc] init];
        [imageView setBackgroundImage:[UIImage imageNamed:@"sybanner01"] forState:UIControlStateNormal];
        imageView.bounds = CGRectMake(0, 0, self.fl_width / 3, self.fl_width / 3);
        imageView.center = CGPointMake(self.fl_centerX, self.fl_centerY - 20);
        [imageView addTarget:self action:@selector(respondsOperation:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:imageView];
//        imageView.tag = 1008611;
        if (operation) {
            imageView.fl_opreation = operation;
        }
        
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, self.fl_width, 60);
        label.textColor = [UIColor lightGrayColor];
        label.text = @"什么都没有哟~";
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.center = CGPointMake(self.fl_centerX, imageView.fl_bottom + 30);
        [view addSubview:label];
        
        view;
    });
    if (isShow) {
        for (UIView *view in self.subviews) {
            if (view.tag == 10086) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:noDataView];
        
        
    }
    else{
        
        [noDataView removeFromSuperview];
        for (UIView *view in self.subviews) {
            if (view.tag == 10086) {
                [view removeFromSuperview];
            }
        }
    }
}

- (void)respondsOperation:(UIButton *)imageView{
//    UIButton *imgV = (UIButton *)[[self viewWithTag:10086] viewWithTag:1008611];
    if (imageView.fl_opreation) {
        imageView.fl_opreation([self viewWithTag:10086]);
    }
}

- (instancetype)fl_findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *responder = [subView fl_findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}

- (nullable UIViewController *)fl_viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    return nil;
}

- (BOOL)fl_intersectsWithView:(UIView *)view{
    
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}

+ (instancetype)fl_viewFromXib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


+ (instancetype)fl_circleViewWithRadius:(CGFloat)radius{
    UIView *circleView = [[self alloc] init];
    circleView.layer.cornerRadius = radius;
    circleView.layer.masksToBounds = YES;
    return circleView;
}


@end
