//
//  TSXCCell.h
//  fashionDance
//
//  Created by Dylan on 3/16/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSSXCarModel.h"
#import "UIImageView+downloadImage.h"
@interface TSXCCell : UITableViewCell

+(TSXCCell *)cellWithTableView:(UITableView *)tableView;
-(void)configWithMod:(TSSXCarModel *)mod;
@end
