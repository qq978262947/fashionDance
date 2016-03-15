//
//  WJShowsTopperController.m
//  fashionDance
//
//  Created by Monky on 16/3/8.
//  Copyright © 2016年 Monky. All rights reserved.
//

#import "CarPreferentialController.h"
#import "MKVideoCell.h"


static NSString *cellId = @"MKVideoCell";
@interface CarPreferentialController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,assign)NSInteger lastTag;
@end

@implementation CarPreferentialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景色
    self.view.backgroundColor = WJGlobalBg;
    
    // 设置tableview
    [self setupView];
    
}
- (void)setupView {
    //标题视图
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVH+20, WJScreenW, BTNH)];
    self.titleView =titleView;
    titleView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    [self.view addSubview:titleView];
    NSArray *btnArr = @[@"全部",@"原创",@"集锦",@"海外",@"试驾"];
    //添加子视图
    [self creatBtnWithArray:btnArr];
    //Nav的距离
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, NAVH+BTNH+20, WJScreenW, WJScreenH-(NAVH+BTNH+20)-TabbarH) style:UITableViewStylePlain];
    [tableView setBackgroundColor:WJGlobalBg];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}


- (void)creatBtnWithArray:(NSArray *)array
{
    
    CGFloat width = WJScreenW/5;
    CGFloat height = 40;
    
    for (int i = 0; i<array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*width, 0, width, height);
        [self.titleView addSubview:btn];
        [btn setTitleColor:[UIColor colorWithWhite:0.600 alpha:1.000] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        if (i ==0) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        self.lastTag =0;
    }
}


- (void)touchBtn:(UIButton *)btn
{
    NSLog(@"btn:%ld",btn.tag);
    if (self.lastTag !=btn.tag) {
        //恢复之前按钮颜色
        UIButton *lastBtn = (UIButton *)[self.view viewWithTag:self.lastTag];
        
        [lastBtn setTitleColor:[UIColor colorWithWhite:0.600 alpha:1.000] forState:UIControlStateNormal];
        UIButton *currentbtn = (UIButton *)[self.view viewWithTag:btn.tag];
        //修改当前颜色
        [currentbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        //修改序号
        self.lastTag = btn.tag;
    }
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
    return 107;
}


@end
