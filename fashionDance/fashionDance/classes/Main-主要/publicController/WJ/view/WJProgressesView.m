//
//  WJProgressesView.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJProgressesView.h"
#import "WJCombinationProgressView.h"
#define WJMaxProgress 5.0

@interface WJProgressesView ()

@property (weak, nonatomic) WJCombinationProgressView *WaiGuangProgressView;
@property (weak, nonatomic) WJCombinationProgressView *neiShiProgressView;
@property (weak, nonatomic) WJCombinationProgressView *kongJianProgressView;
@property (weak, nonatomic) WJCombinationProgressView *dongLiProgressView;
@property (weak, nonatomic) WJCombinationProgressView *caoKongProgressView;
@property (weak, nonatomic) WJCombinationProgressView *youHaoProgressView;
@property (weak, nonatomic) WJCombinationProgressView *shuShiProgressView;
@property (weak, nonatomic) WJCombinationProgressView *xingJiaProgressView;

@end

@implementation WJProgressesView

+ (instancetype)progressesView {
    return [[self alloc]initWithFrame:CGRectZero];
}

+ (instancetype)progressesViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupProgresses];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupProgresses];
    }
    return self;
}

- (void)setupProgresses {
    self.WaiGuangProgressView = [self configCombinationProgressView:[WJCombinationProgressView combinationProgressView] WithTitle:@"外观"];
    self.neiShiProgressView = [self configCombinationProgressView:[WJCombinationProgressView combinationProgressView] WithTitle:@"内饰"];
    self.kongJianProgressView = [self configCombinationProgressView:[WJCombinationProgressView combinationProgressView] WithTitle:@"空间"];
    self.dongLiProgressView = [self configCombinationProgressView:[WJCombinationProgressView combinationProgressView] WithTitle:@"动力"];
    self.caoKongProgressView = [self configCombinationProgressView:[WJCombinationProgressView combinationProgressView] WithTitle:@"操控"];
    self.youHaoProgressView = [self configCombinationProgressView:[WJCombinationProgressView combinationProgressView] WithTitle:@"油耗"];
    self.shuShiProgressView = [self configCombinationProgressView:[WJCombinationProgressView combinationProgressView] WithTitle:@"舒适"];
    self.xingJiaProgressView = [self configCombinationProgressView:[WJCombinationProgressView combinationProgressView] WithTitle:@"性价"];
}

- (WJCombinationProgressView *)configCombinationProgressView:(WJCombinationProgressView *)combinationProgressView WithTitle:(NSString *)title {
    combinationProgressView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self addSubview:combinationProgressView];
    combinationProgressView.progressLabel.text = title;
    return combinationProgressView;
}


- (void)setAppraiseModel:(WJHeaderAppraiseModel *)appraiseModel {
    _appraiseModel = appraiseModel;
    self.WaiGuangProgressView.progressView.progress = appraiseModel.waiguan / WJMaxProgress;
    self.neiShiProgressView.progressView.progress = appraiseModel.neishi / WJMaxProgress;
    self.dongLiProgressView.progressView.progress = appraiseModel.dongli / WJMaxProgress;
    self.kongJianProgressView.progressView.progress = appraiseModel.kongjian / WJMaxProgress;
    self.youHaoProgressView.progressView.progress = appraiseModel.youhao / WJMaxProgress;
    self.caoKongProgressView.progressView.progress = appraiseModel.caokong / WJMaxProgress;
    self.shuShiProgressView.progressView.progress = appraiseModel.shushi / WJMaxProgress;
    self.xingJiaProgressView.progressView.progress = appraiseModel.xingjia / WJMaxProgress;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    long count = self.subviews.count;
    CGFloat combinationProgressH = 100;
    CGFloat combinationProgressW = 25;
    CGFloat margin = (self.width - count * combinationProgressW) / (count + 1);
    for (int i = 0; i < count; i++) {
        WJCombinationProgressView *combinationProgressView = self.subviews[i];
        combinationProgressView.frame = CGRectMake(margin + i * (margin + combinationProgressW), 0, combinationProgressW, combinationProgressH);
    }
}

@end
