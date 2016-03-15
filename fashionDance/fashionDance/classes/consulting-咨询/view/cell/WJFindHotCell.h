//
//  WJSpecialVideoCell.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/9.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJSUVResult.h"

@interface WJFindHotCell : UITableViewCell

+(id)findHotCellCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic)WJCarModel *carModel;

@end
