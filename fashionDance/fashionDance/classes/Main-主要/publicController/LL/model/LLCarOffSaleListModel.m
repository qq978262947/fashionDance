//
//  LLCarOffSaleListModel.m
//  __PRODUCTNAME__
//
//  Created by 李璐 on 16/03/11
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "LLCarOffSaleListModel.h"
#import "LLCarTypeVersionModel.h"

@implementation LLCarOffSaleListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"2013":@"abc",@"2014":@"_2014"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"abc" : [LLCarTypeVersionModel class], @"2014" : [LLCarTypeVersionModel class]};
}

@end
