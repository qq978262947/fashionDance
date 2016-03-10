//
//  WJBaseTool.h
//  百思不得姐
//
//  Created by 汪俊 on 16/2/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WJBaseTool : NSObject


- (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

- (void)arrayGetWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 *  取消所有任务
 */
- (void)cancelAllOperation;


@end
