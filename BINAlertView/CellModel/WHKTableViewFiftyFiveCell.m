//
//  WHKTableViewFiftyFiveCell.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/26.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFiftyFiveCell.h"

@interface WHKTableViewFiftyFiveCell ()

@end

@implementation WHKTableViewFiftyFiveCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellIdentifier = @"WHKTableViewFiftyFiveCell";
    WHKTableViewFiftyFiveCell *cell = (WHKTableViewFiftyFiveCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[WHKTableViewFiftyFiveCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
        
    }
    return self;
}

- (void)createView{
    //文字+segment
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.segmentCtrl];
    [self.contentView addSubview:self.lineTop];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [UIView DisplayLastLineViewWithInset:self.separatorInset cell:self];
    
    //文字+segment
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:kScreen_width];
    }
    //控件>
    CGFloat YGap = kY_GAP;
//    CGFloat padding = 10;
    CGFloat height = 35;

    CGFloat lableLeftH = kH_LABEL;
    
    NSDictionary * dict = @{
                            @2 : @120,
                            @3 : @180,
                            @4 : @200,
                            };
    
    self.labelLeft.frame = CGRectMake(YGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    self.segmentCtrl.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame)+20, CGRectGetMidY(self.contentView.frame) - height/2.0, [dict[@(self.segmentCtrl.numberOfSegments)] floatValue], height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UIView *)lineTop{
    if (!_lineTop) {
        _lineTop = [UIView createLineWithRect:CGRectMake(0, 0, kScreen_width, kH_LINE_VIEW) isDash:NO tag:kTAG_VIEW+10];
        _lineTop.hidden = YES;
        
    }
    return _lineTop;
}

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    }
    return _labelLeft;
}

-(UISegmentedControl *)segmentCtrl{
    if (!_segmentCtrl) {
//        _segmentCtrl = [UIView createSegmentCtlWithRect:CGRectMake(0, 0, kScreen_width, 44) items:@[@"item0",@"item1",@"item2",@"item3"] selectedIndex:0 type:@"0"];
//        _segmentCtrl.selectedSegmentIndex = 0;
        //        _segmentCtrl.frame = CGRectZero;
        
        _segmentCtrl = [[UISegmentedControl alloc] initWithItems:@[@"item0",@"item1"]];
        _segmentCtrl.frame = CGRectMake(0, 0, kScreen_width, 44);
        
        _segmentCtrl.backgroundColor = [UIColor whiteColor];
        _segmentCtrl.tintColor = kC_ThemeCOLOR;
        
        _segmentCtrl.selectedSegmentIndex = 0;
  
        
    }
    return _segmentCtrl;
}

@end
