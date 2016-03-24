//
//  LLFavoriteTopicController.m
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLFavoriteTopicController.h"
#import "YUDBManager.h"
#import "YUHotTopicModel.h"
#import "YUHotTopicCell.h"

//要跳转到的control
#import "YUTopicWebViewController.h"

//数据库
#import "YUDBManager.h"

#import "MJRefresh.h"

@interface LLFavoriteTopicController ()


@end

@implementation LLFavoriteTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        self.forumData = [[YUDBManager sharedManager] searchAllTopic];
        self.tableView.mj_footer.state = MJRefreshStateIdle;

        [self.tableView reloadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.forumData = [[YUDBManager sharedManager] searchAllTopic];
        self.tableView.mj_footer.state = MJRefreshStateIdle;

        [self.tableView reloadData];
    }];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YUHotTopicCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YUHotTopicCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.forumData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    YUHotTopicCell * cellTmp = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YUHotTopicCell class]) forIndexPath:indexPath];
    cellTmp.topicModel = self.forumData[indexPath.row];
    
    cell = cellTmp;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUHotTopicModel *topic = self.forumData[indexPath.row];
    if (topic.pic1 || topic.imgUrl) {
        
        return  140;
    } else {
        return 60;
    }

}

#pragma mark head,foot相关
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
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

#pragma mark selectRow
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //取出相应model
    YUTopicWebViewController *topicWebVc = [[YUTopicWebViewController alloc]init];
    topicWebVc.topicModel = self.forumData[indexPath.row];
    [self.navigationController pushViewController:topicWebVc animated:YES];
    
}

@end
