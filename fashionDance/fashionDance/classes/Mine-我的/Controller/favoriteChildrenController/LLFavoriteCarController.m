//
//  LLFavoriteCarController.m
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLFavoriteCarController.h"
#import "MJRefresh.h"

#import "LLDBCarManager.h"

#import "YUCarDetailModel.h"

#import "UIImageView+downloadImage.h"
@interface LLFavoriteCarController ()

@end

@implementation LLFavoriteCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LLCell"];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.carData = [[LLDBCarManager sharedManager] searchAllCar];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
        [self.tableView reloadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.carData = [[LLDBCarManager sharedManager] searchAllCar];
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_footer endRefreshing];
        });
    }];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LLCell" forIndexPath:indexPath];
    
    YUCarDetailModel * model = self.carData[indexPath.row];
    [cell.imageView setNormalImagewithURL:[NSURL URLWithString:model.picFocus] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    [cell.textLabel setText:model.nameZh];
    return cell;
}

#pragma mark cellSize
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
