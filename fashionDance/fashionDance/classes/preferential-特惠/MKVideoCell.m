//
//  MKVideoCell.m
//  fashionDance
//
//  Created by Monky on 16/3/15.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "MKVideoCell.h"
#import "UIKit+AFNetworking.h"

@interface MKVideoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLAbel;
@property (weak, nonatomic) IBOutlet UILabel *parentName;

@end

@implementation MKVideoCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configureModel:(VedioResultList *)model
{
    self.titleLAbel.text = model.title;
    self.titleLAbel.numberOfLines = 0;
    self.parentName.text = model.cmsParentName;
    [self.imgView setImageWithURL:[NSURL URLWithString:model.picUrl]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
