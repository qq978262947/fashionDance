//
//  YUHotTopicCell.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUHotTopicCell.h"
#import "YUHotTopicModel.h"
#import "UIImageView+downloadImage.h"

@interface YUHotTopicCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIButton *nickNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *barNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *replayCountBtn;

@end

@implementation YUHotTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTopicModel:(YUHotTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    self.titleLabel.text = topicModel.title;
    Pics *pic1 = topicModel.pics[0];
    [self.imageView1 setNormalImagewithURL:[NSURL URLWithString:pic1.url] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    
    Pics *pic2 = topicModel.pics[1];
    [self.imageView2 setNormalImagewithURL:[NSURL URLWithString:pic2.url] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    
    Pics *pic3 = topicModel.pics[2];
    [self.imageView3 setNormalImagewithURL:[NSURL URLWithString:pic3.url] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    [self.nickNameBtn setTitle:topicModel.nickName forState:UIControlStateNormal];
    [self.barNameBtn setTitle:topicModel.barName forState:UIControlStateNormal];
    [self.replayCountBtn setTitle:[NSString stringWithFormat:@"%ld",topicModel.replayCount]forState:UIControlStateNormal];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
