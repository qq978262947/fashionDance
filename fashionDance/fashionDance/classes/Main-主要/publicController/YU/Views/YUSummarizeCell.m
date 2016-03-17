//
//  YUSummarizeCell.m
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUSummarizeCell.h"
#import "YUCarCellModel.h"

@interface YUSummarizeCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *minDpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceGuideLabel;

@end

@implementation YUSummarizeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(YUCarCellModel *)model
{
    _model = model;
    self.nameLabel.text = [NSString stringWithFormat:@"%ld %@",model.year,model.nameZh];
    self.typeLabel.text = [NSString stringWithFormat:@"%@ %@",model.drvType,model.transType];
    self.minDpriceLabel.text = [NSString stringWithFormat:@"%.2f万起",model.minDprice];
    self.priceGuideLabel.text = [NSString stringWithFormat:@"指导价 %.2f万",model.priceGuide];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
