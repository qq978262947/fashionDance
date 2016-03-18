//
//  WJPraiseHeaderView.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJPraiseHeaderView.h"
#import "WJStarView.h"
#import "WJProgressesView.h"
#define WJImageW    18
#define WJMarginX   0
#define WJMaxScorel 5.0
#define WJStarY 5


@interface WJPraiseHeaderView ()
@property (weak, nonatomic) WJStarView *starView;

@property (weak, nonatomic) UILabel *priceLabel;

@property (weak, nonatomic) UILabel *userYouLabel;

@property (weak, nonatomic) WJProgressesView *progressView;
@end

@implementation WJPraiseHeaderView

+ (instancetype)praiseHeaderView {
    return [[self alloc]initWithFrame:CGRectZero];
}

+ (instancetype)praiseHeaderViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    WJStarView *starView = [WJStarView starViewWithFrame:CGRectMake(10, 10, 180, 30)];
    [self addSubview:starView];
    self.starView = starView;
    
//    (WJMaxScorel * (WJImageW + WJMarginX) + WJMarginX)
    UILabel *titleView = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, (WJMaxScorel * (WJImageW + WJMarginX) + WJMarginX), 30)];
    [self addSubview:titleView];
    titleView.text = @"网友购车价:";
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleView.frame) + 10, 50, 120, 30)];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *youLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, (WJMaxScorel * (WJImageW + WJMarginX) + WJMarginX) + 20, 30)];
    [self addSubview:youLabel];
    youLabel.text = @"网友真实油耗:";
    UILabel *userYouLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(youLabel.frame) + 10, 90, 120, 30)];
    [self addSubview:userYouLabel];
    self.userYouLabel = userYouLabel;
    
    WJProgressesView *progressView = [WJProgressesView progressesViewWithFrame:CGRectMake(10, 120, WJScreenW - 20, 120)];
    [self addSubview:progressView];
    self.progressView = progressView;
    
    
}

- (void)setAppraiseModel:(WJHeaderAppraiseModel *)appraiseModel {
    _appraiseModel = appraiseModel;
    self.starView.scorel = appraiseModel.avgScore;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f~%.2f万", appraiseModel.price_min / 10000.0, appraiseModel.price_max / 10000.0];
    self.userYouLabel.text = [NSString stringWithFormat:@"%.2f~%.2fL", appraiseModel.fuelcost_min , appraiseModel.fuelcost_max];
    self.progressView.appraiseModel = appraiseModel;
}

@end
