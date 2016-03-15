//
//  WJArrangeController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJArrangeController.h"
#import "WJHttpTool.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import "WJSUVResult.h"
#import <MJExtension.h>
#import "WJSUVResult.h"
#import "WJFindHotCell.h"
//http://autoapp.auto.sohu.com/api/model/listHot/body_2_type_6_page_1
//http://autoapp.auto.sohu.com/api/model/listHot/body_0_type_0_page_1
//http://autoapp.auto.sohu.com/api/model/listHot/body_0_type_1_page_1
//http://autoapp.auto.sohu.com/api/model/listHot/body_0_type_2_page_1
//http://autoapp.auto.sohu.com/api/model/listHot/body_0_type_3_page_1
//http://autoapp.auto.sohu.com/api/model/listHot/body_0_type_4_page_1
//http://autoapp.auto.sohu.com/api/model/listHot/body_0_type_5_page_1
//http://autoapp.auto.sohu.com/api/model/listHot/body_1_type_6_page_1


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
//    CGFloat bottom = WJTopicCellBottomBarH;
    CGFloat top = WJTitilesViewY + WJTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
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
    self.pageIndex = 1;
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/model/listHot/body_%li_type_%li_page_1", self.body , self.type];
    [[WJHttpTool httpTool]get:urlString params:nil success:^(NSDictionary *responseObj) {
        WJSUVResult *result = [WJSUVResult mj_objectWithKeyValues:responseObj];
        if (result != nil) {
            self.listArray = [NSMutableArray arrayWithArray:result.items];
            [self.tableView reloadData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

// 读区更多数据
- (void)loadMoreData {
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/model/listHot/body_%li_type_%li_page_%li", self.body , self.type, ++self.pageIndex];
    [[WJHttpTool httpTool]get:urlString params:nil success:^(NSDictionary *responseObj) {
        WJSUVResult *result = [WJSUVResult mj_objectWithKeyValues:responseObj];
        if (result.items != 0) {
            [self.listArray addObjectsFromArray:result.items];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = self.listArray.count == 0;
    return self.listArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJFindHotCell *cell = [WJFindHotCell findHotCellCellWithTableView:tableView];
    WJCarModel *carModel = self.listArray[indexPath.row];
    cell.carModel = carModel;
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
