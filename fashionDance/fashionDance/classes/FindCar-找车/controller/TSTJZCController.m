//
//  TSTJZCController.m
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSTJZCController.h"
#import "TSDrawView.h"
#import "TSTitleCell.h"
#import "TSSpecificController.h"
@interface TSTJZCController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray * titleArray;
@property (nonatomic,strong)NSArray * specicsArray;
@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)UIView * toolBarView;
@property (nonatomic,strong)UIButton * resetBtn;
//符合条件按钮
@property (nonatomic,strong)UIButton * eligibleBtn;
@end

@implementation TSTJZCController
-(NSArray *)specicsArray
{
    if (_specicsArray==nil)
    {
        NSString * path=[[NSBundle mainBundle]pathForResource:@"TSConfigList.plist" ofType:nil];
        _specicsArray=[NSArray arrayWithContentsOfFile:path];
    }
    return _specicsArray;
}
-(NSMutableArray *)titleArray
{
    if (_titleArray==nil) {
        NSString * path=[[NSBundle mainBundle]pathForResource:@"TSTitleList.plist" ofType:nil];
        _titleArray=[NSMutableArray arrayWithContentsOfFile:path];
    }
    return _titleArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configSubviews];
}
-(void)configSubviews
{
    //底部符合条件视图
    UIView * toolBarView=[[UIView alloc]init];
    [self.view addSubview:toolBarView];
    self.toolBarView=toolBarView;
    toolBarView.backgroundColor=[UIColor whiteColor];
    [toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
        make.height.equalTo(80);
    }];
    //重置按钮
    UIButton * resetBtn=[[UIButton alloc]init];
    resetBtn.selected=YES;
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [resetBtn addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarView addSubview:resetBtn];
    [resetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.width.equalTo(80);
    }];
    //符合条件按钮
    UIButton * eligibleBtn=[[UIButton alloc]init];
    [eligibleBtn setBackgroundColor:[UIColor redColor]];
    [eligibleBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [eligibleBtn setTitle:@"有0个车型符合条件" forState:UIControlStateNormal];
    [self.toolBarView addSubview:eligibleBtn];
    self.eligibleBtn=eligibleBtn;
    [self.eligibleBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(resetBtn.mas_right);
        make.right.equalTo(-10);
        make.top.equalTo(15);
        make.bottom.equalTo(-15);
    }];
    
    
    
    //tableview
    self.tableView=[[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(toolBarView.mas_top);
    }];
    self.view.backgroundColor=[UIColor redColor];
    TSDrawView * drawView=[[TSDrawView alloc]initWithFrame:CGRectMake(0, 0, SCRW, 150)];
    self.tableView.tableHeaderView=drawView;
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}
-(void)resetAction
{
    NSLog(@"resetAction");
}
-(void)searchAction
{
    NSLog(@"searchAction");
}
/*
 http://autoapp.auto.sohu.com/api/search/count-1024-0-3-0-0-0-0-0-0-0
 http://autoapp.auto.sohu.com/api/search/count-1024-0-7-0-0-0-0-0-0-0
 http://autoapp.auto.sohu.com/api/search/count-1024-0-7-0-0-0-0-0-0-25
 http://autoapp.auto.sohu.com/api/search/count-1024-0-7-0-0-0-0-0-11-25
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSTitleCell * cell=[TSTitleCell cellWithTableView:tableView];
    cell.nameLabel.text=self.titleArray[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TSSpecificController * spec=[TSSpecificController specificControllerWithArray:self.specicsArray[indexPath.row] andTitle:self.titleArray[indexPath.row]];
    [self presentViewController:spec animated:YES completion:nil];
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
