//
//  TSCarMod.m
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSCarMod.h"

@implementation TSCarMod

+(instancetype)modWithDict:(NSDictionary *)dict
{
    TSCarMod * mod=[TSCarMod new];
    mod.capitalPy = [dict objectForKey:@"capitalPy"];
    mod.logoUrl = [dict objectForKey:@"logoUrl"];
    mod.namePy = [dict objectForKey:@"namePy"];
    mod.nameZh = [dict objectForKey:@"nameZh"];
    mod.ID = [dict objectForKey:@"id"];

    return mod;
}
@end
