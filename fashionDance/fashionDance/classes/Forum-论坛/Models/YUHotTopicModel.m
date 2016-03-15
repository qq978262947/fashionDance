//
//  YUHotTopicModel.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUHotTopicModel.h"

@implementation YUHotTopicModel

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [Pics class]};
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"topicDescription" : @"description",
             };
}

@end

@implementation Pics

@end


