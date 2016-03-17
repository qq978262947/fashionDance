//
//  WJTableViewCell.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJContentAppraiseModel.h"

@interface WJPraiseTableViewCell : UITableViewCell

+(id)praiseTableViewCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic)WJContentAppraiseModel *appraiseList;

@end
