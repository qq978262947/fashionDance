
//
//  WJContentAppraiseModel.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJContentAppraiseModel : NSObject

@property (nonatomic, assign) NSInteger trimId;

@property (nonatomic, assign) NSInteger flagStatus;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger modelId;

@property (nonatomic, assign) CGFloat fuel;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *satisfy;

@property (nonatomic, copy) NSString *dissatisfy;

@property (nonatomic, copy) NSString *carName;

@property (nonatomic, assign) NSInteger avgScore;
@end
