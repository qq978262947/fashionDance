//
//  TSSpecificController.m
//  fashionDance
//
//  Created by Dylan on 3/15/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSSpecificController.h"

@interface TSSpecificController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView * tableView;
@end

@implementation TSSpecificController
+(instancetype)specificControllerWithArray:(NSArray *)specificArray andTitle:(NSString *)title
{
    TSSpecificController * spec=[TSSpecificController new];
    spec.specificArray=specificArray;
    spec.titleStr=title;
    return spec;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configSubView];
    // Do any additional setup after loading the view.
}
-(void)configSubView
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
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(0);
        make.top.equalTo(0);
        make.bottom.equalTo(0);
        make.width.equalTo(60);
    }];
    
    //tableview
    self.tableView=[[UITableView alloc]init];
    self.tableView.editing=YES;
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
//    self.tableView.au
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(80);
        make.right.equalTo(0);
        make.top.equalTo(NAVH+20);
        make.bottom.equalTo(0);
    }];
    
}
-(void)gestureAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.specificArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifity=NSStringFromClass([UITableViewCell class]);
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:identifity];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifity];
    }
    cell.textLabel.text=self.specificArray[indexPath.row];
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleInsert |UITableViewCellEditingStyleDelete;//选择界面
}
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
