//
//  WJExetensionTool.m
//  百思不得姐
//
//  Created by 汪俊 on 16/2/26.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJExetensionTool.h"
#import <MJExtension.h>
#import "WJSpecialListResult.h"
#import "WJSpecialList.h"


@implementation WJExetensionTool

+ (void)setupSpecialVideoMode {
    [WJSpecialListResult mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list" : [WJSpecialList class]
                 };
    }];
}


@end
