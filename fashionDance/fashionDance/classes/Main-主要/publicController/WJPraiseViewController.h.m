//
//  CCParameterViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJPraiseViewController.h"
#import "WJHeaderAppraiseModel.h"
#import "WJContentAppraiseModel.h"
#import "WJPraiseTableViewCell.h"

@interface WJPraiseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@property (copy, nonatomic)NSArray *listArray;

@end

@implementation WJPraiseViewController
// http://autoapp.auto.sohu.com/api/eval/stat/model_4095
// http://autoapp.auto.sohu.com/api/eval/list/model_4095_size_20_page_1
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化tableview
    [self setupTableView];
    // 加载头部数据
    [self loadHeaderData];
    // 加载身体数据
    [self loadContentData];
}

- (void)loadHeaderData {
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/eval/stat/model_%@",self.modelId];
    [[WJHttpTool httpTool]get:urlString params:nil success:^(id result) {
        WJHeaderAppraiseModel *appraiseModel = [WJHeaderAppraiseModel mj_objectWithKeyValues:result];
        WJLog(@"%@",appraiseModel);
    } failure:^(NSError *error) {
        
    }];
}

- (void)loadContentData {
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/eval/list/model_%@_size_20_page_1",self.modelId];
    [[WJHttpTool httpTool]get:urlString params:nil success:^(id result) {
        _listArray = [WJContentAppraiseModel mj_objectArrayWithKeyValuesArray:result];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (void)setupTableView {
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self constraintTableView];
}

- (void)constraintTableView {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJContentAppraiseModel *listModel = self.listArray[indexPath.row];
    WJPraiseTableViewCell *cell = [WJPraiseTableViewCell praiseTableViewCellWithTableView:tableView];
    cell.appraiseList = listModel;
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 330;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleView = [[UILabel alloc]init];
    titleView.size = CGSizeMake(WJScreenW, 30);
    titleView.text = @"  全部口碑";
    titleView.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    return titleView;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

@end
