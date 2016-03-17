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
@property (weak, nonatomic) IBOutlet UIImageView *eliteImageView;

@end

@implementation YUHotTopicCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setTopicModel:(YUHotTopicModel *)topicModel
{
    _topicModel = topicModel;
    self.imageView1.hidden = NO;
    self.imageView2.hidden = NO;
    self.imageView3.hidden = NO;
    self.titleLabel.text = topicModel.title;
    if (topicModel.pic1 && topicModel.pic2 && topicModel.pic3) {
    [self.imageView1 setNormalImagewithURL:[NSURL URLWithString:topicModel.pic1] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    
    [self.imageView2 setNormalImagewithURL:[NSURL URLWithString:topicModel.pic2] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    
    [self.imageView3 setNormalImagewithURL:[NSURL URLWithString:topicModel.pic3] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    } else if (topicModel.imgUrl){
        [self.imageView1 setNormalImagewithURL:[NSURL URLWithString:topicModel.imgUrl] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
        self.imageView2.hidden = YES;
        self.imageView3.hidden = YES;
    } else {
        self.imageView1.hidden = YES;
        self.imageView2.hidden = YES;
        self.imageView3.hidden = YES;
    }
    
    [self.nickNameBtn setTitle:topicModel.nickName?topicModel.nickName:topicModel.authorName forState:UIControlStateNormal];
    [self.barNameBtn setTitle:topicModel.barName forState:UIControlStateNormal];
    [self.replayCountBtn setTitle:[NSString stringWithFormat:@"%ld",topicModel.replayCount?topicModel.replayCount:topicModel.replyCount]forState:UIControlStateNormal];

    self.eliteImageView.hidden = !topicModel.isElite;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
