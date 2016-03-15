//
//  WJConsultingNoPicCell.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/15.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJList;

@interface WJConsultingNoPicCell : UITableViewCell
@property (strong, nonatomic)WJList *list;


+(id)consultingCellWithTableView:(UITableView *)tableView;
@end
