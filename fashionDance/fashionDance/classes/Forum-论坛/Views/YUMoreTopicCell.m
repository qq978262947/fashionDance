//
//  YUMoreTopicCell.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUMoreTopicCell.h"
#import "YUHotTopicModel.h"
#import "UIImageView+downloadImage.h"


@interface YUMoreTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *authorBtn;
@property (weak, nonatomic) IBOutlet UIButton *barNameBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyCountBtn;
@end

@implementation YUMoreTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTopic:(YUHotTopicModel *)topic
{
    _topic = topic;
    
    [self.imgView setNormalImagewithURL:[NSURL URLWithString:topic.imgUrl] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    self.titleLabel.text = topic.title;
    self.topicDescriptionLabel.text = topic.topicDescription;
    [self.authorBtn setTitle:topic.authorName forState:UIControlStateNormal];
    [self.barNameBtn setTitle:topic.barName forState:UIControlStateNormal];
    [self.replyCountBtn setTitle:[NSString stringWithFormat:@"%ld",topic.replyCount] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
