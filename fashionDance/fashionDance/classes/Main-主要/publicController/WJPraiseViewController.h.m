//
//  CCParameterViewController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/16.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJPraiseViewController.h"

@interface WJPraiseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *tableView;

@end

@implementation WJPraiseViewController
// http://autoapp.auto.sohu.com/api/eval/stat/model_4095
// http://autoapp.auto.sohu.com/api/eval/list/model_4095_size_20_page_1
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化tableview
    [self setupTableView];
}


- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
