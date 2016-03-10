//
//  WJVideoTool.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/9.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJBaseTool.h"
#import "singleton.h"
#import "WJSpecialListResult.h"
#import "WJSpecialVideoParam.h"

@interface WJVideoTool : WJBaseTool
singleton_h(Tool)

- (void)videoWithParam:(WJSpecialVideoParam *)param success:(void (^)(WJSpecialListResult *result))success failure:(void (^)(NSError *error))failure;

@end
