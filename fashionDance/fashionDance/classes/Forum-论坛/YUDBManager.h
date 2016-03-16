//
//  YUDBManager.h
//  Test
//
//  Created by qianfeng on 16/1/9.
//  Copyright (c) 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YUHotTopicModel;

@interface YUDBManager : NSObject

+ (YUDBManager *)sharedManager;

- (void)createDatabase;

- (void)insertTopic:(YUHotTopicModel *)topic;

- (NSArray *)searchAllTopic;

- (void)deleteTopicWithID:(NSInteger)bid;

- (void)deleteCollectWithTopic:(YUHotTopicModel *)Topic;

@end
