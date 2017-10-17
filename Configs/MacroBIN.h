//
//  MacroBIN.h
//  WeiHouBao
//
//  Created by 晁进 on 17-7-26.
//  Copyright (c) 2017年 WeiHouKeJi. All rights reserved.
//

#ifndef WeiHouBao_MacroBIN_h
#define WeiHouBao_MacroBIN_h

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

#define kH_TEXTFIELD 30

#define kH_LINE_VIEW  0.5

#define kW_HOUSE_TITLES  50+5
#define kW_HOUSE_CONTENTS  100-5
#define kH_HOUSE_CONTENTS  25

#define kX_GAP  10
#define kY_GAP  10

#define kFONTSIZE_TITLE 14
#define kFONTSIZE_TITLESUB 13
#define kFONTSIZE_MORE_INFO 11.5

#define kH_CONTENT_INIT 40  //长文本默认高度
#define kH_BTN_SPREADOUT 15  //展开按钮高度

#define kNIl_TEXT @"--"


#define kDDLogFuncton   DDLog(@"%@,%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd))
#define kDDLogFrame(viewframe)   DDLog(@"Frame__%@",NSStringFromCGRect(viewframe))

#endif
