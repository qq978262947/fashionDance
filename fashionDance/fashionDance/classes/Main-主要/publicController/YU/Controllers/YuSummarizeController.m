//
//  WJSummarizeController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YuSummarizeController.h"
#import "YUSummarizeHeaderView.h"
#import "SVProgressHUD.h"
#import "YUSummarizeCell.h"
#import "YUSummarizeHeaderView.h"
#import "YUCarCellModel.h"
#import "YUCarDetailModel.h"

static NSString *Id = @"cell";

@interface YuSummarizeController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) YUSummarizeHeaderView *headerView;

@property (nonatomic, strong) NSArray *CarCellModels;

@end

@implementation YuSummarizeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // http://autoapp.auto.sohu.com/api/model/info/4905
    // http://autoapp.auto.sohu.com/api/model/trimList/4905
    
    [self setupTableView];
    [self loadHeaderData];
    [self loadCellData];
}

- (void)loadHeaderData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/model/info/%@",self.modelId];
    
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:urlString params:nil success:^(id result) {
        
      //   NSLog(@"%@",result);
        
        YUCarDetailModel *detailModel = [YUCarDetailModel mj_objectWithKeyValues:result];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.headerView.model = detailModel;
        });
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}

- (void)loadCellData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/model/trimList/%@",self.modelId];
    
    __weak typeof (self) weakSelf = self;
    [[WJHttpTool httpTool] get:urlString params:nil success:^(id result) {
        
        //   NSLog(@"%@",result);
        
        weakSelf.CarCellModels = [YUCarCellModel mj_objectArrayWithKeyValuesArray:result];
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 设置inset
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64 + 35, 0);
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
  //  tableView.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YUSummarizeCell class]) bundle:nil] forCellReuseIdentifier:Id];
    
    // 添加headerView
    YUSummarizeHeaderView *headerView = [YUSummarizeHeaderView headerView];
    self.headerView = headerView;
    
    self.tableView.tableHeaderView = headerView;
    tableView.rowHeight = 70;
}

#pragma mark -tableVew代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.CarCellModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUSummarizeCell  *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    
    cell.model = self.CarCellModels[indexPath.section];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    YUCarCellModel *model = self.CarCellModels[section];
    
    return model.trimTypeName;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
@end
