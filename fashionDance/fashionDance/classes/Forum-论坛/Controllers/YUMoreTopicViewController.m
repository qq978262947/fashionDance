//
//  YUMoreTopicViewController.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUMoreTopicViewController.h"
#import "YUMoreTopicCell.h"
#import "YUSelectionTopic.h"
#import "YUHotTopicModel.h"
#import "WJHttpTool.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "YUTopicWebViewController.h"

static NSString *YUMoreTopicCellId = @"YUMoreTopicCell";

@interface YUMoreTopicViewController ()

@property (nonatomic, strong) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger start;

@end

@implementation YUMoreTopicViewController

- (NSMutableArray *)topics
{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.start = 0;
    
    [self configTableView];
    
    // 添加刷新控件
    [self  setupRefresh];
    
    [self loadMoreTopics];
}

- (void)setupRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

- (void)configTableView
{
    
    self.title = self.selectionTopic.cnName;

    self.tableView.rowHeight = 100;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YUMoreTopicCell class]) bundle:nil] forCellReuseIdentifier:YUMoreTopicCellId];
}

- (void)loadMoreTopics
{
    if (self.start == 0) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    }
    NSDictionary *params = @{
                             @"num":@20,
                             @"start":@(self.start),
                             @"type":self.selectionTopic.type,
                             };
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:@"http://saa.auto.sohu.com/v5/mobileapp/club/choices.do" params:params success:^(NSDictionary *result) {
        
        NSArray *tmpArray = [YUHotTopicModel mj_objectArrayWithKeyValuesArray:result[@"RESULT"][@"list"]];

        [weakSelf.topics addObjectsFromArray:tmpArray];
        
        [weakSelf.tableView reloadData];
        
        weakSelf.start += 20;
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUMoreTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:YUMoreTopicCellId forIndexPath:indexPath];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUTopicWebViewController *topicWebVc = [[YUTopicWebViewController alloc]init];
    topicWebVc.topicModel = self.topics[indexPath.row];
    [self.navigationController pushViewController:topicWebVc animated:YES];
}

@end
