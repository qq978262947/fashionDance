//
//  WJCarDetailsController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "WJCarDetailsController.h"
#import "WJMoreAboutCarModel.h"
#import "WJCarDetailHeaderView.h"
#import "WJCarDetailPicCell.h"

//http://autoapp.auto.sohu.com/api/eval/16477

@interface WJCarDetailsController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) WJMoreAboutCarModel *appraiseModel;

@end

@implementation WJCarDetailsController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self setupHeaderView];
    
    [self loadData];
    
}

- (void)setupHeaderView {
    self.tableView.bounces = NO;
    // 设置headerview
    WJCarDetailHeaderView *headerView = [WJCarDetailHeaderView carDetailHeaderViewViewWithFrame:CGRectMake(0, 0, WJScreenW, 270)];
    headerView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.tableView.tableHeaderView = headerView;
}

- (void)loadData {
    NSString *urlString = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/eval/%@",self.modelId];
    [[WJHttpTool httpTool]get:urlString params:nil success:^(id result) {
        WJMoreAboutCarModel *appraiseModel = [WJMoreAboutCarModel mj_objectWithKeyValues:result];
        self.appraiseModel = appraiseModel;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *titleView = [[UILabel alloc]init];
    titleView.size = CGSizeMake(WJScreenW, 30);
    if (section == 0) {
       titleView.text = @"  实拍图片";
    } else if (section == 1) {
       titleView.text = @"  车主评价";
    }
    titleView.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    return titleView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.appraiseModel) return 0;
    if (section == 0) {
        return 1;
    }
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    WJMoreAboutCarModel *listModel = self.carDetailArray[indexPath.row];
//    WJPraiseTableViewCell *cell = [WJPraiseTableViewCell praiseTableViewCellWithTableView:tableView];
//    cell.appraiseList = listModel;
//    return cell;
    if (indexPath.row == 0) {
        WJCarDetailPicCell *cell = [WJCarDetailPicCell carDetailPicCellWithTableView:tableView];
        if (self.appraiseModel.carPhotoList.count) {
            cell.picUrlString = self.appraiseModel.carPhotoList[0];
        }
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        return cell;
    }
}

@end
