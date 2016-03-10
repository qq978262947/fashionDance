//
//  NSString+StringFromNumber.m
//  百思不得姐
//
//  Created by 汪俊 on 16/2/29.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "NSString+StringFromNumber.h"

@implementation NSString (StringFromNumber)

+ (NSString *)stringFromNumber:(long)number {
    NSString *stringNumber = nil;
    if (number < 10000) {
        stringNumber = [NSString stringWithFormat:@"%zd", number];
    } else if (number < 100000000) { // 大于等于10000
        stringNumber = [NSString stringWithFormat:@"%.1f万", number / 10000.0];
        stringNumber = [stringNumber stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }  else { // 大于等于1000000
        stringNumber = [NSString stringWithFormat:@"%.1f亿", number / 100000000.0];
        stringNumber = [stringNumber stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    return stringNumber;
}

@end
