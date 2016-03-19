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
#import "MJRefresh.h"
#import "MJExtension.h"
#import "WJConsultingResult.h"
#import "WJHotCarController.h"
#import "WJWebViewController.h"
#import "WJFindCarController.h"
#import "WJConsultingNoPicCell.h"

@interface CarConsultingController () <WJHeaderViewDelegate>
/**
 *  封装的要拼接url请求参数st
 */
@property (assign, nonatomic)long long st;
/**
 *  封装的要拼接url请求参数et
 */
@property (assign, nonatomic)long long et;
/**
 *  存放数据源的数组
 */
@property (strong, nonatomic)NSMutableArray *listArray;

@property (strong, nonatomic) WJWebViewController *userdCarWebVC;

@property (strong, nonatomic) WJWebViewController *CheckBreakRulesVC;
@end

@implementation CarConsultingController

- (WJWebViewController *)userdCarWebVC {
    if (nil == _userdCarWebVC) {
        _userdCarWebVC = [[WJWebViewController alloc]init];
        _userdCarWebVC.urlString = @"http://m.2sc.sohu.com/";
    }
    return _userdCarWebVC;
}

- (WJWebViewController *)CheckBreakRulesVC {
    if (nil == _CheckBreakRulesVC) {
        _CheckBreakRulesVC = [[WJWebViewController alloc]init];
        _CheckBreakRulesVC.urlString = @"http://mobile.auto.sohu.com/wzcx/weixin.at";
    }
    return _CheckBreakRulesVC;
}


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
    WJHeaderView *header = [[WJHeaderView alloc] init];
    header.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0  blue:235/255.0  alpha:1.0];
    header.size = CGSizeMake(WJScreenW, WJScreenW / 4 + 35);
    // 设置header
    header.delegate = self;
    self.tableView.tableHeaderView = header;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)headerView:(WJHeaderView *)headerView DidClick:(WJHeaderViewButtonType)buttonType {
    switch (buttonType) {
        case WJHeaderViewButtonTypeFindHot:
            [self.navigationController pushViewController:[[WJHotCarController alloc]init] animated:YES];
            break;
        case WJHeaderViewButtonTypeFindNewCar:
            [self.navigationController pushViewController:[[WJFindCarController alloc]init] animated:YES];
            break;
        case WJHeaderViewButtonTypeusedCar:
            [self.navigationController pushViewController:self.userdCarWebVC animated:YES];
            break;
        case WJHeaderViewButtonTypeCheckBreakRules:
            [self.navigationController pushViewController:self.CheckBreakRulesVC animated:YES];
            break;
        default:
            break;
    }
}


// 加载最新数据
- (void)loadNewData {

    [[WJHttpTool httpTool]get:@"http://autoapp.auto.sohu.com/api/cmsnews/list_1457578183979_1457671132872.json" params:nil success:^(NSDictionary *responseObj) {
        WJConsultingResult *result = [WJConsultingResult mj_objectWithKeyValues:responseObj];
        
        self.st = result.result.st;
        self.et = result.result.et;
        self.listArray = [NSMutableArray arrayWithArray:result.result.list];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

// 加载更多数据
- (void)loadMoreData {
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/cmsnews/list_%lli_%lli.json", self.st ,self.et];
    [[WJHttpTool httpTool]get:urlString params:nil success:^(NSDictionary *responseObj) {
        WJConsultingResult *result = [WJConsultingResult mj_objectWithKeyValues:responseObj];
        if (result != nil) {
            self.st = result.result.st;
            self.et = result.result.et;
            [self.listArray addObjectsFromArray:result.result.list];
            [self.tableView reloadData];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = self.listArray == 0;
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJList *list = self.listArray[indexPath.row];
    if (list.picUrl == nil || [list.picUrl isEqualToString:@""]) {
        WJConsultingNoPicCell *cell = [WJConsultingNoPicCell consultingCellWithTableView:tableView];
        cell.list = list;
        return cell;
    }else {
        WJConsultingCell *cell  = [WJConsultingCell consultingCellWithTableView:tableView];
        cell.list = list;
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJList *list = self.listArray[indexPath.row];
    if (list.picUrl == nil || [list.picUrl isEqualToString:@""]) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(WJScreenW - 2 * 10, MAXFLOAT);
        // 计算文字的高度
        CGFloat height = [list.title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
        return height + 20 + 20 + 5;
    }
    return 90;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WJList *list = self.listArray[indexPath.row];
    WJWebViewController *webViewController = [[WJWebViewController alloc]init];
    webViewController.urlString = list.url;
    [self.navigationController pushViewController:webViewController animated:YES];
}



@end
