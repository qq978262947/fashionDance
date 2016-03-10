//
//  WJVideoTool.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/9.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJVideoTool.h"


@implementation WJVideoTool

singleton_m(Tool)

- (void)videoWithParam:(WJSpecialVideoParam *)param success:(void (^)(WJSpecialListResult *result))success failure:(void (^)(NSError *error))failure {
    [self getWithUrl:@"http://api.bilibili.cn/author_recommend" param:param resultClass:[WJSpecialListResult class] success:success failure:failure];
}


@end
