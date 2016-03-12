//
//  LLCarTypeVersionModel.m
//  __PRODUCTNAME__
//
//  Created by 李璐 on 16/03/11
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "LLCarTypeVersionModel.h"

@implementation LLCarTypeVersionModel


//+(NSDictionary *)mj_replacedKeyFromPropertyName
//{
//    
//    return @{@"min2scPrice":@"minDprice",@"max2scPrice":@"maxDprice"};
//}

-(void)configOffSaleWithYear:(NSNumber *)year
{
    //将maxDprice、minDprice补上，方便在cell中调用
    self.minDprice = self.min2scPrice;
    self.maxDprice = self.max2scPrice;
    //配置year
    self.year = year;
    
    self.isSale = NO;
}

-(void)configSale
{
    self.isSale = YES;
}

@end
