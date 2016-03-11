//
//  WJConsultingTool.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJBaseTool.h"
#import "singleton.h"
#import "WJConsultingResult.h"

@interface WJConsultingTool : WJBaseTool
singleton_h(Tool)

- (void)consultingWithParam:(id)param success:(void (^)(WJConsultingResult *result))success failure:(void (^)(NSError *error))failure;

@end
