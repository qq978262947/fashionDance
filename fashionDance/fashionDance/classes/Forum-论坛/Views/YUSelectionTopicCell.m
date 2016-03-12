//
//  YUSelectionTopicCell.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUSelectionTopicCell.h"
#import "YUHotTopicModel.h"
#import "UIImageView+downloadImage.h"

@interface YUSelectionTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YUSelectionTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTopic:(YUHotTopicModel *)topic
{
    _topic = topic;
    
    [self.imgView setNormalImagewithURL:[NSURL URLWithString:topic.imgUrl] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    
    self.titleLabel.text = topic.title;

}

@end
