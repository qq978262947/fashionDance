//
//  YUSelectionTopic.h
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YUHotTopicModel;
@interface YUSelectionTopic : NSObject

@property (nonatomic, strong) NSArray<YUHotTopicModel *> *list;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *cnName;

@end


