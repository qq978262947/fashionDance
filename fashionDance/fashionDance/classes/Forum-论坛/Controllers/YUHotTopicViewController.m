//
//  YUHotTopicViewController.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUHotTopicViewController.h"
#import "YUImageCell.h"
#import "WJHttpTool.h"
#import "YUHotTopicModel.h"
#import "MJExtension.h"
#import "YUHotTopicCell.h"
#import "MJRefresh.h"
#import "YUBannerListModel.h"
#import "YUTopicHeaderView.h"
#import "SVProgressHUD.h"
#import "YUTopicWebViewController.h"

static NSString *YUHotTopicCellId = @"YUHotTopicCell";

@interface YUHotTopicViewController () <YUTopicHeaderViewDelegate>

/** 顶部headerView */
@property (nonatomic, weak) YUTopicHeaderView *topicHeaderView;

@property (nonatomic, strong) NSArray *topicModels;

@property (nonatomic, strong) NSArray *bannerListModels;

@end

@implementation YUHotTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
    
    [self loadNewbannerListData];
}

- (void)setupRefresh
{
    [self.tableView.mj_header beginRefreshing];
}

// 初始化tableview
- (void)setupTableView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCellData)];

    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YUHotTopicCell class]) bundle:nil] forCellReuseIdentifier:YUHotTopicCellId];
    
    YUTopicHeaderView *topicHeaderView = [[YUTopicHeaderView alloc]initWithFrame:CGRectMake(0, 0, WJScreenW, YUImageCellH)];
    topicHeaderView.delegate = self;
    self.topicHeaderView = topicHeaderView;
    self.tableView.tableHeaderView = topicHeaderView;
    
  //  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, WJTopicCellBottomBarH, 0);
    
}

- (void)loadNewbannerListData
{
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:@"http://saa.auto.sohu.com/v5/mobileapp/club/queryBannerImg.do" params:nil success:^(id result) {
        
        weakSelf.bannerListModels = [YUBannerListModel mj_objectArrayWithKeyValuesArray:result[@"RESULT"][@"bannerList"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
          weakSelf.topicHeaderView.bannerListModels = weakSelf.bannerListModels;
        });
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadNewCellData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:@"http://saa.auto.sohu.com/v5/mobileapp/club/queryRecommendTopics.do" params:nil success:^(id result) {
        
     //   NSLog(@"%@",result[@"RESULT"]);
        
        weakSelf.topicModels = [YUHotTopicModel mj_objectArrayWithKeyValuesArray:result[@"RESULT"]];
 
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.mj_header endRefreshing];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [weakSelf.tableView.mj_header endRefreshing];
    
    }];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUHotTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:YUHotTopicCellId forIndexPath:indexPath];
    
    cell.topicModel = self.topicModels[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUTopicWebViewController *topicWebVc = [[YUTopicWebViewController alloc]init];
    topicWebVc.topicModel = self.topicModels[indexPath.row];
    [self.navigationController pushViewController:topicWebVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUHotTopicModel *topic = self.topicModels[indexPath.row];
    if (topic.pics.count > 0) {
        
        return  140;
    } else {
        return 60;
    }
    
}


#pragma mark - YUTopicHeaderViewDelegate

- (void)collectionViewDidSelectItem:(YUTopicHeaderView *)topicHeaderView topicModel:(YUHotTopicModel *)topicModel
{
    YUTopicWebViewController *topicWebVc = [[YUTopicWebViewController alloc]init];
    topicWebVc.topicModel = topicModel;
    [self.navigationController pushViewController:topicWebVc animated:YES];
}



@end
