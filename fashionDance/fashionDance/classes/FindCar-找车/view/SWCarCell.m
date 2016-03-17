//
//  SWCarCell.m
//  fashionDance
//
//  Created by 苏威 on 16/3/15.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "SWCarCell.h"
#import "TSCarMod.h"
#import "UIImageView+WebCache.h"
@interface SWCarCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation SWCarCell
+(id)carCellWithTableView:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:className];
    return [tableView dequeueReusableCellWithIdentifier:className];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(TSCarMod *)model
{
    _model = model;
    self.nameLabel.text = model.nameZh;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.logoUrl]];
}
@end
