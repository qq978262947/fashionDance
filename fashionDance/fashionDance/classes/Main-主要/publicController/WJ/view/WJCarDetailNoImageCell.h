//
//  WJCarDetailNoImageCell.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/18.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJMoreAboutCarModel.h"

@interface WJCarDetailNoImageCell : UITableViewCell

@property (strong, nonatomic) WJMoreAboutCarModel *appraiseModel;

+ (id)carDetailWordCellWithTableView:(UITableView *)tableView;

- (void)setAppraiseModel:(WJMoreAboutCarModel *)appraiseModel WithIndex:(long)index;

@end
