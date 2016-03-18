//
//  TSCKModel.m
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSCKModel.h"

@implementation TSCKModel
+(instancetype)modWithDictionary:(NSDictionary *)dict
{
    TSCKModel * mod=[TSCKModel new];

    mod.imageCount=[dict objectForKey:@"imageCount"];
    mod.isOnsale=[dict objectForKey:@"isOnsale"];
    mod.trimId=[dict objectForKey:@"trimId"];
    mod.trimName=[dict objectForKey:@"trimName"];
    mod.year=[dict objectForKey:@"year"];
    
    return mod;
}
@end
