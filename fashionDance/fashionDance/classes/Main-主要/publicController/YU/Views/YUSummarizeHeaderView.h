//
//  YUSummarizeHeaderView.h
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YUCarDetailModel;
@interface YUSummarizeHeaderView : UIView

@property (nonatomic, strong) YUCarDetailModel *model;

+ (instancetype)headerView;

@end
