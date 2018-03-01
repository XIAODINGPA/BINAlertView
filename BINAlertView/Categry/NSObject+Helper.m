//
//  NSObject+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSObject+Helper.h"
#import <objc/runtime.h>

#import "BINAlertView.h"

@implementation NSObject (Helper)

#pragma mark - -runtime
///通过运行时获取当前对象的所有属性的名称，以数组的形式返回
- (NSArray *)allPropertyNames:(NSString *)clsName{
    ///存储所有的属性名称
    NSMutableArray *allNames = [NSMutableArray arrayWithCapacity:0];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([NSClassFromString(clsName) class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    ///释放
    free(propertys);
    return allNames;
}

- (NSDictionary *)allPropertyDict{
    ///存储所有的属性名称
    NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        NSString * propertyKey = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        id propertyValue = [self valueForKey:propertyKey];
        if (propertyValue) {
            [mdict setValue:propertyValue forKey:propertyKey];
        }else{
            [mdict setValue:@"" forKey:propertyKey];
            
        }
    }
    ///释放
    free(propertys);
    return (NSDictionary *)mdict;
}


#pragma mark - -dispatchAsyncMain

void dispatchAsyncMain(void(^block)()){
//    dispatch_async(dispatch_get_main_queue(), block);
    if ([NSThread isMainThread]) {
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), block);
        
    }
}

void dispatchAsyncGlobal(void(^block)()){
    //    dispatch_async(dispatch_get_global_queue(0, 0), block);
    if (![NSThread isMainThread]) {
        block();
    }else{
        dispatch_async(dispatch_get_global_queue(0, 0), block);
        
    }
}

//void dispatchAfterDelay(void(^block)()){
//
//    double delayInSeconds = kAnimationDuration_Toast;
//    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(when, dispatch_get_main_queue(), ^{
//        block();
//    });
//}

void dispatchAfterDelay(double delay ,void(^block)()){
    
    double delayInSeconds = delay;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        block();
    });
}


#pragma mark - -validObject

-(BOOL)validObject:(id)objc{
    if (objc == nil) return NO;
    if ([objc isEqual:[NSNull null]])  return NO;
    if ([objc isKindOfClass:[NSNull class]]) return NO;
    
    if ([objc isKindOfClass:[NSString class]]){
        NSString *string = objc;
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray * array = @[@"",@"nil",@"null"];
        if ([array containsObject:string]) return NO;
        
    }
    else if ([objc isKindOfClass:[NSArray class]]){
        if ([objc count] == 0) return NO;
        
    }
    return YES;
}


-(BOOL)validObject{
    if (self == nil) return NO;
    if ([self isEqual:[NSNull null]])  return NO;
    if ([self isKindOfClass:[NSNull class]]) return NO;
    
    if ([self isKindOfClass:[NSString class]]){
        NSString *string = (NSString *)self;
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray * array = @[@"",@"nil",@"null"];
        if ([array containsObject:string]) {
//            DDLog(@"无效字符->(%@)",string);
           return NO;
        }
        
    }
    else if ([self isKindOfClass:[NSArray class]]){
        if ([(NSArray *)self count] == 0){
//            DDLog(@"空数组->(%@)",self);
            return NO;
        }
    }
    else if ([self isKindOfClass:[NSDictionary class]]){
        if ([(NSDictionary *)self count] == 0){
//            DDLog(@"空字典->(%@)",self);
           return NO;
        }
    }
    return YES;
}

-(BlockObject)blockObject{
    return objc_getAssociatedObject(self, _cmd);

}

-(void)setBlockObject:(BlockObject)blockObject{
    objc_setAssociatedObject(self, @selector(blockObject), blockObject, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

-(UIWindow *)keyWindow{
//    return [UIApplication sharedApplication].keyWindow;
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];;
    if (keyWindow == nil) {
        keyWindow = [[[UIApplication sharedApplication] delegate] window];

    }
    return keyWindow;
}

//-(void)setKeyWindow:(UIWindow *)keyWindow{
//    objc_setAssociatedObject(self, @selector(keyWindow), keyWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//}

-(UIViewController *)rootVC{
    //    return [UIApplication sharedApplication].keyWindow.rootViewController;
    return self.keyWindow.rootViewController;
}

//-(void)setRootVC:(UIViewController *)rootVC{
//    objc_setAssociatedObject(self, @selector(rootVC), rootVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//}

-(NSUserDefaults *)userDefaults{
    return [NSUserDefaults standardUserDefaults];
    
}

//-(void)setUserDefaults:(NSUserDefaults *)userDefaults{
//    objc_setAssociatedObject(self, @selector(userDefaults), userDefaults, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//}

#pragma mark - - sizeWithText

#pragma mark- - 富文本
/**
 富文本特殊部分设置
 */
- (NSDictionary *)attrDictWithFont:(id)font textColor:(UIColor *)textColor{
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    // 创建文字属性
    NSDictionary * dict = @{
                            NSFontAttributeName             :font,
                            NSForegroundColorAttributeName  :textColor
                            };
    
    return dict;
    
}

/**
 富文本整体设置
 */
- (NSDictionary *)attrParaDictWithFont:(id)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment{
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    
    NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    paraStyle.lineSpacing = 5;//行间距
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:[self attrDictWithFont:font textColor:textColor]];
    [mdict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    
    return mdict;
    
}

/**
 富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width{
    NSAssert([text isKindOfClass:[NSString class]] || [text isKindOfClass:[NSAttributedString class]], @"请检查text格式!");
    NSAssert([font isKindOfClass:[UIFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [UIFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    
    NSDictionary *attrDict = [self attrParaDictWithFont:font textColor:[UIColor blackColor] alignment:NSTextAlignmentLeft];
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:attrDict context:nil].size;
    size.height = ceil(size.height);
    return size;
}

/**
 (详细)富文本产生
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者UIFont)
 @param tapFontSize 特殊部分子体大小(传NSNumber或者UIFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont tapColor:(UIColor *)tapColor alignment:(NSTextAlignment)alignment{

    NSAssert(textTaps.count >0, @"textTaps不能为空!");
    NSAssert([font isKindOfClass:[UIFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    // 设置段落
    NSDictionary *paraDict = [self attrParaDictWithFont:font textColor:[UIColor blackColor] alignment:alignment];
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:text attributes:paraDict];
    
    for (NSString *textTap in textTaps) {
        NSAssert([text containsString:textTap],@"textTaps中有不被字符串包含的元素");
        
        NSRange range = [text rangeOfString:textTap];
        // 创建文字属性
        NSDictionary * attrDict = [self attrDictWithFont:tapFont textColor:tapColor];
        [attString addAttributes:attrDict range:range];
        
    }
    return (NSAttributedString *)attString;
}

/**
 富文本产生
 */
- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:NSMakeRange(0, string.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++) {
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:[string rangeOfString:textTaps[i]]];
        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:KFZ_Fouth] range:[string rangeOfString:textTaps[i]]];
        
    }
    return attString;
}

@end
