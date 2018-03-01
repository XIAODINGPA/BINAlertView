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

//字体
#define KFZ_First 18
#define KFZ_Second 16
#define KFZ_Third 14
#define KFZ_Fouth 12
#define KFZ_Fifth 10


#define kPadding 5
#define kW_LayerBorderWidth 0.5

#define kTAG_LABEL  100
#define kTAG_BTN  200
#define kTAG_BTN_RightItem  260
#define kTAG_BTN_BackItem  261

#define kTAG_IMGVIEW 300
#define kTAG_TEXTFIELD 400
#define kTAG_TEXTVIEW 500
#define kTAG_ALERT_VIEW 600
#define kTAG_ACTION_SHEET 700
#define kTAG_PICKER_VIEW 800
#define kTAG_DATE_PICKER 900

#define kTAG_VIEW 1000
#define kTAG_VIEW_Segment 1100
#define kTAG_VIEW_RADIO 1200

#define kTAG_UItableViewCell 1500


#define kTAG_ICAROUSEL 950
#define kTAG_PAGE_CONTROL 951

#define kH_Top_IMGVIEW  240
#define kH_LABEL 25
#define kH_LABEL_TITLE 30
#define kH_LABEL_SMALL 20

#define kH_TEXTFIELD 30

#define kH_LINE_VIEW  1/3.0

#define kW_HOUSE_TITLES  50+5
#define kW_HOUSE_CONTENTS  100-5
#define kH_HOUSE_CONTENTS  25

#define kX_GAP  10
#define kY_GAP  10


#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define kCOUNT_IMAGEVIEW 6

#define kTAG_IMGVIEW 300


#endif
