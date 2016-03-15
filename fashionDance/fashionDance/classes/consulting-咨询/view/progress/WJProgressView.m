//
//  WJProgressView.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/29.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "WJProgressView.h"

@implementation WJProgressView

#pragma mark - Internal methods

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.roundedCorners = 5;
//        self.backgroundColor = [UIColor yellowColor];
        self.progressLabel.textColor = [UIColor whiteColor];
//        self.progressLabel.backgroundColor = [UIColor redColor];
        self.progress = 5;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
