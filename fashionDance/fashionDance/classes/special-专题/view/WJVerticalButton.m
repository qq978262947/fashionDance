//
//  WJVerticalButton.m
//  01-百思不得姐
//
//  Created by wangjun on 15/7/26.
//  Copyright (c) 2015年 wangjun. All rights reserved.
//

#import "WJVerticalButton.h"

@implementation WJVerticalButton

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
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
    self.imageView.x = 10;
    self.imageView.y = 10;
    self.imageView.width = self.width - 2 * self.imageView.x;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
