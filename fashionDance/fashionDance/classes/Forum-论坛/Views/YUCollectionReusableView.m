//
//  YUCollectionReusableView.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUCollectionReusableView.h"
#import "YUSelectionTopic.h"

@interface YUCollectionReusableView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIButton *btn;

@end

@implementation YUCollectionReusableView

- (void)awakeFromNib
{
    [self setupLabel];
    
    [self setupBtn];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupLabel];
        
        [self setupBtn];
    }
    return self;
}

- (void)setupLabel
{
    UILabel *titleLabel = [[UILabel alloc]init];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor grayColor];
}

- (void)setupBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    btn.titleLabel.font = self.titleLabel.font;
    btn.userInteractionEnabled = NO;
    self.btn = btn;
}

- (void)setSelectionTopic:(YUSelectionTopic *)selectionTopic
{
    _selectionTopic = selectionTopic;
    
    self.titleLabel.text = selectionTopic.cnName;
    
    self.btn.userInteractionEnabled = YES;
}

- (void)btnClick
{
    if ([self.delegate respondsToSelector:@selector(collectionReusableViewDidBtnClick:selectionTopic:)]) {
        [self.delegate collectionReusableViewDidBtnClick:self selectionTopic:self.selectionTopic];
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10, 0, 80, 30);
    self.btn.frame = CGRectMake(WJScreenW - 40, 0, 30, 30);
}

@end
