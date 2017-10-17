
//
//  BINAlertView.m
//  CustomeAlertView
//
//  Created by hsf on 2017/9/29.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "BINAlertView.h"

#import "UIView+AddView.h"
//RGB色值
#define kC_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

static const CGFloat kX_GAP_OF_WINDOW = 15;
static const CGFloat kXY_GAP = 10;

static const CGFloat kH_BTN = 40;
static const CGFloat padding = 5;

static NSString *const kBtnTitleCancell = @"取消";

static const CGFloat kanimateDuration = 0.15;

@interface BINAlertView ()<UITextViewDelegate>

@property (nonatomic, assign ,readwrite) CGFloat maxWidth;

@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UILabel * labTitle;
@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) UIView * customView;

@property (nonatomic, strong) NSMutableArray * btnMarr;

@end

@implementation BINAlertView

+ (BINAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)msg customView:(UIView *)customView btnTitles:(NSArray *)btnTitles{
    
    BINAlertView *alertView = [[BINAlertView alloc]initWithTitle:title message:msg customView:customView btnTitles:btnTitles];
    return alertView;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)msg customView:(UIView *)customView btnTitles:(NSArray *)btnTitles{
    
    self = [super init];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5 ;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0 ;
        
        if (CGRectEqualToRect(self.frame, CGRectZero)) {
            self.frame = CGRectMake(0, 0, kSCREEN_WIDTH - kX_GAP_OF_WINDOW * 2, 180);
        }
        
        CGFloat maxWidth = CGRectGetWidth(self.frame) - kXY_GAP * 2;
        CGFloat maxHeight = kSCREEN_HEIGHT - 64 * 2 - kH_LABEL - kH_BTN - padding * 2;

        self.maxWidth = maxWidth;
        
        CGRect labelRectTitle = CGRectMake(kXY_GAP, kXY_GAP, maxWidth, kH_LABEL);
        CGSize msgSize = CGSizeZero;
        CGRect msgRect = CGRectZero;
        CGSize customeViewSize = CGSizeZero;
        
        if (title != nil) {
            UILabel * lableTitle = [UIView createLabelWithRect:labelRectTitle text:title textColor:nil tag:kTAG_LABEL patternType:@"2" fontSize:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
            [self addSubview:lableTitle];
            self.labTitle = lableTitle;
            
        }else{
            labelRectTitle = CGRectMake(kXY_GAP, kXY_GAP, maxWidth, 0);
            
        }
     
        if (customView != nil) {
            if ([customView isKindOfClass:[UIScrollView class]]) {
                
                if (CGRectGetWidth(customView.frame) > maxWidth) {
                     customeViewSize.width = maxWidth;
                }
                
                if (CGRectGetHeight(customView.frame) > maxHeight) {
                    customeViewSize.height = maxHeight;

                }
            }else{
                customeViewSize = customView.frame.size;
                if (CGRectGetWidth(customView.frame) > maxWidth) {
                    CGFloat ratio = CGRectGetWidth(customView.frame)/maxWidth;
                    
                    customeViewSize.width = maxWidth;
                    customeViewSize.height = CGRectGetHeight(customView.frame)/ratio;
                }
                else if(CGRectGetHeight(customView.frame) > maxHeight){
                    CGFloat ratio = CGRectGetHeight(customView.frame)/maxWidth;
                    
                    customeViewSize.height = maxHeight;
                    customeViewSize.width = customeViewSize.width/ratio;
                    
                }

            }
            customView.frame = CGRectMake(kXY_GAP, CGRectGetMaxY(labelRectTitle) + padding, customeViewSize.width, customeViewSize.height);
            [self addSubview:customView];
            self.customView = customView;
            
            self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetMaxY(customView.frame)+padding+kH_BTN);
        }else{
            if (msg != nil) {
                msgSize = [self sizeWithText:msg fontSize:KFZ_Fifth maxWidth:maxWidth];
                msgSize.height =  msgSize.height < kH_LABEL ? kH_LABEL: msgSize.height;
                msgSize.height =  msgSize.height > maxHeight ? maxHeight: msgSize.height;

                msgRect = CGRectMake(CGRectGetMinX(labelRectTitle), CGRectGetMaxY(labelRectTitle) + padding, maxWidth, msgSize.height);
                UITextView * textView = [UIView createTextShowWithRect:msgRect text:msg fontSize:KFZ_Fifth textAlignment:NSTextAlignmentCenter];
                [self addSubview:textView];
                self.textView = textView;
                textView.frame = CGRectMake(CGRectGetMinX(labelRectTitle), CGRectGetMaxY(labelRectTitle) + padding, CGRectGetWidth(msgRect), textView.contentSize.height);
                textView.delegate = self;
                if (textView.contentSize.height > maxHeight)
                {
                    textView.frame = CGRectMake(CGRectGetMinX(labelRectTitle), CGRectGetMaxY(labelRectTitle) + padding, CGRectGetWidth(msgRect), maxHeight);
                    textView.scrollEnabled = YES;   // 允许滚动
                }
                else{
                    textView.scrollEnabled = NO;    // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
                }
                self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetMinY(msgRect) + CGRectGetHeight(textView.frame) + padding + kH_BTN);

            }else{
                self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame),CGRectGetMaxY(labelRectTitle) + padding + kH_BTN);
            }

         }
        [self createBtnsWithBtnTitles:btnTitles];
        
        //无标题 无BTN时可以提示信息使用
        if (!title && !btnTitles) {
            CGRect rect = self.frame;
            rect.size.height -= (kY_GAP + kH_BTN);
            self.frame = rect;
            
            self.textView.center = self.center;
            self.textView.textAlignment = NSTextAlignmentCenter;
        }
        self.backgroundColor = [UIColor whiteColor];
        self.center = [[[[UIApplication sharedApplication]windows]firstObject]center];
        
    }
    return self;
}

- (void)createBtnsWithBtnTitles:(NSArray *)btnTitles{
    
    NSInteger btnCount = btnTitles.count;
    if (btnCount != 0 ) {
        for (NSInteger i = 0; i < btnCount; i++) {
            
            CGRect btnRect = CGRectMake(CGRectGetWidth(self.frame)/btnCount * i, CGRectGetHeight(self.frame) - kH_BTN, CGRectGetWidth(self.frame)/btnCount, kH_BTN);
            UIButton * btn = [UIView createBtnWithRect:btnRect title:btnTitles[i] fontSize:KFZ_Second image:nil tag:kTAG_BTN+i patternType:@"2" target:self aSelector:@selector(handleBtnAction:)];
            [self addSubview:btn];
            [self.btnMarr addObject:btn];
            
            if ([btnTitles[i] isEqualToString:kBtnTitleCancell]) {
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
               
            }else{
//                [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                [btn setTitleColor:kC_RGBA(13, 95, 255, 1.0) forState:UIControlStateNormal];

            }
            if (i != btnCount - 1) {
                //右边框
                CALayer * rightLayer = [CALayer layer];
                rightLayer.frame = CGRectMake((btn.bounds.size.width - kW_LayerBorderWidth), 0, kW_LayerBorderWidth, btn.bounds.size.height);
                rightLayer.backgroundColor = kC_LineColor.CGColor;
                [btn.layer addSublayer:rightLayer];
                
            }
            
            UIColor *borderColor = kC_LineColor;
            //上边框
            CALayer * topLayer = [CALayer layer];
            topLayer.frame = CGRectMake(0, 0, btn.bounds.size.width, kW_LayerBorderWidth);
            topLayer.backgroundColor = borderColor.CGColor;
            [btn.layer addSublayer:topLayer];
//                //左边框
//                CALayer * leftLayer = [CALayer layer];
//                leftLayer.frame = CGRectMake(0, 0, kW_LayerBorderWidth, btn.bounds.size.height);
//                leftLayer.backgroundColor = borderColor.CGColor;
//                [btn.layer addSublayer:leftLayer];
//                //下边框
//                CALayer * bottomLayer = [CALayer layer];
//                bottomLayer.frame = CGRectMake(0, (btn.bounds.size.height - kW_LayerBorderWidth), btn.bounds.size.width, kW_LayerBorderWidth);
//                bottomLayer.backgroundColor = borderColor.CGColor;
//                //右边框
//                CALayer * rightLayer = [CALayer layer];
//                rightLayer.frame = CGRectMake((btn.bounds.size.width - kW_LayerBorderWidth), 0, kW_LayerBorderWidth, btn.bounds.size.height);
//                rightLayer.backgroundColor = borderColor.CGColor;
//                [btn.layer addSublayer:rightLayer];
        }
    }
   
}

- (void)show{
    [self addActivityBackgroundView];
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
//    self.transform = CGAffineTransformMakeScale(2.01, 2.01);
    
    //UIViewAnimationOptionCurveEaseIn从外往里,UIViewAnimationOptionCurveEaseOut从里往外
    [UIView animateWithDuration:kanimateDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.transform = CGAffineTransformIdentity;
                         self.backgroundColor = [UIColor whiteColor];
                         [[[[UIApplication sharedApplication]windows]firstObject]addSubview:self];
                         
                     }
                     completion:NULL
     ];
    
//    [UIView animateWithDuration:kanimateDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.transform = CGAffineTransformIdentity;
//        self.backgroundColor = [UIColor whiteColor];
//        [[[[UIApplication sharedApplication]windows]firstObject]addSubview:self];
//    } completion:^(BOOL finished) {
//        if(self.btnMarr.count == 0){
////            [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
//        }
//    }];
    
}

- (void)dismiss{
    [self removeActivityBackgroundView];
    [self removeFromSuperview];
    
}

- (void)handleBtnAction:(UIButton *)sender{
    NSLog(@"%@",sender.titleLabel.text);

    if (self.blockAlertView) {
        self.blockAlertView(self, sender.tag - kTAG_BTN);
    }
    [self dismiss];
}

- (void)actionWithBlock:(BlockAlertView)blockAlertView{
    self.blockAlertView = blockAlertView;
    
}

- (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;//折行方式
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName,paragraphStyle.copy,NSParagraphStyleAttributeName,nil];
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    size.height = ceil(size.height);
    //如果文字中可能会出现emoji表情的话, emoji的高度比文字要高一点点,+2
    //    size.height = size.height+2;
    return size;
}

//- (CGFloat) heightForString:(UITextView *)textView andWidth:(CGFloat)width{
//    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
//    return sizeToFit.height;
//}

-(void)setLineColor:(UIColor *)lineColor{
    
    for (UIButton * btn in self.btnMarr) {
        for (CALayer * layer in btn.layer.sublayers) {
            layer.backgroundColor = lineColor.CGColor;
        }
    }
}

- (NSMutableArray *)btnMarr{
    
    if (!_btnMarr) {
        _btnMarr = [NSMutableArray arrayWithCapacity:0];
    }
    return _btnMarr;
}

#pragma make - -textViewDeleagte
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}
//添加活动指示器背景图
- (void)addActivityBackgroundView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.1f;
        
        [[[UIApplication sharedApplication] keyWindow] addSubview:_maskView];
        return;
    }
    if (![_maskView isDescendantOfView:[[UIApplication sharedApplication] keyWindow]]) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:_maskView];
    }
}
//移除活动指示器背景图
- (void)removeActivityBackgroundView{
    if (_maskView) {
        if ([_maskView isDescendantOfView:[[UIApplication sharedApplication] keyWindow]]) {
            [_maskView removeFromSuperview];
        }
    }
}

@end

