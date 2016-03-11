//
//  WJConsultingResult.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJConsultingResult.h"

@implementation WJConsultingResult

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

@end



@implementation WJModelResult

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [WJList class]};
}

@end


@implementation WJList

@end


