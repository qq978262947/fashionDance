//
//  WJCarDetailWordCell.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJMoreAboutCarModel.h"

@interface WJCarDetailWordCell : UITableViewCell

+ (id)carDetailWordCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) WJMoreAboutCarModel *appraiseModel;

@end
