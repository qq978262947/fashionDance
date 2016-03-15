//
//  TSBrandCarController.m
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSBrandCarController.h"

@interface TSBrandCarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;

@end

@implementation TSBrandCarController
-(UITableView *)tableView
{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]init];
    }
    return _tableView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor greenColor];
    //[self configSubViews];
    
}
-(void)configSubViews
{
    //配置tableView
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(0);
        make.top.equalTo(@(NAVH+20));
        make.right.equalTo(0);
        make.bottom.equalTo(@TabbarH);
    }];
    self.view.backgroundColor=[UIColor greenColor];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
