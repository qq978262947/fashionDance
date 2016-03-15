//
//  WJHeaderView.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJHeaderView.h"
#import "WJVerticalButton.h"
#import "UIImage+cirlcle.h"

@interface WJHeaderView ()
@property (weak, nonatomic) UIView *bgView ;
@end


@implementation WJHeaderView

+ (instancetype)headerView {
    return [[self alloc]initWithFrame:CGRectZero];
}

+ (instancetype)headerViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}
/**
 *  从xib唤醒后调用的方法
 */
- (void)awakeFromNib {
    [self setupButtons];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupButtons];
    }
    return self;
}


/**
 *  初始化headerview内的button
 */
- (void)setupButtons {
    
    // 添加容器的view
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    // 添加所有的子控件
    [self addButtonWithIcon:@"publish-review" title:@"看热门" tag:WJHeaderViewButtonTypeFindHot];
    [self addButtonWithIcon:@"publish-picture" title:@"看新车" tag:WJHeaderViewButtonTypeFindNewCar];
    [self addButtonWithIcon:@"publish-video" title:@"二手车" tag:WJHeaderViewButtonTypeusedCar];
    [self addButtonWithIcon:@"publish-text" title:@"查违规" tag:WJHeaderViewButtonTypeCheckBreakRules];
    
}

/**
 *  添加一个按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (void)addButtonWithIcon:(NSString *)icon title:(NSString *)titleText tag:(WJHeaderViewButtonType)tag
{
    WJVerticalButton *button = [[WJVerticalButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[[UIImage imageNamed:icon]circleImage] forState:UIControlStateNormal];
    [button setTitle:titleText forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.bgView addSubview:button];
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(headerView:DidClick:)]) {
        [self.delegate headerView:self DidClick:(int)button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = CGRectMake(0, 0, self.width, self.height - 10);
    
    NSInteger count = self.bgView.subviews.count;
    CGFloat buttonW = self.bgView.width / count;
    CGFloat buttonH = self.bgView.height;
    for (int i = 0; i<count; i++) {
        UIButton *button = self.bgView.subviews[i];
        button.y = 0;
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}


@end
