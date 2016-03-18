//
//  WJPublicViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//


#import "LLCarTypeDetailController.h"
#import "WJPublicViewController.h"
#import "WJScrollTitleView.h"
#import "YuSummarizeController.h"
#import "WJPraiseViewController.h"
#import "YuArticleViewController.h"
#import "YuForumViewController.h"
#import "CCPicViewController.h"
#import "llParameterController.h"
#import "Masonry.h"
#define WJScreenW [UIScreen mainScreen].bounds.size.width


@interface WJPublicViewController ()

@property (weak, nonatomic) WJScrollTitleView *tv;

@end

@implementation WJPublicViewController
+(instancetype)wjPublicViewControllerWithModID:(NSString *)modID
{
    WJPublicViewController * public=[WJPublicViewController new];
    public.modelId=modID;
    return public;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

-(void)setupUI
{

    self.view.backgroundColor = [UIColor whiteColor];
    WJScrollTitleView *tv = [WJScrollTitleView scrollTitleView];
    self.tv = tv;
    tv.backgroundColor = [UIColor whiteColor];
    
    
    // 可抽公共代码啊
    YuSummarizeController *vc1 = [[YuSummarizeController alloc]init];
    [self addChildViewController:vc1];
    CCPicViewController *vc2 = [CCPicViewController ccpicviewcontrollerWithString:self.modelId];
    [self addChildViewController:vc2];
    WJPraiseViewController *vc3 = [[WJPraiseViewController alloc]init];
    [self addChildViewController:vc3];
    YuArticleViewController *vc4 = [[YuArticleViewController alloc]init];
    [self addChildViewController:vc4];
    YuForumViewController *vc5 = [[YuForumViewController alloc]init];
    [self addChildViewController:vc5];
    llParameterController *vc6 = [[llParameterController alloc]init];
    [self addChildViewController:vc6];
    
    vc1.modelId = self.modelId;

    vc3.modelId = self.modelId;
    vc4.modelId = self.modelId;
    vc5.modelId = self.modelId;
    vc6.modelId = self.modelId;
    
//    vc1.view.backgroundColor = [UIColor whiteColor];
//    vc2.view.backgroundColor = [UIColor redColor];
//    vc3.view.backgroundColor = [UIColor blackColor];
//    vc4.view.backgroundColor = [UIColor yellowColor];
//    vc5.view.backgroundColor = [UIColor greenColor];
    
    tv.views = @[vc1.view,vc2.view,vc3.view,vc4.view,vc5.view,vc6.view];
    tv.titles = @[@"综述",@"图片",@"口碑",@"文章",@"论坛",@"参数"];
    
    [self.view addSubview:tv];
    
    [self configView];
    
    //设置标题的最大偏移
    tv.titlesScrollWidth = WJScreenW;
    [tv setContentBackgroundColor:[UIColor yellowColor]];
}

// 约束WJScrollTitleView控制器视图的位置
- (void)configView {
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(@0);
        make.bottom.right.equalTo(@0);
    }];
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
