//
//  WJConstraintModel.m
//  WJContainerViewExample
//
//  Created by 汪俊 on 16/3/14.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJConstraintModel.h"

@implementation WJConstraintModel

+ (instancetype)constraintModel {
    return [[self alloc]init];
}


- (instancetype)init {
    if (self = [super init]) {
        self.configConstraint = NO;
    }
    return self;
}


@end
