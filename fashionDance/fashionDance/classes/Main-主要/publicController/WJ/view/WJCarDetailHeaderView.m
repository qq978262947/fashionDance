//
//  WJCarDetailHeaderView.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJCarDetailHeaderView.h"
#import "WJStarView.h"
#import "WJProgressesView.h"
#import "WJHeaderAppraiseModel.h"
#define WJImageW    18
#define WJMarginX   0
#define WJMaxScorel 5.0
#define WJStarY 5


@interface WJCarDetailHeaderView ()
@property (weak, nonatomic) WJStarView *starView;

@property (weak, nonatomic) UILabel *priceLabel;

@property (weak, nonatomic) UILabel *userYouLabel;

@property (weak, nonatomic) WJProgressesView *progressView;
@end

@implementation WJCarDetailHeaderView

+ (instancetype)carDetailHeaderView {
    return [[self alloc]initWithFrame:CGRectZero];
}

+ (instancetype)carDetailHeaderViewWithFrame:(CGRect)frame {
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
    titleView.text = @"裸车价格:";
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleView.frame) + 10, 50, 120, 30)];
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *youLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, (WJMaxScorel * (WJImageW + WJMarginX) + WJMarginX) , 30)];
    [self addSubview:youLabel];
    youLabel.text = @"行驶公里:";
    UILabel *userYouLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(youLabel.frame) + 10, 90, 120, 30)];
    [self addSubview:userYouLabel];
    self.userYouLabel = userYouLabel;
    
    WJProgressesView *progressView = [WJProgressesView progressesViewWithFrame:CGRectMake(10, 120, WJScreenW - 20, 120)];
    [self addSubview:progressView];
    self.progressView = progressView;
    
    
}

//- (void)setAppraiseModel:(WJHeaderAppraiseModel *)appraiseModel {
//    _appraiseModel = appraiseModel;
//    self.starView.scorel = appraiseModel.avgScore;
//    self.priceLabel.text = [NSString stringWithFormat:@"%.2f~%.2f万", appraiseModel.price_min / 10000.0, appraiseModel.price_max / 10000.0];
//    self.userYouLabel.text = [NSString stringWithFormat:@"%.2f~%.2fL", appraiseModel.fuelcost_min , appraiseModel.fuelcost_max];
//    self.progressView.appraiseModel = appraiseModel;
//}

- (void)setMoreAboutCarModel:(WJMoreAboutCarModel *)moreAboutCarModel {
    _moreAboutCarModel = moreAboutCarModel;
    WJHeaderAppraiseModel *appraiseModel = [[WJHeaderAppraiseModel alloc]init];
    appraiseModel.waiguan = moreAboutCarModel.waiguan;
    appraiseModel.neishi = moreAboutCarModel.neishi;
    appraiseModel.kongjian = moreAboutCarModel.kongjian;
    appraiseModel.dongli = moreAboutCarModel.dongli;
    appraiseModel.caokong = moreAboutCarModel.caokong;
    appraiseModel.youhao = moreAboutCarModel.youhao;
    appraiseModel.shushi = moreAboutCarModel.shushi;
    appraiseModel.xingjia = moreAboutCarModel.xingjia;
    self.progressView.appraiseModel = appraiseModel;
    
    self.starView.scorel = moreAboutCarModel.avgScore;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f万" , moreAboutCarModel.price];
    NSString *youhaoString = [NSString stringWithFormat:@"%ld公里" , (long)moreAboutCarModel.youhao];
    self.userYouLabel.text = [youhaoString stringByReplacingOccurrencesOfString:@".00" withString:@""];
}

@end
