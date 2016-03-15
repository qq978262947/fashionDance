//
//  WJDanceController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CarForumController.h"
#import "YUSelectionViewController.h"
#import "YUHotTopicViewController.h"
#import "YUCategoryViewController.h"

@interface CarForumController () <UIScrollViewDelegate>

/** 顶部的segment */
@property (nonatomic, weak) UISegmentedControl *segment;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation CarForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = WJGlobalBg;
    
    [self setupNav];
    
    [self setupChildVces];
    
    [self setupContentView];
  
}

- (void)setupNav
{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"热帖",@"精选",@"分类"]];
    
    self.navigationItem.titleView = segment;
    self.segment = segment;
    //去掉颜色,现在整个segment都看不见
    segment.tintColor = [UIColor clearColor];
    NSDictionary* selectedTextAttributes = @{
                                             
                        NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName: [UIColor whiteColor],
                        };
    //设置文字属性
    [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    
    NSDictionary* unselectedTextAttributes = @{
                                               NSFontAttributeName:
                                                   [UIFont boldSystemFontOfSize:15],
                                               NSForegroundColorAttributeName: [UIColor lightTextColor],
                                            
                                               };
    [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];

    
    [segment addTarget:self action:@selector(itemDidClick:) forControlEvents:UIControlEventValueChanged];  
    
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    YUHotTopicViewController *hotTopicVc = [[YUHotTopicViewController alloc]init];
    [self addChildViewController:hotTopicVc];
    
    YUSelectionViewController *selectionVc = [[YUSelectionViewController alloc]init];
    [self addChildViewController:selectionVc];
    
    YUCategoryViewController *categoryVc = [[YUCategoryViewController alloc]init];
    [self addChildViewController:categoryVc];
  
}

/**
 * 底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    self.segment.selectedSegmentIndex = 0;
}

- (void)itemDidClick:(UISegmentedControl *)segmentControl
{
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = segmentControl.selectedSegmentIndex * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 64; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height - 64 - 49; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    self.segment.selectedSegmentIndex = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
