//
//  YUArticleNewsCell.m
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUArticleNewsCell.h"
#import "YUTitleNews.h"
#import "UIImageView+downloadImage.h"

@interface YUArticleNewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;
@property (weak, nonatomic) IBOutlet UIButton *authorBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentsBtn;

@end

@implementation YUArticleNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTitleNews:(YUTitleNews *)titleNews
{
    _titleNews = titleNews;
    
    [self.carImageView setNormalImagewithURL:[NSURL URLWithString:titleNews.picUrl] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    self.titleLabel.text = titleNews.title;
    [self.authorBtn setTitle:titleNews.media forState:UIControlStateNormal];
    [self.commentsBtn setTitle:[NSString stringWithFormat:@"%ld",titleNews.comments] forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
