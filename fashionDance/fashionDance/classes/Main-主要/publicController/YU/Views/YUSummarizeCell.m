//
//  YUSummarizeCell.m
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUSummarizeCell.h"
#import "YUCarCellModel.h"
#import "UICustomLineLabel.h"

@interface YUSummarizeCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *minDpriceLabel;
@property (weak, nonatomic) IBOutlet UICustomLineLabel *priceGuideLabel;
@property (weak, nonatomic) IBOutlet UILabel *trimTypeNameLabel;

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
    self.priceGuideLabel.lineType = LineTypeMiddle;
    self.trimTypeNameLabel.text = model.trimTypeName;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += 3;
    frame.size.height = 95 - 3;
    frame.origin.x = 3;
    
    frame.size.width = WJScreenW - frame.origin.x * 2;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
