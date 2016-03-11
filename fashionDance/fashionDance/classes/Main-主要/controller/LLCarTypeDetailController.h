//
//  LLCarTypeDetailController.h
//  fashionDance
//
//  Created by 李璐 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLCarTypeDetailController : UIViewController

/**
 *初始化务必用此方法  by：需保证在网络请求前已传入modelID
 */
+(LLCarTypeDetailController*)controllerWithModelId:(NSString*)modelID;

@end
