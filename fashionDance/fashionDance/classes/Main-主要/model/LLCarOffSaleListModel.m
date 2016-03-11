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
    return @{@"_2013":@"2013",@"_2014":@"2014"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"_2013" : [LLCarTypeVersionModel class], @"_2014" : [LLCarTypeVersionModel class]};
}

@end
