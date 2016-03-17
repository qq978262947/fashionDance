//
//  TSHalfController.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSHalfController : UIViewController
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong)NSArray * titleArray;
+(instancetype)halfControllerWithArray:(NSArray *)dataArray andTitleArray:(NSArray *)titleArray;
@end
