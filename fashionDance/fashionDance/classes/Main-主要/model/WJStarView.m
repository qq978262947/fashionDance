//
//  WJStarView.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJStarView.h"
#define WJImageW    18
#define WJMarginX   0
#define WJMaxScorel 5.0
#define WJStarY 5

@interface WJStarView ()
/**
 *  空心的❤️
 */
@property (nonatomic, strong) UIView *emptyStarView;
/**
 *  实心的❤️
 */
@property (nonatomic, strong) UIView *redStarView;

@property(nonatomic,weak)UILabel *scoreLabel;
@end

@implementation WJStarView

+ (instancetype)starView {
    return [[self alloc]initWithFrame:CGRectZero];
}

+ (instancetype)starViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupScoreLabel];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupScoreLabel];
}

/**
 *  添加ScoreLabel
 */
- (void)setupScoreLabel {
    
    self.emptyStarView = [self buidlStarViewWithImageName:@"emptyStar"];
    self.redStarView = [self buidlStarViewWithImageName:@"Star"];
    //分数 scoreLabel
    UILabel *scoreLabel = [[UILabel alloc]init];
    [self addSubview:scoreLabel];
    [scoreLabel setTextColor:[UIColor redColor]];
    self.scoreLabel = scoreLabel;
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName {
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    //把子视图超出的部份裁减掉
    // view.clipsToBounds = YES;
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i * (WJImageW + WJMarginX) + WJMarginX, 0, WJImageW, WJImageW);
        [view addSubview:imageView];
    }
    return view;
}

- (void)setScorel:(CGFloat)scorel {
    _scorel = scorel;
    NSString *scorelString = [NSString stringWithFormat:@"%.02f分", scorel];
    scorelString = [scorelString stringByReplacingOccurrencesOfString:@".00" withString:@""];
    self.scoreLabel.text = scorelString;
    self.redStarView.frame = CGRectMake(0, WJStarY, (WJMaxScorel * (WJImageW + WJMarginX) + WJMarginX) * (scorel / WJMaxScorel), self.height);
    self.redStarView.clipsToBounds = YES;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.emptyStarView.frame = CGRectMake(0, WJStarY, self.width - 70, self.height);
    self.scoreLabel.frame = CGRectMake(self.width - 70, 0, 70, self.height);
}

@end
