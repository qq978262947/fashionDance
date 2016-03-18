//
//  TSHalfWithoutModController.m
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSHalfWithoutModController.h"

@interface TSHalfWithoutModController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TSHalfWithoutModController
+(instancetype)halfControllerWithArray:(NSArray *)dataArray andTitleArray:(NSArray *)titleArray andtitle:(NSString *)title
{
    TSHalfWithoutModController * half=[TSHalfWithoutModController new];
    half.dataArray=dataArray;
    half.titleArray=titleArray;
    half.titleStr=title;
    return half;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configsubView];
}
-(void)configsubView
{
    //backView
    UIView * backView=[[UIView alloc]init];
    [self.view addSubview:backView];
    backView.backgroundColor=[UIColor darkGrayColor];
    backView.alpha=0.5;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(0);
    }];
    UIPanGestureRecognizer * pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction)];
    [backView addGestureRecognizer:pan];
    
    //toolView
    UIView * toolView=[[UIView alloc]init];
    [self.view addSubview:toolView];
    toolView.backgroundColor=WJGlobalBg;
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(80);
        make.top.equalTo(20);
        make.right.equalTo(0);
        make.height.equalTo(NAVH);
    }];
    UILabel * titleLabel=[[UILabel alloc]init];
    titleLabel.text=self.titleStr;
    [toolView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.width.equalTo(80);
    }];
    UIButton * btn=[[UIButton alloc]init];
    [toolView addSubview:btn];
    [btn addTarget:self action:@selector(gestureAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.width.equalTo(60);
    }];
    
    
    self.tableView=[[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(80);
        make.top.equalTo(NAVH+20);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}
-(void)gestureAction
{
    //self.TSSpecificControllerRetBlock(self,self.selectNumber,self.selectArray);
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * seArray=self.dataArray[section];
    return seArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifity=NSStringFromClass([UITableViewCell class]);
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifity];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifity];
    }
    NSArray * seArray=self.dataArray[indexPath.section];
    cell.textLabel.text=seArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //回调:计算数字，返回数字
    NSNumber * number;
    switch (indexPath.row) {
        case 0:
            number=[NSNumber numberWithInteger:0];
            break;
        case 1:
            number=[NSNumber numberWithInteger:1];
            break;
        case 2:
            number=[NSNumber numberWithInteger:2];
            break;
        case 3:
            number=[NSNumber numberWithInteger:3];
            break;
        case 4:
            number=[NSNumber numberWithInteger:4];
            break;
            
        default:
            break;
    }
    NSArray * seArray=self.dataArray[indexPath.section];
    self.TSHalfWithoutModControllerBlock(self,number,seArray[indexPath.row]);
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.titleArray[section];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end