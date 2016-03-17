//
//  YUCategoryViewController.m
//  fashionDance
//
//  Created by qianfeng on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "YUCategoryViewController.h"
#import "YUHotTopicModel.h"
#import "YUDBManager.h"
#import "YUHotTopicCell.h"
#import "YUTopicWebViewController.h"

static NSString *const hotTopicCellID = @"YUHotTopicCell";

@interface YUCategoryViewController ()
/** 收藏的帖子数组 */
@property (nonatomic, strong) NSMutableArray *collectArray;

@end

@implementation YUCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.delaysContentTouches = NO;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YUHotTopicCell class]) bundle:nil] forCellReuseIdentifier:hotTopicCellID];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *array = [[YUDBManager sharedManager] searchAllTopic];
        weakSelf.collectArray = [NSMutableArray arrayWithArray:array];
        // 回主线程刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf setbackgroundImage];
            
            [weakSelf.tableView reloadData];
        });
    });
}

- (void)setbackgroundImage
{
    self.tableView.backgroundColor = self.collectArray.count > 0 ? WJColor(245, 245, 245) : [UIColor colorWithPatternImage:[UIImage imageNamed:@"topic"]];
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.collectArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YUHotTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:hotTopicCellID];
    cell.topicModel = self.collectArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUTopicWebViewController *webVc = [[YUTopicWebViewController alloc]init];

    webVc.topicModel = self.collectArray[indexPath.row];
    
    [self.navigationController pushViewController:webVc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUHotTopicModel *topic = self.collectArray[indexPath.row];
    if (topic.pic1 || topic.imgUrl) {
        
        return  140;
    } else {
        return 60;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    YUHotTopicModel *topic = self.collectArray[indexPath.row];
//    
//    [[YUDBManager sharedManager] deleteCollectWithTopic:topic];
//    
//    [self.collectArray removeObjectAtIndex:indexPath.row];
//    
//    [self.tableView reloadData];
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        YUHotTopicModel *topic = self.collectArray[indexPath.row];
        
        [[YUDBManager sharedManager] deleteCollectWithTopic:topic];
        
        [self.collectArray removeObjectAtIndex:indexPath.row];
        
        [self setbackgroundImage];
        
        [self.tableView reloadData];
        
    }];
    return @[action1];
}

@end
