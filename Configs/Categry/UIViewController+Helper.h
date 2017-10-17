//
//  UIViewController+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FailRefreshViewDelegate<NSObject>

@optional
- (void)failRefresh;

@end

@interface UIViewController (Helper)

- (void)addFailRefreshViewWithTitle:(NSString *)title;
//- (void)addFailRefreshView;
- (void)removeFailRefreshView;

@property (nonatomic, weak)id<FailRefreshViewDelegate> delegate;


- (BOOL)hasContollerClassName:(NSString *)className navController:(UINavigationController *)navController;

- (UIViewController *)getContollerClassName:(NSString *)className navController:(UINavigationController *)navController;

- (void)goContollerClassName:(NSString *)className navController:(UINavigationController *)navController;



@end
