//
//  NSObject+AOP.m
//  01-AOP(切面)思想
//
//  Created by wangjun on 15/12/23.
//  Copyright (c) 2015年 汪俊. All rights reserved.
//

#import "NSObject+WJAOP.h"
#import <objc/runtime.h>

@implementation NSObject (WJAOP)

+(void)aop_changeMethod:(SEL)oldMethod newMethod:(SEL)newMethod
{
    Method oldM  = class_getInstanceMethod([self class], oldMethod);
    Method newM = class_getInstanceMethod([self class], newMethod);
    method_exchangeImplementations(oldM, newM);
}

@end
