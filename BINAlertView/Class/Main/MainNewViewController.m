
//
//  MainNewViewController.m
//  CustomeAlertView
//
//  Created by hsf on 2017/10/17.
//  Copyright © 2017年 SouFun. All rights reserved.
//

#import "MainNewViewController.h"

#import "MQVerCodeInputView.h"
#import "BINAlertView.h"

#import "MyView.h"

@interface MainNewViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MainNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.title = self.controllerName;
   
    [self createControls];
    
}

- (void)createControls{
    for (NSInteger i = 0; i< 9; i++) {
        NSString * title = [NSString stringWithFormat:@"点我%@",@(i)];
        CGRect btnRect = CGRectMake(kX_GAP*4, kY_GAP*2 + (40 + 10)*i, kScreen_width - kX_GAP*8, 40);
        UIButton * btn = [UIView  createBtnWithRect:btnRect title:title  fontSize:15 image:nil tag:kTAG_BTN+i patternType:@"8" target:self aSelector:@selector(handleActionBtn:)];
        [self.view addSubview:btn];
    }
}

- (void)handleActionBtn:(UIButton *)sender{
    
    switch (sender.tag-kTAG_BTN) {
        case 0:
        {
            UIView * view = [self getCodeViewWithSize:CGSizeMake(0, 40) count:4 ];
            BINAlertView * alertView = [BINAlertView alertViewWithTitle:@"请输入收货人手机验证码" message:nil customView:view btnTitles:@[@"确定"]];
            NSLog(@"maxWidth_%.2f",alertView.maxWidth);
            [alertView show];
            [alertView actionWithBlock:^(BINAlertView *alertView, NSInteger btnIndex) {
                NSLog(@"%@====%@",alertView,@(btnIndex));
            }];

        }
            break;
        case 1:
        {
            NSString * msg = @"不少金融机构看好苹果在中国市场的未来。\nCanalys 亚太区研究总监彭路平曾表示，iPhone 6 和 6s 在中国的用户基数非常大，累积了足够多的换机需求。而瑞银集团 (UBS) 的报告，亦强调 iPhone 在 2018 年将迎来巨大的换机潮。早前，摩根史丹利的报告更指出，iPhone 8 传说中的“大改动”（现在是 iPhone X）会吸引不少用户升级。\n虽然，苹果用户向来以忠诚度极高而驰名，但根据  Oppenheimer 的分析师 Andrew Uerkwitz 指出，iPhone 缺乏新意，与便宜的国产手机品牌差异性愈来愈少再加上微信等内地的生态系统的挑战，使中国 iPhone 用户的忠诚度在下跌。\n但值得注意的是，即使 iPhone 在中国的销量不断下降，而且 iPhone 用户的忠诚度貌似也下跌了，但出乎意料地，苹果在业绩最差的 2016 年，衍生出的 iPhone 经济效应却愈来愈强。\n根据 App Annie 的报告（上图），iPhone 6 在 2014 年于中国大卖，中国区的苹果 App Store 收入同时也大幅增加。但当  2016 年中国的 iPhone 市场不断的陷入滑波；可是，中国区的收入却没有因而下降，反而进一步取代美国，成为 App Store 的第一大市场。\nOdin 并不排除 2014 年 iPhone 6 的大卖的效应，可能需要一年的滞后时间才会显现出来，但到了 2016 年，App Store 在中国区更录得高达 258% 的惊人增幅，甚至是贡献了 App Store 在 2016 年的一半增幅，证明了 iPhone 在中国带来的经济效应，绝对没有因为 iPhone 销量下跌而减少。\n为什么 iPhone 在中国的销量减少，但应用市场反而蓬勃上升？\nApp Annie 曾经指出，App Store 与 Google Play 的最大分别，是 App Store 以收入为王，而 Google Play 以下载量为王。App Store 为什么在下载量更少的情况下，赚得更多的钱？Odin 认为，无疑是因为 iPhone 在各大市场里均称霸了当地的高端市场：由于 iPhone 用户群收入相对较高，也较愿意付费。";
            BINAlertView * alertView = [BINAlertView alertViewWithTitle:@"标题" message:msg customView:nil btnTitles:@[@"取消",@"其他",@"确认"]];
            [alertView show];
            [alertView actionWithBlock:^(BINAlertView *alertView, NSInteger btnIndex) {
                NSLog(@"%@====%@",alertView,@(btnIndex));
            }];

            
        }
            break;
        case 2:
        {
            BINAlertView * alertView = [BINAlertView alertViewWithTitle:@"请选择" message:nil customView:[self createTableView] btnTitles:@[@"取消",@"确认"]];
            [alertView show];
            [alertView actionWithBlock:^(BINAlertView *alertView, NSInteger btnIndex) {
                NSLog(@"%@====%@",alertView,@(btnIndex));
            }];
//            [UIView getLineWithView:alertView];
        }
            break;
        case 3:
        {
            //MyView初代代码,用于新功能测试开发
            MyView * grayView = [[MyView alloc]initWithFrame:CGRectZero Title:@"测试视图" message:@"msg" orCustomeView:[self createTableView] delegate:self buttonTitles:[NSArray arrayWithObjects:@"cancell",@"ok", nil]];
            [grayView showMyView];
        }
            break;
        case 4:
        {
            UIWindow * window = [[UIApplication sharedApplication]keyWindow];
//            [MBProgressHUD showHUDinView:window animated:YES];
//
//            if ([MBProgressHUD HUDForView:window]) {
//                MBProgressHUD *hud = [MBProgressHUD HUDForView:window];
//                [hud changeHUDtext:@"标题" detailText:@"详情" duration:2];
//
//            }
            
            [self showAlertWithTitle:@"添加猪品种" placeholderList:@[@"(必填)品种名称(汉字)",@"(选填)品种代号(英文字母)"] msg:nil
                     actionTitleList:@[kActionTitle_Cancell,kActionTitle_Sure] handler:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nullable action) {
                         DDLog(@"___%@",alertController.textFields.firstObject);
                         DDLog(@"________%@",alertController.textFields.lastObject);

                     }];
        }
            break;
        case 5:
        {
            NSString * string = @"*品种名称";
            NSArray * textTaps = @[@"*"];
            NSAttributedString * attString = [self getAttString:string textTaps:textTaps font:@15 tapFont:@15 tapColor:[UIColor redColor] alignment:NSTextAlignmentCenter];
            
            NSAttributedString * attStringOne = [self getAttString:string textTaps:textTaps font:@15 tapFont:@15 tapColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];

            
            NSArray * array = @[attStringOne,attString];
            NSDictionary * dict = @{
                                    @"*品种名称" : @"汉字",
                                    @"*品种代号" : @"英文字母大写"
                                    
                                    };

            UIView * view = [self createViewByItems:array itemDict:dict];
            BINAlertView * alertView = [BINAlertView alertViewWithTitle:@"添加猪品种" message:nil customView:view btnTitles:@[@"取消",@"确认"]];
            [alertView show];
            [alertView actionWithBlock:^(BINAlertView *alertView, NSInteger btnIndex) {
                NSLog(@"%@====%@",alertView,@(btnIndex));
            }];
            
//            [UIView getLineWithView:alertView];

        }
            break;
        case 6:
        {
            NSString * string = @"*品种名称";
            NSArray * textTaps = @[@"*"];
            NSAttributedString * attString = [self getAttString:string textTaps:textTaps font:@15 tapFont:@15 tapColor:[UIColor redColor] alignment:NSTextAlignmentCenter];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 50)];
            label.attributedText = attString;
            label.font = [UIFont systemFontOfSize:15];
            
            UIView * view = label;
            BINAlertView * alertView = [BINAlertView alertViewWithTitle:@"添加猪品种" message:nil customView:view btnTitles:@[@"取消",@"确认"]];
            [alertView show];
            [alertView actionWithBlock:^(BINAlertView *alertView, NSInteger btnIndex) {
                NSLog(@"%@====%@",alertView,@(btnIndex));
            }];
            
        }
            break;
        case 7:
        {
            NSString * string = @"*品种名称";
            NSArray * textTaps = @[@"*"];
            NSAttributedString * attString = [self getAttString:string textTaps:textTaps font:@15 tapFont:@15 tapColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, 50)];
            label.attributedText = attString;
            label.font = [UIFont systemFontOfSize:15];
            
            UIView * view = label;
            BINAlertView * alertView = [BINAlertView alertViewWithTitle:@"添加猪品种" message:nil customView:view btnTitles:@[@"取消",@"确认"]];
            [alertView show];
            [alertView actionWithBlock:^(BINAlertView *alertView, NSInteger btnIndex) {
                NSLog(@"%@====%@",alertView,@(btnIndex));
            }];
            
        }
            break;
        case 8:
        {
            NSArray * array = @[@"*品种名称",@"*品种代号",@"*品种备注"];
            NSArray * arraySub = @[@"*品种名称",@"*品种备注"];

            NSArray * attList = [self getAttListByString:@"*" titleList:array mustList:arraySub];
            
            NSDictionary * dict = @{
                                    @"*品种名称" : @"汉字",
                                    @"*品种代号" : @"英文字母大写",
                                    @"*品种备注" : @""

                                    };
            
            UIView * view = [self createViewByItems:attList itemDict:dict];
            BINAlertView * alertView = [BINAlertView alertViewWithTitle:@"添加猪品种" message:nil customView:view btnTitles:@[@"取消",@"确认"]];
            [alertView show];
            [alertView actionWithBlock:^(BINAlertView *alertView, NSInteger btnIndex) {
                NSLog(@"%@====%@",alertView,@(btnIndex));
            }];
            
            //            [UIView getLineWithView:alertView];

            
        }
            break;
        default:
            break;
    }
}

-(NSArray *)getAttListByString:(NSString *)string titleList:(NSArray *)titleList mustList:(NSArray *)mustList{
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];

    for (NSString * item in titleList) {
        NSString * title = item;
        if (![title hasPrefix:string]) title = [string stringByAppendingString:title];
        if (![marr containsObject:title]) [marr addObject:title];
        
        UIColor * colorMust = [mustList containsObject:title] ? [UIColor redColor] : [UIColor clearColor];
        
        NSArray * textTaps = @[string];
        NSAttributedString * attString = [self getAttString:title textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
        
        if (![marr containsObject:attString]) {
            NSUInteger index = [marr indexOfObject:title];
            [marr replaceObjectAtIndex:index withObject:attString];
            
        }
    }
    return marr.copy;
    
}

- (UIView *)getCodeViewWithSize:(CGSize)viewSize count:(NSInteger)count{
    
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width - 50, viewSize.height + kPadding *2)];
    
    CGSize verCodeViewSize = CGSizeMake(viewSize.height * count + kX_GAP * (count - 1), viewSize.height);
    CGFloat minX = (CGRectGetWidth(backgroudView.frame) - verCodeViewSize.width)/2.0;
    DDLog(@"%.2f",minX);
    MQVerCodeInputView *verCodeView = [[MQVerCodeInputView alloc]initWithFrame:CGRectMake(0, kPadding, verCodeViewSize.width, verCodeViewSize.height)];
    verCodeView.viewColorHL = kC_LineColor;
    verCodeView.viewColor = kC_LineColor;
    
    verCodeView.maxLenght = count;//最大长度
    verCodeView.keyBoardType = UIKeyboardTypeNumberPad;
    [verCodeView mq_verCodeViewWithMaxLenght];
    verCodeView.block = ^(NSString *text){
        NSLog(@"text = %@",text);
    };
    
    [backgroudView addSubview:verCodeView];
    
//    backgroudView.backgroundColor = [UIColor yellowColor];
//    verCodeView.backgroundColor = [UIColor orangeColor];
    return backgroudView;
    
}


//加tableview
-(UITableView *)createTableView{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //    tableView.backgroundColor = [UIColor yellowColor];
    return tableView;
}

#pragma mark - - tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //    cell.backgroundColor = [UIColor orangeColor];
    
    cell.imageView.image = [UIImage imageNamed:@"dragon"];
    cell.textLabel.text = @"title";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"row__%ld",indexPath.row];
    
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame),  CGRectGetHeight(cell.frame))];
    backgroudView.backgroundColor = [UIColor cyanColor];
    cell.selectedBackgroundView = backgroudView;
    
    //    NSLog(@"cell-%ld",(long)indexPath.row);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%ld",(long)indexPath.row);
    
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    MyView * myView = (MyView *)[window viewWithTag:105];
//    [myView dismissMyView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}


- (UIView *)createViewByItems:(NSArray *)items itemDict:(NSDictionary *)itemDict{
    
    CGFloat viewHeight = 30;
    CGFloat height = items.count *viewHeight + (items.count - 1)*kPadding;
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, height)];
    
    CGRect rectLab = CGRectZero;
    for (NSInteger i = 0; i<items.count; i++) {
        
        CGSize size = [self sizeWithText:items[i] font:@15 width:kScreen_width];
        if (CGRectEqualToRect(rectLab, CGRectZero)) {
            rectLab = CGRectMake(0, CGRectGetMaxY(rectLab), size.width, viewHeight);

        }else{
            rectLab = CGRectMake(0, CGRectGetMaxY(rectLab)+kPadding, size.width, viewHeight);

        }
        UILabel * label = [UIView createLabelWithRect:rectLab text:items[i] textColor:nil tag:kTAG_LABEL+i patternType:@"2" fontSize:15 backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentCenter];
        
        CGRect rectTextField = CGRectMake(CGRectGetMaxX(rectLab)+kPadding, CGRectGetMinY(rectLab), CGRectGetWidth(backgroudView.frame) - CGRectGetMaxX(rectLab) - kPadding, viewHeight);
        UITextField * textField = [UIView createTextFieldWithRect:rectTextField text:@"" placeholder:itemDict[items[i]] fontSize:15 textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault];
        [backgroudView addSubview:label];
        [backgroudView addSubview:textField];
        
        textField.borderStyle = UITextBorderStyleNone;
        [textField.layer addSublayer:[textField createLayerByPatternType:@"2"]];//下线条

    }
    return backgroudView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
