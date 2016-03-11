//
//  CarTableViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CarConsultingController.h"
#import "WJHttpTool.h"
#import "WJConsultingCell.h"
#import "WJHeaderView.h"
#import <MJRefresh.h>


@interface CarConsultingController ()

@property (strong, nonatomic)NSMutableArray *listArray;

@end

@implementation CarConsultingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    // 读区数据
    [self setupRefresh];
    
}

// 集成刷新控件,并加载最新数据
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


// 初始化tableview
- (void)setupTableView {
    // 创建header
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor greenColor];
    header.size = CGSizeMake(WJScreenW, 100);
    // 设置header
    self.tableView.tableHeaderView = header;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

// 加载最新数据
- (void)loadNewData {

    
    [[WJHttpTool httpTool]get:@"" params:nil success:^(id dict) {
        //        self.listArray = [NSMutableArray arrayWithArray:result.result.list];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

// 加载更多数据
- (void)loadMoreData {
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = self.listArray == 0;
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJConsultingCell *cell = [WJConsultingCell consultingCellWithTableView:tableView];
    WJList *list = self.listArray[indexPath.row];
    cell.list = list;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

@end
