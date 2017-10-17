//
//  BINTextView.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINTextView.h"

@interface BINTextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, assign) CGFloat padding;

@end

@implementation BINTextView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.placeholder = @"";
        self.placeholderColor = [UIColor lightGrayColor];
        self.padding = 8;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
        if (self.placeHolderLabel == nil) {
            UILabel * tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            tempLabel.font = self.font;
            tempLabel.numberOfLines = 0;
            tempLabel.lineBreakMode = NSLineBreakByCharWrapping;
            tempLabel.backgroundColor = [UIColor clearColor];
            tempLabel.textColor = self.placeholderColor;
            tempLabel.hidden = NO;
            
            self.placeHolderLabel = tempLabel;
            [self addSubview:self.placeHolderLabel];
        }

    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if (self.text.length == 0) {
        self.placeHolderLabel.hidden = NO;
        
    }else{
        self.placeHolderLabel.hidden = YES;
        
    }
}

-(void)setText:(NSString *)text{
    [super setText:text];
    [self textChanged:nil];
    
}

-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeHolderLabel.font = font;
}

-(void)setPlaceholder:(NSString *)placeholder{
    [self textChanged:nil];
    self.placeHolderLabel.text = placeholder;

    CGSize labelSize = [self sizeWithText:self.placeHolderLabel.text font:self.font maxWidth:self.frame.size.width];
    self.placeHolderLabel.frame = CGRectMake(self.padding, self.padding, self.bounds.size.width - self.padding * 2, labelSize.height);
    
    self.placeHolderLabel.textColor = self.placeholderColor;

}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    self.placeHolderLabel.textColor = placeholderColor;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];

    if (self.text.length == 0 && self.placeHolderLabel.text.length > 0) {
        self.placeHolderLabel.hidden = NO;
        
    }else{
        self.placeHolderLabel.hidden = YES;

    }
    
}

#pragma mark - -
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;//折行方式
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle.copy,NSParagraphStyleAttributeName,nil];
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    //    NSLog(@"------%@",NSStringFromCGSize(size));//{300, 286.32000000000005}
    size.height = ceil(size.height);
    //如果文字中可能会出现emoji表情的话, emoji的高度比文字要高一点点,+2
    //    size.height = size.height+2;
    //    NSLog(@"===%@",NSStringFromCGSize(size));//{300, 287}
    return size;
}

@end
