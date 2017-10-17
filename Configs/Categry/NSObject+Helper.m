//
//  NSObject+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)

#pragma mark - - sizeWithText

- (CGSize)sizeWithText:(NSString *)text fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;//折行方式
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName,paragraphStyle.copy,NSParagraphStyleAttributeName,nil];
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    //    NSLog(@"------%@",NSStringFromCGSize(size));//{300, 286.32000000000005}
    size.height = ceil(size.height);
    //如果文字中可能会出现emoji表情的话, emoji的高度比文字要高一点点,+2
    //    size.height = size.height+2;
    //    NSLog(@"===%@",NSStringFromCGSize(size));//{300, 287}
    return size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;//折行方式
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle.copy,NSParagraphStyleAttributeName,nil];
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    size.height = ceil(size.height);
    return size;
}

+ (NSString *)jsonToString:(id)data {
    if(data == nil) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringFromInteger:(NSInteger)integer{
    NSString *interString = [NSString stringWithFormat:@"%@",@(integer)];
    return interString;
    
}

+ (NSString *)stringInteger:(NSInteger)integer{
    NSString *interString = [NSString stringWithFormat:@"%@",@(integer)];
    interString = [@(integer) stringValue];
    return interString;
    
}

+ (NSString *)stringDeleteWhiteSpace:(NSString *)string{
    NSString * text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return text;
    
}

- (NSDate *)dateWithString:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateStyle = kCFDateFormatterShortStyle;
    formatter.timeStyle = kCFDateFormatterShortStyle;
    formatter.locale = [NSLocale currentLocale];

    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date = [formatter dateFromString:dateString];
    return date;
}

- (NSString *)stringWithDate:(NSDate *)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.dateStyle = kCFDateFormatterShortStyle;
    formatter.timeStyle = kCFDateFormatterShortStyle;
    formatter.locale = [NSLocale currentLocale];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [formatter stringFromDate:date];
    return dateStr;
}
#pragma mark - -时间戳
//G:      公元时代，例如AD公元
//yy:     年的后2位
//yyyy:   完整年
//MM:     月，显示为1-12,带前置0
//MMM:    月，显示为英文月份简写,如 Jan
//MMMM:   月，显示为英文月份全称，如 Janualy
//dd:     日，2位数表示，如02
//d:      日，1-2位显示，如2，无前置0
//EEE:    简写星期几，如Sun
//EEEE:   全写星期几，如Sunday
//aa:     上下午，AM/PM
//H:      时，24小时制，0-23
//HH:     时，24小时制，带前置0
//h:      时，12小时制，无前置0
//hh:     时，12小时制，带前置0
//m:      分，1-2位
//mm:     分，2位，带前置0
//s:      秒，1-2位
//ss:     秒，2位，带前置0
//S:      毫秒
//Z：     GMT（时区）

+ (NSString *)timeTipInfoFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter * dateFormtter = [[NSDateFormatter alloc] init];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSTimeInterval late =[date timeIntervalSince1970]*1;    //转记录的时间戳
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;   //获取当前时间戳
    NSString *timeString = @"";
    NSTimeInterval cha = now - late;
    // 发表在一小时之内
    if (cha/3600<1) {
        if (cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    // 在一小时以上24小以内
    else if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    // 发表在24以上10天以内
    else if (cha/86400>1&&cha/86400*3<1)     //86400 = 60(分)*60(秒)*24(小时)   3天内
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    // 发表时间大于10天
    else
    {
        [dateFormtter setDateFormat:@"yyyy-MM-dd"];
        timeString = [dateFormtter stringFromDate:date];
    }
    return timeString;
}
/**
 *  根据格式将时间戳转换成时间
 *  @param timestamp    时间戳
 *  @param dateFormtter 日期格式
 *
 *  @return 带格式的日期
 */
+ (NSString *)dateFromTimestamp:(NSInteger)timestamp
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString * timeStr = [formatter stringFromDate:date];
    return timeStr;
}
/**
 *  获取当前时间戳
 */
+ (NSString *)timestampFromNow
{
    // 获取时间（非本地时区，需转换）
    NSDate * today = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:today];
    // 转换成当地时间
    NSDate *localeDate = [today dateByAddingTimeInterval:interval];
    // 时间转换成时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[localeDate timeIntervalSince1970]];
    
    return timeSp;
}

#pragma mark - 将某个时间转化成 时间戳
+ (NSString *)timestampFromTime:(NSString *)formatTime{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSString * timestamp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] stringValue];
    return timestamp;
}

#pragma mark - 将某个时间戳转化成 时间
+ (NSString *)timeFromTimestamp:(NSInteger)timestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString * timeStr = [formatter stringFromDate:confromTimesp];
    return timeStr;
}

#pragma mark - -获取随机数，范围在[from,to]，包括from，包括to
- (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to
{
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

- (NSString *)getRandomStr:(NSInteger)from to:(NSInteger)to
{
    NSInteger random = (NSInteger)(from + (arc4random() % (to - from + 1)));
    NSString * randomStr = [@(random) stringValue];
    return randomStr;
}


@end
