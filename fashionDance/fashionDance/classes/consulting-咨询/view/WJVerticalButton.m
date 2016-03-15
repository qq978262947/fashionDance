//
//  WJVerticalButton.m
//  01-百思不得姐
//
//  Created by wangjun on 15/7/26.
//  Copyright (c) 2015年 wangjun. All rights reserved.
//

#import "WJVerticalButton.h"
#define WJImageViewMargin 10
#define WJTitleH 30
#define WJBtnCount 4

@implementation WJVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.height = self.height - 2 * WJImageViewMargin - WJTitleH;
    self.imageView.width = self.imageView.height;
    self.imageView.x = (self.width - self.imageView.width) / 2;
    self.imageView.y = self.imageView.x;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 2;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
