//
//  YUForumHeaderView.h
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YUForumModel;
@interface YUForumHeaderView : UIView

@property (nonatomic, strong) YUForumModel *model;
+ (instancetype)headerView;
@end
