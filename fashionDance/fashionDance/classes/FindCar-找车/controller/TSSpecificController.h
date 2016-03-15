//
//  TSSpecificController.h
//  fashionDance
//
//  Created by Dylan on 3/15/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSSpecificController : UIViewController
@property (nonatomic,strong)NSArray * specificArray;
@property (nonatomic,strong)NSString * titleStr;
+(instancetype)specificControllerWithArray:(NSArray *)specificArray andTitle:(NSString *)title;
@end
