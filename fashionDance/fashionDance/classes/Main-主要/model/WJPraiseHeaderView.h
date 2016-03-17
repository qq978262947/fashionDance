//
//  WJPraiseHeaderView.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJHeaderAppraiseModel.h"

@interface WJPraiseHeaderView : UIView


+ (instancetype)praiseHeaderView;

+ (instancetype)praiseHeaderViewWithFrame:(CGRect)frame;

@property (strong, nonatomic)WJHeaderAppraiseModel *appraiseModel;

@end
