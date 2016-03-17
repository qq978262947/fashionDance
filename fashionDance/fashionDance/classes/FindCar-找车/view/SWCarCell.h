//
//  SWCarCell.h
//  fashionDance
//
//  Created by 苏威 on 16/3/15.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSCarMod;
@interface SWCarCell : UITableViewCell
@property (nonatomic ,strong )TSCarMod *model;

+(id)carCellWithTableView:(UITableView *)tableView;
@end
