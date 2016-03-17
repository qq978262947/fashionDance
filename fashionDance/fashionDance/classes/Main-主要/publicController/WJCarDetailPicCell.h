//
//  WJCarDetailPicCell.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJCarDetailPicCell : UITableViewCell

+(id)carDetailPicCellWithTableView:(UITableView *)tableView;

@property (strong, nonatomic)NSString *picUrlString;

@end
