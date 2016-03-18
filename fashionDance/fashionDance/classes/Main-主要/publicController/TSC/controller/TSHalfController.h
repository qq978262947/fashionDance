//
//  TSHalfController.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSCKModel.h"

@interface TSHalfController : UIViewController
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong)NSArray * titleArray;

@property (nonatomic,copy)void (^TSHalfControllerBlock)(TSHalfController * half,TSCKModel * mod);

+(instancetype)halfControllerWithArray:(NSArray *)dataArray andTitleArray:(NSArray *)titleArray andtitle:(NSString *)title;
@end
