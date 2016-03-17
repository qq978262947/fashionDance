//
//  TSHalfController.m
//  fashionDance
//
//  Created by Dylan on 3/17/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSHalfController.h"

@interface TSHalfController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation TSHalfController
+(instancetype)halfControllerWithArray:(NSArray *)dataArray andTitleArray:(NSArray *)titleArray;
{
    TSHalfController * half=[TSHalfController new];
    half.dataArray=dataArray;
    half.titleArray=titleArray;
    return half;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * seArray=self.dataArray[section];
    return seArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifity=NSStringFromClass([UITableViewCell class]);
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifity];
    NSArray * seArray=self.dataArray[indexPath.section];
    cell.textLabel.text=seArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //回调
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
