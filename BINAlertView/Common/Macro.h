//
//  Macro.h
//  BINAlertView
//
//  Created by hsf on 2018/3/1.
//  Copyright © 2018年 hsf. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//强弱引用
#define kWeakSelf(type)    __weak __typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong __typeof(type) strongSelf = type;

#define kActionTitle_Sure       @"确定"
#define kActionTitle_Cancell    @"取消"

#define kAnimationDuration_Toast   1.5

//测试用例
#define kC_whiteColor   [UIColor whiteColor]
#define kC_GreenColor   [UIColor greenColor]
#define kC_YellowColor  [UIColor yellowColor]
#define kC_BlueColor    [UIColor blueColor]
#define kC_RedColor     [UIColor redColor]
#define kC_BrownColor   [UIColor brownColor]
#define kC_CyanColor    [UIColor cyanColor]
#define kC_ClearColor   [UIColor clearColor]

#define kC_LineColor    [UIColor grayColor]

#define kC_TextColor            [UIColor blackColor]
#define kC_TextColor_Title      [UIColor blackColor]
#define kC_TextColor_TitleSub   [UIColor blackColor]

#define kC_BtnColor_N       [UIColor redColor]
#define kC_BtnColor_H       [UIColor redColor]
#define kC_BtnColor_D       [UIColor redColor]



#endif /* Macro_h */
