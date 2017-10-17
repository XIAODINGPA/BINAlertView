//
//  MacroUtilities.h
//  WeiHouBao
//
//  Created by 晁进 on 17-7-25.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#ifndef WeiHouBao_MacroUtilities_h
#define WeiHouBao_MacroUtilities_h

#ifdef DEBUG
#define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DDLog(...)
#endif

#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif

#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


#define kAdd_By_BIN //add by BIN

// 获取RGB颜色
#define kCOLOR_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kCOLOR_RGB(r,g,b) kRGBA(r,g,b,1.0f)

#define kCOLOR_RGB_Init(r,g,b,a) [[UIColor alloc]initWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];

// 十六进制颜色
#define kCOLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

//颜色
#define kC_TextColor [UIColor colorWithHexString:@"#333333"]
#define kC_TextColor_Title [UIColor colorWithHexString:@"#666666"]
#define kC_TextColor_TitleSub [UIColor colorWithHexString:@"#999999"]
//橘色
#define kC_ThemeCOLOR [UIColor colorWithHexString:@"#fea914"]
#define kC_BackgroudColor [UIColor colorWithHexString:@"#f8f8f8"]
#define kC_LineColor [UIColor colorWithHexString:@"#e0e0e0"]

//绿色
#define kC_ThemeCOLOR_One [UIColor colorWithHexString:@"#25b195"]
//水蓝色
#define kC_ThemeCOLOR_Two [UIColor colorWithHexString:@"#29b4f5"]


#define kC_BtnColor_N [UIColor colorWithHexString:@"#fea914"]
#define kC_BtnColor_H [UIColor colorWithHexString:@"#f1a013"]
#define kC_BtnColor_D [UIColor colorWithHexString:@"#999999"]


#define kC_ClearColor [UIColor clearColor]
//#define kC_MARK_COLOR [UIColor colorWithHexString:@"#f35f39"]

//测试用例
#define kC_WhiteColor [UIColor whiteColor]
#define kC_GreenColor [UIColor greenColor]
#define kC_YellowColor [UIColor yellowColor]
#define kC_BlueColor [UIColor blueColor]
#define kC_RedColor [UIColor redColor]
#define kC_BrownColor [UIColor brownColor]
#define kC_CyanColor [UIColor cyanColor]


//字体
#define KFZ_First 18
#define KFZ_Second 16
#define KFZ_Third 14
#define KFZ_Fouth 12
#define KFZ_Fifth 10


//图片最大尺寸500k
#define kFileSize_image 500
//右指箭头
#define kIMAGE_arrowRight @"img_arrowRight.png"

#define kIMAGE_default @"img_headPortrait.png"
#define kIMAGE_defaultAddPhoto @"img_photoAddDefault.png"

//#define kIMAGE_OF_DEFAULT_ADD [UIImage imageNamed:@"上传图片_正方形.png"]
//#define kIMAGE_OF_DEFAULT_ADD_VIDEO [UIImage imageNamed:@"上传视频_正方形.png"]

//#define kIMAGE_defaultAddVideo @"img_addPhotoDefault.png"

#define kMsg_NetWorkFailed @"网络请求失败,请稍后再试"


//button背景
#define kIMG_btnImage [UIImage imageWithColor:[UIColor colorWithHexString:@"#228ce2"]]
#define kIMG_btnImage_Highlight [UIImage imageWithColor:[UIColor colorWithHexString:@"#1774c0"]]

//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

//强弱引用
#define kWeakSelf(type)    __weak typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong typeof(type) type = weak##type;


#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()

//系统版本判断
#define iOS(version) (([[[UIDevice currentDevice] systemVersion] floatValue] >= version)?1:0)

//keyWindow
#define kKeyWindow  ([UIApplication sharedApplication].keyWindow)

//WHKNavigationController
#define kPushViewController(UIViewController)   [self.navigationController pushViewController:[UIViewController new] animated:YES];

#define kPopViewController  [self.navigationController popViewControllerAnimated:YES];

#define kPopToViewController(UIViewController)  [self.navigationController popToViewController:[UIViewController new] animated:YES];


//设置加载提示框（第三方框架：Toast）
#define LRToast(str)  CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[kWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
kWindow.userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
kWindow.userInteractionEnabled = YES;\
});


// 加载
#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define kBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[kWindow addSubview:aView]; \
} \
} \

#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:kWindow animated:YES];kShowNetworkActivityIndicator()
#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:kWindow animated:YES]
#define kRemoveBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \



#endif
