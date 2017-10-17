//
//  NextViewController.m
//  CustomeAlertView
//
//  Created by hsf on 2017/9/29.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "NextViewController.h"

#import "BINAlertView.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBtnLaunchDialog];
    
}

- (void)addBtnLaunchDialog{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(10, 180, self.view.bounds.size.width-20, 50)];
    [btn addTarget:self action:@selector(launchDialog:) forControlEvents:UIControlEventTouchDown];
    [btn setTitle:@"Launch Dialog" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn.layer setBorderWidth:0];
    [btn.layer setCornerRadius:5];
    [self.view addSubview:btn];
    
    
    [self addLayerWithDirection:@"0" inView:btn];
    
    UIColor *borderColor = [UIColor redColor];
    //上边框
    CALayer * topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, btn.bounds.size.width, 1.0f);
    topBorder.backgroundColor = borderColor.CGColor;
    [btn.layer addSublayer:topBorder];
    //左边框
    CALayer * leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, 1.0f, btn.bounds.size.height);
    leftBorder.backgroundColor = borderColor.CGColor;
    [btn.layer addSublayer:leftBorder];
    //下边框
    CALayer * bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, (btn.bounds.size.height - 1), btn.bounds.size.width, 1);
    bottomBorder.backgroundColor = borderColor.CGColor;//没有贴到view上
    //右边框
    CALayer * rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake((btn.bounds.size.width - 1), 0.0, 1.0, btn.bounds.size.height);
    rightBorder.backgroundColor = borderColor.CGColor;
    [btn.layer addSublayer:rightBorder];
    
    btn.clipsToBounds = YES;
}
- (void)launchDialog:(UIButton *)sender{
    NSString * msg = @"不少金融机构看好苹果在中国市场的未来。\nCanalys 亚太区研究总监彭路平曾表示，iPhone 6 和 6s 在中国的用户基数非常大，累积了足够多的换机需求。而瑞银集团 (UBS) 的报告，亦强调 iPhone 在 2018 年将迎来巨大的换机潮。早前，摩根史丹利的报告更指出，iPhone 8 传说中的“大改动”（现在是 iPhone X）会吸引不少用户升级。\n虽然，苹果用户向来以忠诚度极高而驰名，但根据  Oppenheimer 的分析师 Andrew Uerkwitz 指出，iPhone 缺乏新意，与便宜的国产手机品牌差异性愈来愈少再加上微信等内地的生态系统的挑战，使中国 iPhone 用户的忠诚度在下跌。\n但值得注意的是，即使 iPhone 在中国的销量不断下降，而且 iPhone 用户的忠诚度貌似也下跌了，但出乎意料地，苹果在业绩最差的 2016 年，衍生出的 iPhone 经济效应却愈来愈强。\n根据 App Annie 的报告（上图），iPhone 6 在 2014 年于中国大卖，中国区的苹果 App Store 收入同时也大幅增加。但当  2016 年中国的 iPhone 市场不断的陷入滑波；可是，中国区的收入却没有因而下降，反而进一步取代美国，成为 App Store 的第一大市场。\nOdin 并不排除 2014 年 iPhone 6 的大卖的效应，可能需要一年的滞后时间才会显现出来，但到了 2016 年，App Store 在中国区更录得高达 258% 的惊人增幅，甚至是贡献了 App Store 在 2016 年的一半增幅，证明了 iPhone 在中国带来的经济效应，绝对没有因为 iPhone 销量下跌而减少。\n为什么 iPhone 在中国的销量减少，但应用市场反而蓬勃上升？\nApp Annie 曾经指出，App Store 与 Google Play 的最大分别，是 App Store 以收入为王，而 Google Play 以下载量为王。App Store 为什么在下载量更少的情况下，赚得更多的钱？Odin 认为，无疑是因为 iPhone 在各大市场里均称霸了当地的高端市场：由于 iPhone 用户群收入相对较高，也较愿意付费。";
    BINAlertView * alertView = [BINAlertView alertViewWithTitle:@"标题" message:msg customView:nil btnTitles:@[@"取消",@"其他",@"确认"]];
    [alertView show];
    [alertView actionWithBlock:^(BINAlertView *alertView, NSInteger btnIndex) {
        NSLog(@"%@====%@",alertView,@(btnIndex));
    }];
    
//    [UIView getLineWithView:alertView];

}

-(UIView *)createSpeakStartView{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 30)];
    //    UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
    
    view.backgroundColor = [UIColor clearColor];
    view.tag = 333;

    
    NSInteger count = 6;
    CGFloat imgWH = (kSCREEN_WIDTH - 25 * 2 - (6 - 1) * 5)/6;
    view.frame = CGRectMake(0, 0, kSCREEN_WIDTH, imgWH+5);
    for (int i = 0; i < count; i++) {
        
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:CGRectMake(10 + (imgWH + 5) * i , 0, imgWH, imgWH)];
        imgV.backgroundColor = [UIColor yellowColor];
        imgV.image = [UIImage imageNamed:@"star.png"];
        imgV.tag = kTAG_IMGVIEW + i;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapStar:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        imgV.userInteractionEnabled = YES;
        [imgV addGestureRecognizer:tap];
        
        [view addSubview:imgV];
    }
    
    return view;
}

- (void)tapStar:(UITapGestureRecognizer *)tap{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addLayerWithDirection:(NSString *)direction inView:(UIView *)inView{
    
    CGFloat lineHeight = 2;
    
    CALayer * layer = [CALayer layer];
    layer.borderColor = [[UIColor redColor]CGColor];
    switch ([direction integerValue]) {
        case 0://top
        {
            layer.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(inView.frame), lineHeight);
            
        }
            break;
        case 1://left
        {
            layer.frame = CGRectMake(0.0f, 0.0f, lineHeight, CGRectGetHeight(inView.frame));
            
        }
            break;
        case 2://bottom
        {
            layer.frame = CGRectMake(0.0f, CGRectGetHeight(inView.frame) - lineHeight, CGRectGetWidth(inView.frame), lineHeight);
            
        }
            break;
        case 3://right
        {
            layer.frame = CGRectMake(CGRectGetWidth(inView.frame) - lineHeight, 0,lineHeight, 0);
            
        }
            break;
        default:
            break;
    }
    [inView.layer addSublayer:layer];
    
}


@end
