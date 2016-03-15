//
//  WJShowsTopperController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/8.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CarPreferentialController.h"
#import "MKVideoCell.h"

static NSString *cellId = @"MKVideoCell";
@interface CarPreferentialController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation CarPreferentialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = WJGlobalBg;
    
    // 设置tableview
    [self setupTableView];

}
- (void)setupTableView {
    //Nav的距离
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, WJScreenW, WJScreenH) style:UITableViewStylePlain];
    // 设置tableView的额外滚动区域
   // [tableView setContentInset:UIEdgeInsetsMake(0.0, 0.0, TableViewContentInset, 0.0)];
    [tableView setBackgroundColor:WJGlobalBg];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    //tableView.backgroundColor = [UIColor colorWithRed:0.000 green:1.000 blue:0.502 alpha:1.000];
    self.tableView = tableView;
}

#pragma mark - Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MKVideoCell" owner:nil options:nil]lastObject];
    }
    //显示数据
   // NewsModel *model = self.dataArry[indexPath.row];
    return cell;
}


#pragma mark - Table view delegate methods
/**
 *  根据相应的数据设置cell的高度
 *
 *  @param indexPath cell的位置
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 86;
}


@end
