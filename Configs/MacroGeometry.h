//
//  MacroGeometry.h
//  WeiHouBao
//
//  Created by 晁进 on 17-7-25.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#ifndef WeiHouBao_MacroGeometry_h
#define WeiHouBao_MacroGeometry_h


#define kH_StatusBarHeight 20
//NavBar高度
#define kH_NaviagtionBarHeight 44
//状态栏 ＋ 导航栏 高度
#define kH_StatusAndNaviagtionBarHeight ((kH_StatusBarHeight) + (kH_NaviagtionBarHeight))

//屏幕 rect
#define kSCREEN_RECT ([UIScreen mainScreen].bounds)

#define kSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kH_CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)


#define kSreenScale  ([UIScreen mainScreen].scale)
//屏幕分辨率
#define kSreenResolution (kSCREEN_WIDTH * kSCREEN_HEIGHT * kSreenScale)


//由角度转换弧度 由弧度转换角度
#define LRDegreesToRadian(x) (M_PI * (x) / 180.0)
#define LRRadianToDegrees(radian) (radian*180.0)/(M_PI)

#define kMenuViewSize  CGSizeMake(kSCREEN_WIDTH*3/4, kSCREEN_HEIGHT)
#define kMenuViewRatio (3/4.0)

#define kLeftMenuRatio  0.8

#define kS_scaleOrder  0.7

#define kH_SegmentOfCustomeHeight  40
#define kH_CellHeight 50

#define kPadding 5

#define kW_LayerBorderWidth 0.5


#define kMBProgressMidOffset CGPointMake(0, 0)

#endif
