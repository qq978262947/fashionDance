//
//  YUCarDetailModel.m
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUCarDetailModel.h"

@implementation YUCarDetailModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"engineSize1" : @"engineSize[0]",
             @"engineSize2" : @"engineSize[1]"
             };
}
@end
