//
//  TSCarPicMod.m
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSCarPicMod.h"

@implementation TSCarPicMod


+(instancetype)modWithDict:(NSDictionary *)dict
{
    TSCarPicMod * mod=[TSCarPicMod new];
    mod.colorId=dict[@"colorId"];
    mod.colorOpt=dict[@"colorOpt"];
    mod.flagType=dict[@"flagType"];
    mod.flagView=dict[@"flagView"];
    mod.ID=dict[@"id"];
    mod.modelId=dict[@"modelId"];
    mod.trimId=dict[@"trimId"];
    mod.url=dict[@"url"];
    return mod;
}
@end
