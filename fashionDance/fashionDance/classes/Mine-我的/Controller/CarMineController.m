//
//  CarMineController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/20.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "CarMineController.h"
#import "LLLocationController.h"
#import "LLFavoriteController.h"
#import "LLBuyCarCaculateController.h"
#import "LLFeedBackController.h"
#import "LLPeccancyController.h"


@interface CarMineController ()<UITableViewDataSource,UITableViewDelegate>

{
    LLLocationController * locationCtrl;
    LLFavoriteController * favoriteCtrl;
    LLBuyCarCaculateController * caculateCtrl;
    LLPeccancyController * peccancyCtrl;
    LLFeedBackController * feedBackCtrl;
}

@property(nonatomic,weak)UITableView * tableView;

@end

@implementation CarMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WJGlobalBg;
    
    [self setupUI];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [self.view addSubview:tableView];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
        
        _tableView = tableView;
    }
    return _tableView;
}

-(void)setupUI
{
    //头图
    self.tableView;
}


#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows;
    switch (section) {
        case 0:
            rows = 1;
            break;
            
            case 1:
            rows = 1;
            break;

            case 2:
            rows = 2;
            break;

            case 3:
            rows = 1;
            break;
            
        default:
            break;
    }
    return rows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_head"]];
    }
    else if (indexPath.section == 1&&indexPath.row == 0)
    {
        //收藏夹
        cell.textLabel.text = @"收藏夹";

    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        //所在城市
        cell.textLabel.text = @"所在城市";
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        //违规查询
        cell.textLabel.text = @"违规查询";
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        //购车计算
        cell.textLabel.text = @"购车计算";
    }
    else
    {
        //意见反馈
        cell.textLabel.text = @"意见反馈";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark tableviewCellSize
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rows;
    switch (indexPath.section) {
        case 0:
            rows = 150;
            break;
            
        case 1:
            rows = 80;
            break;
            
        case 2:
            rows = 80;
            break;
            
        case 3:
            rows = 80;
            break;
            
        default:
            break;
    }
    return rows;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    int rows;
    switch (section) {
        case 0:
            rows = 0;
            break;
            
        case 1:
            rows = 20;
            break;
            
        case 2:
            rows = 20;
            break;
            
        case 3:
            rows = 20;
            break;
            
        default:
            break;
    }
    return rows;
}

#pragma mark tableviewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //进入相应页面
    if (indexPath.section == 0) {
    }
    else if (indexPath.section == 1&&indexPath.row == 0)
    {
        //收藏夹
        if (!favoriteCtrl) {
            favoriteCtrl = [[LLFavoriteController alloc]init];
        }
        [self.navigationController pushViewController:favoriteCtrl animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
        //所在城市
        if (!locationCtrl) {
            locationCtrl = [[LLLocationController alloc]init];
        }
        [self.navigationController pushViewController:locationCtrl animated:YES];

    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        //违规查询
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        //购车计算
    }
    else
    {
        //意见反馈
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
