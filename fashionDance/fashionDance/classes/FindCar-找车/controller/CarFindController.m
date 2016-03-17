//
//  WJRecommendController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CarFindController.h"
#import "TSBrandCarController.h"
#import <SDWebImageManager.h>
#import "TSTJZCController.h"

@interface CarFindController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UISegmentedControl * seg;

@end

@implementation CarFindController
-(UIScrollView *)scrollView
{
    if (_scrollView==nil)
    {
        _scrollView=[[UIScrollView alloc]init];
    }
    return _scrollView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self configSubViews];
    
    [self configNav];

    self.view.backgroundColor = WJGlobalBg;
}
-(void)configSubViews
{
    
    [self.view addSubview:self.scrollView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.scrollView.delegate=self;
    self.scrollView.pagingEnabled=YES;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(NAVH+20);
        make.bottom.equalTo(-TabbarH);
    }];
    
    //scrollView子视图
    TSBrandCarController * brand=[TSBrandCarController new];
    [self addChildViewController:brand];
    [self.scrollView addSubview:brand.view];
    [brand.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.height.equalTo(self.scrollView.mas_height);
        make.width.equalTo(SCRW);
    }];
    
    TSTJZCController * tjzc=[TSTJZCController new];
    [self addChildViewController:tjzc];
    [self.scrollView addSubview:tjzc.view];
    [tjzc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(brand.view.mas_right);
        make.top.equalTo(0);
        make.height.equalTo(self.scrollView.mas_height);
        make.width.equalTo(SCRW);
        //把scrollview撑开
        make.right.equalTo(self.scrollView.mas_right);
    }];
}
-(void)configNav
{
    UISegmentedControl * ctl=[[UISegmentedControl alloc]initWithItems:@[@"品牌选车",@"条件选车"]];
    ctl.frame = CGRectMake(0, 0, 120, 35);
    self.navigationItem.titleView =ctl;
    self.seg=ctl;
    ctl.selectedSegmentIndex = 0;//默认选中的按钮索引
    [ctl addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
}
-(void)segAction:(UISegmentedControl *)seg
{
    switch (seg.selectedSegmentIndex)
    {
        case 0:
        {
            self.scrollView.contentOffset=CGPointMake(0, 0);
        }
            break;
        case 1:
        {
            self.scrollView.contentOffset=CGPointMake(SCRW, 0);
        }
            break;
        default:
            break;
    }
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat setx = scrollView.contentOffset.x;
    if(setx >= SCRW/2)
    {
        self.seg.selectedSegmentIndex=1;
    }
    else
    {
        self.seg.selectedSegmentIndex=0;
    }
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
