//
//  TSHalfColorController.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSColorMod.h"

@interface TSHalfColorController : UIViewController
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,copy)void (^TSHalfColorControllerBlock)(TSHalfColorController * half,TSColorMod * trim);


+(instancetype)halfControllerWithArray:(NSArray *)dataArray andTitleArray:(NSArray *)titleArray andtitle:(NSString *)title;
@end
