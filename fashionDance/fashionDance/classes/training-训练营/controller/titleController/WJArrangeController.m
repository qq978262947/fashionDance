//
//  WJArrangeController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJArrangeController.h"
#import "WJHttpTool.h"
#import "WJExetensionTool.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import "WJSpecialVideoCell.h"

@interface WJArrangeController () <UITableViewDataSource, UITableViewDelegate>
// 数据源数组
@property (strong, nonatomic)NSMutableArray *listArray;

//
@property (assign, nonatomic)NSInteger pageIndex;
@end

@implementation WJArrangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 集成tableview
    [self setupTableView];
    // 集成刷新控件
    [self setupRefresh];
}
#pragma mark - <privateDelegate>
// 初始化tableview
- (void)setupTableView {
    // 设置内边距
    CGFloat bottom = WJTopicCellBottomBarH;
    CGFloat top = WJTitilesViewY + WJTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
}

// 集成刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.tableView.mj_header beginRefreshing];
}

// 读区最新数据
- (void)loadData {
//    WJSpecialVideoParam *param = [[WJSpecialVideoParam alloc]init];
//    self.pageIndex = 1;
//    param.aid = 1;
//    [WJExetensionTool setupSpecialVideoMode];
//    [[WJVideoTool sharedTool]videoWithParam:param success:^(WJSpecialListResult *result) {
//        [self.tableView.mj_header endRefreshing];
//        self.listArray = [NSMutableArray arrayWithArray:result.list];
//        [self.tableView reloadData];
//        self.pageIndex++;
//    } failure:^(NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//    }];
//    [[WJHttpTool httpTool]GET:@"" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
}

// 读区更多数据
- (void)loadMoreData {
//    WJSpecialVideoParam *param = [[WJSpecialVideoParam alloc]init];
//    param.aid = self.pageIndex;
//    [WJExetensionTool setupSpecialVideoMode];
//    [[WJVideoTool sharedTool]videoWithParam:param success:^(WJSpecialListResult *result) {
//        [self.tableView.mj_header endRefreshing];
//        [self.listArray addObjectsFromArray:result.list];
//        [self.tableView reloadData];
//        self.pageIndex++;
//    } failure:^(NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 让当前控制器对应的状态栏是白色,兼容9.0以下系统
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.listArray.count > 2) {
        return self.listArray.count - 2;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJSpecialVideoCell *cell = [WJSpecialVideoCell specialCellWithTableView:tableView];
    cell.list = self.listArray[indexPath.row + 2];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
