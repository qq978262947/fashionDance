//
//  TSLXModel.m
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSLXModel.h"

@implementation TSLXModel
+(instancetype)modWithDict:(NSDictionary *)dict
{
    TSLXModel * mod=[TSLXModel new];

    mod.index=dict[@"index"];
    mod.PicId=dict[@"PicId"];
    mod.PicUrl=dict[@"PicUrl"];
    return mod;
}
@end
