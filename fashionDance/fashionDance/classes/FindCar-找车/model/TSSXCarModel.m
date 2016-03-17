//
//  TSSXCarModel.m
//  fashionDance
//
//  Created by Dylan on 3/16/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSSXCarModel.h"

@implementation TSSXCarModel

+(instancetype)modWithDict:(NSDictionary *)dict
{
    TSSXCarModel * mod=[TSSXCarModel new];
    mod.modelUrl=[dict objectForKey:@"modelUrl"];
    mod.modelId=[dict objectForKey:@"modelId"];
    mod.modelName=[dict objectForKey:@"modelName"];
    mod.minPrice=[dict objectForKey:@"minPrice"];
    mod.maxPrice=[dict objectForKey:@"maxPrice"];
    
    return mod;
}
@end
