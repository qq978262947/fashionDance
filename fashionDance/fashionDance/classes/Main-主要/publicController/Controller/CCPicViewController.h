//
//  YUPicViewController.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCPicViewController : UIViewController

@property (strong, nonatomic)NSString *modelId;
@property (nonatomic,strong)NSNumber * trim;
@property (nonatomic,strong)NSNumber * color;
@property (nonatomic,strong)NSNumber * type;

@property (nonatomic,assign)NSInteger page;
@property (nonatomic,assign)NSInteger size;

+(instancetype)ccpicviewcontrollerWithString:(NSString *)modid;
@end
