//
//  BINAlertView.h
//  CustomeAlertView
//
//  Created by BIN on 2017/9/29.
//  Copyright © 2017年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BINAlertView;

typedef void (^BlockAlertView)(BINAlertView * alertView,  NSInteger btnIndex);

@interface BINAlertView : UIView

/**
 自定义弹窗,本视图最大优点是customView支持任何UIView及其子类

 @param title 标题如果不想显示此控件空间置位nil,一般来说空字符@""比较推荐
 @param msg 信息主体,必须customView为nil,同时有msg和customView时,优先显示customView
 @param customView 如果customeView超出BINAlertView的尺寸则按比例缩小,类似UIViewContentModeScaleAspectFit
 @param btnTitles 底部按钮,支持2个以上
 @return 返回BINAlertView
 */
+ (BINAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)msg customView:(UIView *)customView btnTitles:(NSArray *)btnTitles;

/**
 msg或者customView的最大宽度值(屏幕宽度-50)
 */
@property (nonatomic, assign ,readonly) CGFloat maxWidth;

@property (nonatomic, strong) UIColor * lineColor;

@property (nonatomic, copy) BlockAlertView blockAlertView;
- (void)actionWithBlock:(BlockAlertView)blockAlertView;

- (void)show;
- (void)dismiss;

@end
