//
//  WJShowsTopperController.m
//  fashionDance
//
//  Created by Monky on 16/3/8.
//  Copyright © 2016年 Monky. All rights reserved.
//

#import "CarPreferentialController.h"
#import "MKVideoCell.h"
#import "MJRefresh.h"
#import "MKVediosModel.h"
#import "WJHttpTool.h"
#import "MKVedioDetailController.h"

static NSString *cellId = @"MKVideoCell";
@interface CarPreferentialController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,strong)UIButton *lastButton;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)MKVediosModel *model;

@property (nonatomic,strong)NSString *path;
@end

@implementation CarPreferentialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = WJGlobalBg;
    
    // 设置tableview
    //[self setupView];
    //
     [self setupRefresh];
    
}
- (void)setupRefresh
{    // 设置tableview
     [self setupView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downloadData)];
    [self.tableView.mj_header beginRefreshing];
    
    
}

- (void)setupView {
    //标题视图
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVH+20, WJScreenW, BTNH)];
    self.titleView =titleView;
    titleView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self.view addSubview:titleView];
    NSArray *btnArr = @[@"全部",@"原创",@"集锦",@"海外",@"试驾"];
    //添加子视图
    [self creatBtnWithArray:btnArr];
    //Nav的距离
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, NAVH+BTNH+20, WJScreenW, WJScreenH-(NAVH+BTNH+20)-TabbarH) style:UITableViewStylePlain];
    [tableView setBackgroundColor:WJGlobalBg];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

- (void)creatBtnWithArray:(NSArray *)array
{
    
    CGFloat width = WJScreenW/5;
    CGFloat height = 40;
    
    for (int i = 0; i<array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*width, 0, width, height);
        [self.titleView addSubview:btn];
        [btn setTitleColor:[UIColor colorWithWhite:0.600 alpha:1.000] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        if (i ==0) {
            btn.selected = YES;
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            self.lastButton = btn;
             self.path = @"http://autoapp.auto.sohu.com/api/columnnews/list_5_0_20";
        }
    }
}


- (void)touchBtn:(UIButton *)btn
{
    
    self.lastButton.selected = NO;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btn.selected = YES;
    self.lastButton = btn;
    if (btn.tag==1) {
        self.path =@"http://autoapp.auto.sohu.com/api/columnnews/list_6_0_20";
        
    }else if (btn.tag ==2) {
        self.path =@"http://autoapp.auto.sohu.com/api/columnnews/list_7_0_20";
    }else if (btn.tag ==3) {
        self.path =@"http://autoapp.auto.sohu.com/api/columnnews/list_8_0_20";
    }else if (btn.tag ==4)
    {
        self.path =@"http://autoapp.auto.sohu.com/api/columnnews/list_9_0_20";
    }else{
        self.path = @"http://autoapp.auto.sohu.com/api/columnnews/list_5_0_20";
    }
    [self downloadData];
}

- (void)downloadData
{
    __weak typeof(self) weakSelf = self;
    [[WJHttpTool httpTool]get:_path params:nil success:^(id result) {
        
      //  NSLog(@"%@",result);
         NSError *error;
        weakSelf.model = [[MKVediosModel alloc]initWithData:result error:&error];
        weakSelf.dataArray = [NSMutableArray arrayWithArray:weakSelf.model.result.newsList];
     //   NSLog(@"%@",weakSelf.dataArray);
        [weakSelf.tableView reloadData];

         [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MKVideoCell" owner:nil options:nil]lastObject];
    }
    //显示数据
    VedioResultList *list = self.dataArray[indexPath.row];
    [cell configureModel:list];
    return cell;
}


#pragma mark - Table view delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 107;
}

#pragma mark-------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MKVedioDetailController *vdVC = [[MKVedioDetailController alloc]init];
    vdVC.hidesBottomBarWhenPushed = YES;
    vdVC.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
    VedioResultList *list = self.dataArray[indexPath.row];
    

    NSString *str1 = @"http://autoapp.auto.sohu.com/auto-app/news2/";
    NSString *str2 = [NSString stringWithFormat:@"%@",list.cmsId];
    NSString *str3 = @".html?src=11640001";
    NSString *path = [NSString stringWithFormat:@"%@%@%@",str1,str2,str3];
    vdVC.path = path;
    NSLog(@"cmsID:%@",vdVC.path);
    [self.navigationController pushViewController:vdVC animated:YES];
}

@end
