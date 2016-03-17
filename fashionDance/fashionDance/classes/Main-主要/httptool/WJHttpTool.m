//
//  WJHttpTool.m
//  百思不得姐
//
//  Created by 汪俊 on 16/2/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJHttpTool.h"
#import <AFNetworking.h>

@interface WJHttpTool ()
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation WJHttpTool

+ (instancetype)httpTool {
    return [[self alloc]init];
}


- (AFHTTPSessionManager *)manager{
    if (nil == _manager) {
        //1.获得请求管理者
        _manager = [[AFHTTPSessionManager alloc]init];
    }
    return _manager;
}



- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    //2.发送get请求
    [self.manager GET:url parameters:params progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //2.发送post请求
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)cancelAllOperation{
    [self.manager.operationQueue cancelAllOperations];
}

@end
