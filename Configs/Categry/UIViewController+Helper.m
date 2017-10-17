//
//  UIViewController+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIViewController+Helper.h"
#import <objc/runtime.h>

@implementation UIViewController (Helper)

@dynamic delegate;

- (void)addFailRefreshViewWithTitle:(NSString *)title
{
    UIView *view = [self.view viewWithTag:20178015];
    if (view) {
        [self.view setHidden:NO];
        return;
    }
    view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.tag = 20178015;
    view.backgroundColor = [UIColor whiteColor];
    
    CGSize imgSize = CGSizeMake(65, 75);
    CGRect imgViewRect = CGRectMake((kSCREEN_WIDTH - imgSize.width)/2.0, (CGRectGetHeight(self.view.bounds) - imgSize.height)/2.0, imgSize.width, imgSize.height);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imgViewRect];
    imageView.image = [UIImage imageNamed:@"error.png"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UILabel * tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(kX_GAP, CGRectGetMaxY(imgViewRect)+5, kSCREEN_WIDTH - 2 * kX_GAP, 30)];
    tipLabel.text = title;
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.userInteractionEnabled = YES;

//    tipLabel.backgroundColor = [UIColor yellowColor];
//    imageView.backgroundColor = [UIColor greenColor];

    [view addSubview:tipLabel];
    [view addSubview:imageView];
    
    if ([self respondsToSelector:@selector(failRefresh)]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(failRefresh)];
        
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        [view addGestureRecognizer:tapGesture];
    }
    
    [self.view addSubview:view];
}

- (void)removeFailRefreshView
{
    UIView *view = [self.view viewWithTag:20178015];
    if (view) {
        view.hidden = YES;
    }
}

- (BOOL)hasContollerClassName:(NSString *)className navController:(UINavigationController *)navController{

    for (UIViewController * controller in navController.viewControllers) {
        
        if ([controller isKindOfClass:[NSClassFromString(className) class]]) {
            return YES;
            
        }
    }
    return NO;
}

- (UIViewController *)getContollerClassName:(NSString *)className navController:(UINavigationController *)navController{

    for (UIViewController * controller in navController.viewControllers) {
        
        if ([controller isKindOfClass:[NSClassFromString(className) class]]) {
            return controller;
            
        }
    }
    return nil;
}

- (void)goContollerClassName:(NSString *)className navController:(UINavigationController *)navController{

    for (UIViewController * controller in navController.viewControllers) {
        
        if ([controller isKindOfClass:[NSClassFromString(className) class]]) {
            
            [navController pushViewController:controller animated:YES];
            return;
            
        }
    }
}


@end
