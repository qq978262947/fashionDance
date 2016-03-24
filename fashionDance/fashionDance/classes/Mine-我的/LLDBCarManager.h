//
//  LLDBCarManager.h
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WJList;
@interface LLDBCarManager : NSObject

+ (LLDBCarManager *)sharedManager;

- (void)createDatabase;

- (void)insertTopic:(WJList *)carU;

- (NSArray *)searchAllTopic;

- (void)deleteTopicWithID:(NSInteger)bid;

@end
