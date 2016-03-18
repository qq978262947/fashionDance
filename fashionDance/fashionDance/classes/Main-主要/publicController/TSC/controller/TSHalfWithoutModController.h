//
//  TSHalfWithoutModController.h
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSHalfWithoutModController : UIViewController
@property (nonatomic,strong)NSArray * dataArray;
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSString * titleStr;
@property (nonatomic,copy)void (^TSHalfWithoutModControllerBlock)(TSHalfWithoutModController * half,NSNumber * number,NSString * title);

+(instancetype)halfControllerWithArray:(NSArray *)dataArray andTitleArray:(NSArray *)titleArray andtitle:(NSString *)title;
@end
