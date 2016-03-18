//
//  YuForumViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YuForumViewController.h"
#import "YUHotTopicCell.h"
#import "YUHotTopicModel.h"
#import "YUForumModel.h"
#import "YUForumHeaderView.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "YUTopicWebViewController.h"

static NSString *Id = @"YUHotTopicCell";

@interface YuForumViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) YUForumHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *topics;

@property (nonatomic, assign) NSInteger bid;

@end

@implementation YuForumViewController

- (NSMutableArray *)topics
{
    if (_topics == nil) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadHeaderData];
    
    [self loadCellData];
}

- (void)loadCarBid
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString *urlString = [NSString stringWithFormat:@"http://saa.auto.sohu.com/v5/mobileapp/club/modelClubInfo.do?modelId=%@",self.modelId];
    
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:urlString params:nil success:^(id result) {

        weakSelf.bid = (int)result[@"RESULT"];
        
        [SVProgressHUD dismiss];
        
        [self loadHeaderData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}
- (void)loadHeaderData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString *urlString = [NSString stringWithFormat:@"http://saa.auto.sohu.com/v5/mobileapp/club/clubInfo.do?bid=10454"];
    
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:urlString params:nil success:^(id result) {
        
        //   NSLog(@"%@",result);
        
        YUForumModel *forumModel = [YUForumModel mj_objectWithKeyValues:result[@"RESULT"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.headerView.model = forumModel;
        });
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}

- (void)loadCellData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString *urlString = [NSString stringWithFormat:@"http://saa.auto.sohu.com/v5/mobileapp/club/topicList.do?bid=10454&page=1&pageSize=20"];
    
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:urlString params:nil success:^(id result) {
        
        NSArray *tmpArray = [YUHotTopicModel mj_objectArrayWithKeyValuesArray:result[@"RESULT"][@"threads"]];
        [weakSelf.topics addObjectsFromArray:tmpArray];
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}

- (void)setupTableView
{
    // 设置tableview
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WJScreenW, WJScreenH) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    // 设置inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //  tableView.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YUHotTopicCell class]) bundle:nil] forCellReuseIdentifier:Id];
    
    // 添加headerView
    YUForumHeaderView *headerView = [YUForumHeaderView headerView];
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = headerView;
    tableView.rowHeight = 70;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  //  self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUHotTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:Id forIndexPath:indexPath];
    
    cell.topicModel = self.topics[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUHotTopicModel *topic = self.topics[indexPath.row];
    if (topic.pics.count > 0) {
        return  140;
    } else {
        return 60;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUTopicWebViewController *topicWebVc = [[YUTopicWebViewController alloc]init];
    topicWebVc.topicModel = self.topics[indexPath.row];
    [self.navigationController pushViewController:topicWebVc animated:YES];
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
