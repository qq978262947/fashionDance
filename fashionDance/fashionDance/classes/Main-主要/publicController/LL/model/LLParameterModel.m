//
//  LLParameterModel.m
//  fashionDance
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLParameterModel.h"

@implementation LLParameterModel

+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
{
    if ([propertyName hasPrefix:@"a"]) {
        //将propertyname去掉前面的a
        NSString * result = [propertyName substringFromIndex:1];
        return result;
    }
    return propertyName;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"LLParameterModel<a102--%@ a303--%@>",self.a102,self.a303];
}

@end
