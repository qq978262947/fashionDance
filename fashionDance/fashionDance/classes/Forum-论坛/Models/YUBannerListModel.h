//
//  YUBannerListModel.h
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//YUHotTopicModel

#import <Foundation/Foundation.h>

@class YUHotTopicModel;

@interface YUBannerListModel : NSObject

@property (nonatomic, strong) YUHotTopicModel *topic;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *imgUrl;

@end


