//
//  TSTitleCell.h
//  fashionDance
//
//  Created by Dylan on 3/15/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dtLabel;

+(TSTitleCell *)cellWithTableView:(UITableView *)tableView;
@end
