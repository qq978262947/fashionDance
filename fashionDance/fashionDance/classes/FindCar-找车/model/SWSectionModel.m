//
//  SWSectionModel.m
//  fashionDance
//
//  Created by 苏威 on 16/3/15.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "SWSectionModel.h"
#import "TSCarMod.h"
#import <MJExtension.h>
@implementation SWSectionModel
+(NSDictionary *)objectClassInArray{//数组中是某种模型
    return @{@"citys" : [TSCarMod class]};
}

@end
