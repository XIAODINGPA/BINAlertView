//
//  NSMutableArray+Helper.m
//  WeiHouBao
//
//  Created by hsf on 2017/9/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NSMutableArray+Helper.h"

@implementation NSMutableArray (Helper)

-(void)addSafeObjct:(id)obj{
    
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        [self addObject:@""];

    }else{
        [self addObject:obj];
        
    }
    
}

@end
