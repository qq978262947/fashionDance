//
//  LLFavoriteController.m
//  fashionDance
//
//  Created by 李璐 on 16/3/24.
//  Copyright © 2016年 汪俊. All rights reserved.
//

/**
 * 我们要从数据库中取值
 */

#import "LLFavoriteController.h"
#import "WJContainerView.h"
//论坛收藏
#import "YUDBManager.h"
#import "YUHotTopicModel.h"
#import "YUHotTopicCell.h"

//文章收藏
#import "LLDBArticleManager.h"
#import "WJConsultingResult.h"
#import "WJConsultingCell.h"
#import "WJConsultingNoPicCell.h"

@interface LLFavoriteController ()<UITableViewDataSource,UITableViewDelegate>

//一共三个view 都是tableview
@property(nonatomic,weak)UITableView * tableView;//汽车
@property(nonatomic,weak)UITableView * articleTableView;//文章
@property(nonatomic,weak)UITableView * forumTableView;//论坛

//头顶的横条
@property(nonatomic,weak)UIView * headView;
//记录选中的button
@property(nonatomic,weak)UIButton * defaultButton;

//数据
@property(nonatomic,strong)NSArray * forumData;
@property(nonatomic,strong)NSArray * articleData;
@end

@implementation LLFavoriteController

-(UIView *)headView
{
    if (!_headView) {
        UIView * view = [[UIScrollView alloc]initWithFrame:CGRectMake(0, WTopHeight, WJScreenW, 50)];
        [view setBackgroundColor:[UIColor orangeColor]];
        CGFloat buttonWidth = view.frame.size.width/3;
        NSArray * array = @[@"车型",@"文章",@"帖子"];
        for (int i = 0; i < 3; i++) {
            //三个button
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, view.size.height)];
            button.tag = 100 + i;
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            button.contentMode = UIViewContentModeCenter;
            [view addSubview:button];
            //默认显示的页
            if (i == 1) {
                self.defaultButton = button;
            }
        }
        [self.view addSubview:view];
        _headView = view;
    }
    return _headView;
}

#pragma mark 展示哪条数据
-(void)buttonSelected:(UIButton *)sender
{
    //这个是forum
    NSArray * topicArray = [[YUDBManager sharedManager] searchAllTopic];
    self.forumData = topicArray;
    //article
    self.articleData = [[LLDBArticleManager sharedManager] searchAllArticle];

    if (![sender isEqual:self.defaultButton]) {
        self.defaultButton.selected = NO;
        sender.selected = YES;
        //取出tag，展示相应数据
        switch (sender.tag) {
            case 100:
                //车
                [self.view bringSubviewToFront:self.tableView];
                break;
            case 101:
                //文章
                [self.view bringSubviewToFront:self.articleTableView];
                break;
            case 102:
                //帖子
                [self.view bringSubviewToFront:self.forumTableView];
                break;
                
            default:
                break;
        }//end switch
    }//end fi
    else
    {
        [self articleTableView];
    }
    [self.view bringSubviewToFront:self.headView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    WJContainerView * scrollTitleView = [WJContainerView containerView];
//    [scrollTitleView setFrame:CGRectMake(0, WTopHeight, WJScreenW, WJScreenH - WTopHeight)];
//    [self.view addSubview:scrollTitleView];
//    scrollTitleView.
    [self articleTableView];

    //默认数据呈现出来
    [self headView];//为了获得defaultButton
    [self buttonSelected:self.defaultButton];//为了展示数据
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_forumTableView]) {
        return self.forumData.count;
    }
    else if ([tableView isEqual:_articleTableView])
    {
        return self.articleData.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if ([tableView isEqual:_forumTableView]) {
        YUHotTopicCell * cellTmp = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YUHotTopicCell class]) forIndexPath:indexPath];
        cellTmp.topicModel = self.forumData[indexPath.row];
        
        cell = cellTmp;
    }
    else if ([tableView isEqual:_articleTableView])
    {
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

    }
    
    return cell;
}

#pragma mark cellHeight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_forumTableView]) {
        YUHotTopicModel *topic = self.forumData[indexPath.row];
        if (topic.pic1 || topic.imgUrl) {
            
            return  140;
        } else {
            return 60;
        }
    }
    else if([tableView isEqual:_articleTableView])
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
    return 200;
}

#pragma mark tableview的设置
-(UITableView *)articleTableView
{
    if (!_articleTableView) {
        UITableView * view = [[UITableView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:view];
        view.dataSource = self;
        view.delegate = self;
        
        _articleTableView = view;
    }
    return _articleTableView;
}

-(UITableView *)forumTableView
{
    if (!_forumTableView) {
        UITableView * view = [[UITableView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:view];
        view.dataSource = self;
        view.delegate = self;
        [view registerNib:[UINib nibWithNibName:NSStringFromClass([YUHotTopicCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YUHotTopicCell class])];
        
        _forumTableView = view;
    }
    return _forumTableView;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView * view = [[UITableView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:view];
        view.dataSource = self;
        view.delegate = self;
        
        _tableView = view;
    }
    return _tableView;
}

@end
