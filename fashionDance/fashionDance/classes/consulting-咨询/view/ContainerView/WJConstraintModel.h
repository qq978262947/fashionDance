//
//  WJConstraintModel.h
//  WJContainerViewExample
//
//  Created by 汪俊 on 16/3/14.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WJConstraintModel : NSObject

+ (instancetype)constraintModel;
/**
 *  对应的视图
 */
@property (weak, nonatomic)UIViewController *viewController;
/**
 *  是否已约束的标记
 */
@property (assign, nonatomic, getter=isConfigConstraint)BOOL configConstraint;

@end
