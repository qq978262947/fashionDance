//
//  LLDBCarManager.h
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YUCarDetailModel;
@interface LLDBCarManager : NSObject

//收藏车
+ (LLDBCarManager *)sharedManager;

- (void)createDatabase;

- (void)insertCar:(YUCarDetailModel *)carModel;

- (NSArray *)searchAllCar;

- (void)deleteCarWithmodelId:(NSInteger)modelId;

//车浏览记录
-(void)insertCarfootmark:(YUCarDetailModel *)carModel;

-(NSArray *)searchAllfootmark;
@end
