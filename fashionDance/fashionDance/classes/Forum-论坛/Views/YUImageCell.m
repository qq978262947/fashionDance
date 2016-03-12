//
//  YUImageCell.m
//  无线滚动
//
//  Created by qianfeng on 16/2/27.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "YUImageCell.h"
#import "UIImageView+downloadImage.h"
#import "YUBannerListModel.h"

@interface YUImageCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation YUImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WJScreenW, YUImageCellH)];
        [self addSubview:image];
        self.imageView = image;
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setBannerListModel:(YUBannerListModel *)bannerListModel
{
    _bannerListModel = bannerListModel;
    
    [self.imageView setNormalImagewithURL:[NSURL URLWithString:bannerListModel.imgUrl] placeholderImage:[UIImage imageNamed:@"FollowBtnClickBg"] completed:nil];
    
}

@end
