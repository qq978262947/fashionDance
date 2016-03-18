//
//  YUSummarizeHeaderView.m
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUSummarizeHeaderView.h"
#import "YUCarDetailModel.h"
#import "UIImageView+downloadImage.h"
#import "YULineLabel.h"

@interface YUSummarizeHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UILabel *hotPrice;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *onsellLabel;
@property (weak, nonatomic) IBOutlet UILabel *picCount;
@property (weak, nonatomic) IBOutlet YULineLabel *priceLabel;

@end

@implementation YUSummarizeHeaderView

+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)setModel:(YUCarDetailModel *)model
{
    _model = model;
    
    [self.carImageView setNormalImagewithURL:[NSURL URLWithString:model.picFocus] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    self.hotPrice.text = [NSString stringWithFormat:@"%.2f-%.2f万",model.minDprice,model.maxDprice];
    self.priceLabel.lineType = LineTypeMiddle;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f-%.2f万",model.min,model.max];
    self.oldPrice.text = [NSString stringWithFormat:@"%@ %@ %@",model.type1,model.engineSize1,model.engineSize2?model.engineSize2:@""];
    self.picCount.text = [NSString stringWithFormat:@"共%ld张图片",model.countPics];
    self.onsellLabel.text = @"在售";
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height = 300;
    
    [super setFrame:frame];
    
}
@end
