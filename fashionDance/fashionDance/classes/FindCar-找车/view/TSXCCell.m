//
//  TSXCCell.m
//  fashionDance
//
//  Created by Dylan on 3/16/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSXCCell.h"
@interface TSXCCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation TSXCCell
+(TSXCCell *)cellWithTableView:(UITableView *)tableView
{
    NSString * identifity=NSStringFromClass([self class]);
    UINib * nib=[UINib nibWithNibName:identifity bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifity];
    return [tableView dequeueReusableCellWithIdentifier:identifity];
}
-(void)configWithMod:(TSSXCarModel *)mod
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:mod.modelUrl] placeholderImage:[UIImage imageNamed:@"error"]];
    self.nameLabel.text=mod.modelName;
    NSString * price=[NSString stringWithFormat:@"%@万~%@万",mod.minPrice,mod.maxPrice];
    self.priceLabel.text=price;
}
@end
