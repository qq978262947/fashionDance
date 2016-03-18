//
//  TSColorMod.m
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSColorMod.h"

@implementation TSColorMod

+(instancetype)modWithDict:(NSDictionary *)dict
{
    TSColorMod * mod=[TSColorMod new];
    mod.colorName=dict[@"colorName"];
    mod.colorValue1=dict[@"colorValue1"];
    mod.colorValue2=dict[@"colorValue2"];
    mod.ID=dict[@"id"];
    mod.modelId=dict[@"modelId"];
    
    return mod;
}

@end
