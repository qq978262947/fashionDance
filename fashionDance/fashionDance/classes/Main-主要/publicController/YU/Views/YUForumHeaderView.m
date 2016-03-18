//
//  YUForumHeaderView.m
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUForumHeaderView.h"
#import "YUForumModel.h"
#import "UIImageView+downloadImage.h"

@interface YUForumHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *barNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicCountLabel;
@end

@implementation YUForumHeaderView

+ (instancetype)headerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)setModel:(YUForumModel *)model
{
    _model = model;
    
    [self.logoImageView setHeader:model.logoUrl];
    self.barNameLabel.text = model.barName;
    self.memberCountLabel.text = [NSString stringWithFormat:@"成员数：%@",model.memberCount];
    self.topicCountLabel.text = [NSString stringWithFormat:@"主贴数：%@",model.topicCount];

}


@end
