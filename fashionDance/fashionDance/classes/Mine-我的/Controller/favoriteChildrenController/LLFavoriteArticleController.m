//
//  LLFavoriteArticleController.m
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLFavoriteArticleController.h"
//文章收藏
#import "LLDBArticleManager.h"
#import "WJConsultingResult.h"
#import "WJConsultingCell.h"
#import "WJConsultingNoPicCell.h"

//要跳转到页面
#import "WJWebViewController.h"

//数据库
#import "LLDBArticleManager.h"

#import "MJRefresh.h"
@interface LLFavoriteArticleController ()

@end

@implementation LLFavoriteArticleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
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
    return self.articleData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    WJList *list = self.articleData[indexPath.row];
    if (list.picUrl == nil || [list.picUrl isEqualToString:@""]) {
        WJConsultingNoPicCell *cellTmp = [WJConsultingNoPicCell consultingCellWithTableView:tableView];
        cellTmp.list = list;
        
        cell = cellTmp;
    }else {
        WJConsultingCell *cellTmp  = [WJConsultingCell consultingCellWithTableView:tableView];
        cellTmp.list = list;
        
        cell = cellTmp;
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJList *list = self.articleData[indexPath.row];
    if (list.picUrl == nil || [list.picUrl isEqualToString:@""]) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake(WJScreenW - 2 * 10, MAXFLOAT);
        // 计算文字的高度
        CGFloat height = [list.title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
        return height + 20 + 20 + 5;
    }
    return 90;

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
    WJList * list = self.articleData[indexPath.row];
    WJWebViewController * webControl = [[WJWebViewController alloc]init];
    webControl.urlString = list.url;
    webControl.articleModel = list;
    //跳转到相应界面
    [self.navigationController pushViewController:webControl animated:YES];
}

#pragma mark 刷新
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.articleData = [[LLDBArticleManager sharedManager] searchAllArticle];
    [self.tableView reloadData];
}

@end
