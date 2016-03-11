//
//  WJSpecialController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJSpecialController.h"
#import "WJArrangeController.h"
#import "WJContainerView.h"

@interface WJSpecialController () <WJContainerViewDelegate, UIScrollViewDelegate>
// 标题
@property (weak, nonatomic) WJContainerView *containerView;

@property (weak, nonatomic) UIScrollView *contentView;


@end

@implementation WJSpecialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化导航栏
    [self setupNav];
    // 初始化自控制器
    [self setupChildControllers];
    // 初始化标题
    [self setupContainerView];
    // 初始化scrollerview
    [self setupScrollerView];
    
    
}

#pragma mark - 初始化方法
/**
 *  初始化子控制器
 */
- (void)setupChildControllers {
//    [self addChildVC:[[WJFitnessController alloc]init]];
//    [self addChildVC:[[WJMaquillageControler alloc]init]];
    [self addChildVC:[[WJArrangeController alloc]init]];
//    [self addChildVC:[[WJTipsController alloc]init]];
}

/**
 *  设置标题
 */
- (void)setupContainerView {
    // 设置背景色
    self.view.backgroundColor = WJGlobalBg;
    
    WJContainerView *containerView = [WJContainerView containerView];
    self.containerView = containerView;
    containerView.titles = @[@"健身",@"化妆",@"编排",@"小贴士"];
    [self.view addSubview:containerView];
    [self configContainerView];
    [containerView setBackgroundColor:[UIColor whiteColor]];
    containerView.buttonBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    containerView.indicatorViewColor = [UIColor redColor];
    containerView.delegate = self;
}

/**
 * 设置导航栏
 */
- (void)setupNav {
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = WJGlobalBg;
}

/**
 *  设置scrollerview
 */
- (void)setupScrollerView{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(WJScreenW * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    [self configContentView];
    contentView.backgroundColor = WJGlobalBg;
    if (self.childViewControllers.count > 0) {
        [self configChildView:self.childViewControllers[0].view WithIndex:0];
    }
    
}



#pragma mark - 配置约束方法
// 约束ContainerView的位置
- (void)configContainerView {
    __weak typeof(self)weakSelf = self;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0));
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@35);
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
- (void)configChildView:(UIView *)view WithIndex:(NSInteger)index{
    WJArrangeController *titleController = self.childViewControllers[index];
    // 如果是第一次调用,配置约束
    if (titleController.isConfigConstraint == NO) {
        [self.contentView addSubview:view];
        __weak typeof(self)weakSelf = self;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(weakSelf.contentView);
            make.centerY.equalTo(weakSelf.contentView);
            make.centerX.equalTo(@(index * weakSelf.contentView.width));
        }];
        titleController.configConstraint = YES;
    }
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    WJArrangeController *vc = self.childViewControllers[index];
    [self configChildView:vc.view WithIndex:index];
    
    
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
}

#pragma mark - privateMethod
// 点击左边的按钮
- (void)tagClick{
    
}

// 添加自控制器
- (void)addChildVC:(UIViewController *)vc {
    [self addChildViewController:vc];
}


// 内存警告处理
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
