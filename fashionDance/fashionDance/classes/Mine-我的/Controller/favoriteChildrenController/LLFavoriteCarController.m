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

#import "YuSummarizeController.h"
@interface LLFavoriteCarController ()

@end

@implementation LLFavoriteCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LLCell"];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //push到相应界面
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YUCarDetailModel * model = self.carData[indexPath.row];
    YuSummarizeController * control = [[YuSummarizeController alloc]init];
    control.modelId = [NSString stringWithFormat:@"%ld",(long)model.modelId];
    [self.navigationController pushViewController:control animated:YES];
}
#pragma mark 尺寸相关
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}


#pragma mark 刷新
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.carData = [[LLDBCarManager sharedManager] searchAllCar];
    [self.tableView reloadData];
}
@end
