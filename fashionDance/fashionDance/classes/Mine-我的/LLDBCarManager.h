//
//  LLDBCarManager.h
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YUCarCellModel;
@interface LLDBCarManager : NSObject

//收藏车
+ (LLDBCarManager *)sharedManager;

- (void)createDatabase;

- (void)insertCar:(YUCarCellModel *)carModel;

- (NSArray *)searchAllCar;

- (void)deleteTopicWithTrimID:(NSInteger)trimId;

//车浏览记录

@end
