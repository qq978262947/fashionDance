//
//  WJConsultingTool.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJConsultingTool.h"

@implementation WJConsultingTool
singleton_m(Tool)

- (void)consultingWithParam:(id)param success:(void (^)(WJConsultingResult *result))success failure:(void (^)(NSError *error))failure {
    [self getWithUrl:@"http://autoapp.auto.sohu.com/api/cmsnews/list_1457589190511_1457656421121.json" param:nil resultClass:[WJConsultingResult class] success:success failure:failure];
}


@end
