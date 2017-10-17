//
//  NSObject+Helper.h
//  WeiHouBao
//
//  Created by hsf on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helper)

- (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth;

+ (NSString *)jsonToString:(id)data;

+ (NSString *)stringFromInteger:(NSInteger)integer;

+ (NSString *)stringDeleteWhiteSpace:(NSString *)string;

- (NSDate *)dateWithString:(NSString *)dateString;

- (NSString *)stringWithDate:(NSDate *)date;

//时间戳相关
+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp;
//当前时间戳
+ (NSString *)timestampFromNow;
//时间转化时间戳
+ (NSString *)timestampFromTime:(NSString *)formatTime formatter:(NSString *)format;
//时间戳转化时间
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp formatter:(NSString *)format;

//获取随机数
- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;
- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to;

@end
