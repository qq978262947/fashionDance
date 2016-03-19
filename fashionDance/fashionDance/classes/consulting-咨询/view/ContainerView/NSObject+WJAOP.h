//
//  NSObject+AOP.h
//  01-AOP(切面)思想
//
//  Created by wangjun on 15/12/23.
//  Copyright (c) 2015年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WJAOP)

+(void)aop_changeMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

@end
