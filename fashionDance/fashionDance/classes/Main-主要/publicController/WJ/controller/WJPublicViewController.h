//
//  WJPublicViewController.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJSUVResult.h"

@interface WJPublicViewController : UIViewController

@property (strong, nonatomic)NSString *modelId;

@property (nonatomic, strong)WJCarModel *carModel;

+(instancetype)wjPublicViewControllerWithModID:(NSString *)modId;
@end
