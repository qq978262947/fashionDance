//
//  YUSelectionTopic.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUSelectionTopic.h"
#import "YUHotTopicModel.h"

@implementation YUSelectionTopic


+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YUHotTopicModel class]};
}
@end



