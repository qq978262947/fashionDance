//
//  LLCarTypeVersionModel.m
//  __PRODUCTNAME__
//
//  Created by 李璐 on 16/03/11
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "LLCarTypeVersionModel.h"

@implementation LLCarTypeVersionModel


+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"minDprice":@"min2scPrice",@"maxDprice":@"max2scPrice"};
}
@end
