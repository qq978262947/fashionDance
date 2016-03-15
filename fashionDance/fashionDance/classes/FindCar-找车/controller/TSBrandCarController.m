//
//  TSBrandCarController.m
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSBrandCarController.h"

#import "SWBrandHeadView.h"
#import "SWSectionModel.h"
#import "TSCarMod.h"
#import <UIImageView+WebCache.h>

#import "SWCarCell.h"
@interface TSBrandCarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSArray *sectionArray;
@end

@implementation TSBrandCarController
-(NSArray *)sectionArray{
    if (_sectionArray==nil) {
        
        NSArray *array=[SWSectionModel mj_objectArrayWithFilename:@"CarData.plist"];
        self.sectionArray = array;
        
        
    }
    return _sectionArray;
}

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    

    [self configSubViews];
    
}
-(void)configSubViews
{
    //配置tableView
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.sectionIndexColor = [UIColor darkGrayColor];
    
   
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(0);
        make.top.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(@TabbarH);
    }];
   
    self.view.backgroundColor=[UIColor greenColor];
 
    [self setupHeadView];

    //NSLog(@"%@",self.sectionArray);
}

/**
 *  初始化头部空间
 */

-(void)setupHeadView
{
 
    SWBrandHeadView *redView = [[SWBrandHeadView alloc]init];
    redView.height = 80;
    
    redView.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = redView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SWSectionModel *swModel = self.sectionArray[section];
    return swModel.citys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWSectionModel *swModel = self.sectionArray[indexPath.section];
    TSCarMod *model = swModel.citys[indexPath.row];
    SWCarCell * cell = [SWCarCell carCellWithTableView:tableView];
    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SWSectionModel *swModel = self.sectionArray[section];
    return swModel.initial;
    
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<self.sectionArray.count; i++) {
        SWSectionModel *model = self.sectionArray[i];
        [arr addObject:model.initial];
    }
    return arr;
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
