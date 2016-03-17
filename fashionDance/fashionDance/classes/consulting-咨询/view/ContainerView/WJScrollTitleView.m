//
//  WJScrollTitleView.m
//  WJContainerViewExample
//
//  Created by 汪俊 on 16/3/14.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJScrollTitleView.h"
#import "WJContainerView.h"
#import "WJConstraintModel.h"

#define WJScreenW [UIScreen mainScreen].bounds.size.width
#define WJContainerViewW (WJScreenW)
#define WJStatusAndBarHeight 64
#define WJTitleH 35

@interface WJScrollTitleView () <WJContainerViewDelegate, UIScrollViewDelegate>
// 标题
@property (weak, nonatomic) WJContainerView *containerView;

@property (weak, nonatomic) UIScrollView *contentView;

@property (weak, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic)NSMutableArray *constraintModelArray;

@end

@implementation WJScrollTitleView

- (NSMutableArray *)constraintModelArray {
    if (nil == _constraintModelArray) {
        _constraintModelArray = [NSMutableArray array];
    }
    return _constraintModelArray;
}


+ (instancetype)scrollTitleView {
    return [[self alloc]initWithFrame:CGRectZero];
}

+ (instancetype)scrollTitleViewWithFrame:(CGRect)frame {
    return [[self alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化标题
        [self setupContainerView];
        // 初始化scrollerview
        [self setupContentView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 初始化标题
    [self setupContainerView];
    // 初始化scrollerview
    [self setupContentView];
}

#pragma mark - 初始化方法

/**
 *  设置标题
 */
- (void)setupContainerView {
    
    // 1 添加存放按钮点scrollview
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(1.5 * WJContainerViewW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    // 2 添加容器view,存放标题按钮的
    WJContainerView *containerView = [WJContainerView containerView];
    self.containerView = containerView;
    
    [scrollView addSubview:containerView];
    
    [containerView setBackgroundColor:[UIColor whiteColor]];
    containerView.buttonBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    containerView.indicatorViewColor = [UIColor redColor];
    containerView.delegate = self;
}



/**
 *  设置setupContentView
 */
- (void)setupContentView {
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    [self insertSubview:contentView atIndex:0];
    
    contentView.backgroundColor = [UIColor clearColor];
    self.contentView = contentView;
    
    
    if (self.views.count > 0) {
        [self configChildViewWithIndex:0];
    }
    
}



#pragma mark - 配置约束方法

- (void)layoutSubviews {
    [super layoutSubviews];
    // 配置存放标题的scrollview的约束
    [self configScrollView];
    // 配置存放标题的ContainerView的约束
    [self configContainerView];
    // 配置存放内容的scrollview的约束
    [self configContentView];
}




- (void)configScrollView {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(WJStatusAndBarHeight));
        make.left.equalTo(@0);
        make.width.equalTo(@(WJContainerViewW));
        make.height.equalTo(@WJTitleH);
    }];
}


// 约束ContainerView的位置
- (void)configContainerView {
        __weak typeof(self)weakSelf = self;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(weakSelf.titlesScrollWidth == 0 ? @(1.5 * WJContainerViewW) :@(weakSelf.titlesScrollWidth));
        make.height.equalTo(@WJTitleH);
    }];
}


// 约束scrollerview的位置
- (void)configContentView{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.contentView.showsHorizontalScrollIndicator = NO;
}

/**
 *  配置tableview的约束
 *
 *  @param view  tableview
 *  @param index index
 */
- (void)configChildViewWithIndex:(NSInteger)index {
    
    WJConstraintModel *constraintModel = self.constraintModelArray[index];
    // 如果是第一次调用,配置约束
    if (constraintModel.isConfigConstraint == NO) {
        [self.contentView addSubview:constraintModel.view];
        __weak typeof(self)weakSelf = self;
        [constraintModel.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.contentView).offset(WJTitleH);
            make.left.equalTo(weakSelf.contentView).offset(index * weakSelf.contentView.width);
        }];
        constraintModel.configConstraint = YES;
    }
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    NSInteger count = self.containerView.titles.count;
    CGFloat scrolleViewW = self.scrollView.width;
    CGFloat btnW =  scrolleViewW / count;
    if ((index + 1) * btnW < scrolleViewW / 2 ) {
        self.scrollView.contentOffset = CGPointMake(0 , 0);
    } else if ((count - index) * btnW < scrolleViewW / 2) {
        CGFloat contentViewW = self.scrollView.contentSize.width;
        self.scrollView.contentOffset = CGPointMake(contentViewW - WJContainerViewW, 0);
    } else {
        if (count * btnW > WJContainerViewW) {
            self.scrollView.contentOffset = CGPointMake((index - 1) * btnW , 0);
        }
    }
    
    if (index > self.views.count - 1) return;
    // 取出子控制器
//    WJArrangeController *vc = self.childViewControllers[index];
    if (self.views.count > index){
        [self configChildViewWithIndex:index];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self.containerView configButtonWithIndex:index];
}

#pragma mark - myDelegate
// 标题的代理方法
- (void)containerView:(WJContainerView *)containerView NumberOfRow:(NSInteger)index {
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = index * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    if ([self.delegate respondsToSelector:@selector(scrollTitleView:NumberOfRow:)]) {
        [self.delegate scrollTitleView:self NumberOfRow:index];
    }
}

#pragma mark - privateMethod

- (void)setViews:(NSArray *)views {
    _views = [views copy];
    for (UIView *subView in views) {
        WJConstraintModel *constraintModel = [WJConstraintModel constraintModel];
        constraintModel.view = subView;
        [self.constraintModelArray addObject:constraintModel];
    }
    if (self.views.count > 0) {
        [self configChildViewWithIndex:0];
    }
}


- (void)setTitles:(NSArray *)titles {
    _titles = [titles copy];
    self.containerView.titles = titles;
    self.contentView.contentSize = CGSizeMake(WJContainerViewW * self.containerView.titles.count, 0);
}



- (void)setTitlesScrollWidth:(CGFloat)titlesScrollWidth {
    _titlesScrollWidth = titlesScrollWidth;
    self.scrollView.contentSize = CGSizeMake(titlesScrollWidth, 0);
    [self setNeedsLayout];
}

- (void)setContentBackgroundColor:(UIColor *)contentBackgroundColor {
    _contentBackgroundColor = contentBackgroundColor;
    
    self.contentView.backgroundColor = contentBackgroundColor;
}


- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.containerView.titleColor = titleColor;
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
    self.containerView.selectedTitleColor = selectedTitleColor;
}

- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor {
    _buttonBackgroundColor = buttonBackgroundColor;
    self.containerView.buttonBackgroundColor = buttonBackgroundColor;
}

- (void)setButtonBackgroundImage:(UIColor *)buttonBackgroundImage {
    _buttonBackgroundImage = buttonBackgroundImage;
    self.containerView.buttonBackgroundImage = buttonBackgroundImage;
}

- (void)setIndicatorViewColor:(UIColor *)indicatorViewColor{
    indicatorViewColor = indicatorViewColor;
    self.containerView.indicatorViewColor = indicatorViewColor;
}

- (void)setAnimationTime:(NSTimeInterval)animationTime{
    _animationTime = animationTime;
    self.containerView.animationTime = animationTime;
}

- (void)setIsOpenAnimation:(BOOL)isOpenAnimation {
    _isOpenAnimation = isOpenAnimation;
    self.containerView.isOpenAnimation = isOpenAnimation;
}

@end
