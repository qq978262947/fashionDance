//
//  TSBrandCarController.m
//  fashionDance
//
//  Created by Dylan on 3/14/16.
//  Copyright © 2016 汪俊. All rights reserved.
//

#import "TSBrandCarController.h"
#import "TSTitleCell.h"
#import "SWBrandHeadView.h"
#import "SWSectionModel.h"
#import "TSCarMod.h"
#import "UIImageView+WebCache.h"

#import "SWCarCell.h"

#import "LLDBCarManager.h"
#import "YUCarDetailModel.h"
#import "UIImageView+downloadImage.h"
#import "MJRefresh.h"

#import "TSHotlistManagerModel.h"
#import "TSSXCarModel.h"

//跳转到车详情界面
#import "YuSummarizeController.h"
#define height_dbview WJScreenH/4
@interface TSBrandCarController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) NSArray *sectionArray;

//后期加入的view－－我的收藏、浏览记录、热门排行
@property(nonatomic,weak)UITableView * dbView;
@property(nonatomic,weak)UIView * dbViewFatherView;
@property(nonatomic,strong)NSArray * dbViewDataArray;
@property(nonatomic,strong)TSHotlistManagerModel * hotlistManagerModel;
//判断当前是数据库取出来的yu model还是请求的ts model
@property(nonatomic,assign)BOOL isHotlist;
@end

@implementation TSBrandCarController

-(UITableView *)dbView
{
    if (!_dbView) {
        UITableView * view = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, WJScreenW, height_dbview) style:UITableViewStylePlain];
        view.rowHeight = 70;
        view.dataSource = self;
        view.delegate = self;
        [view registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lldbcell"];
        [_dbViewFatherView addSubview:view];
        
        _dbView = view;
    }
    self.tabBarController.tabBar.hidden = YES;
    _dbViewFatherView.hidden = NO;
    return _dbView;
}

-(UIView *)dbViewFatherView
{
    if (!_dbViewFatherView) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, WJScreenH - height_dbview - 100, WJScreenW, height_dbview)];
        _dbViewFatherView = view;
        [self.view addSubview:view];
        //添加tableview
        [self dbView];
        //添加关闭按钮
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, WJScreenW, 40)];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(closeDbView) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [view setBackgroundColor:[UIColor grayColor]];
    }
    return _dbViewFatherView;
}

-(void)closeDbView
{
    self.dbViewFatherView.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

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

    //先行添加dbview，再隐藏，防止后来dbview和dbViewFatherView调用顺序不对
    [self dbViewFatherView];
    [self closeDbView];
    //NSLog(@"%@",self.sectionArray);
}

/**
 *  初始化头部空间
 */

-(void)setupHeadView
{
 
    SWBrandHeadView *redView = [[SWBrandHeadView alloc]init];
    redView.height = 80;
    [redView setButtonClickBlock:^(UIButton * sender)
    {
        NSString * senderNomalTitle = [sender titleForState:UIControlStateNormal];
        if ([senderNomalTitle isEqualToString:@"我的收藏"]) {
            //导出我的收藏car数据
            self.isHotlist = NO;
            self.dbView.mj_footer = nil;
            self.dbViewDataArray = [[LLDBCarManager sharedManager] searchAllCar];
        }
        else if ([senderNomalTitle isEqualToString:@"浏览历史"])
        {
            //导入我的浏览car数据
            self.isHotlist = NO;
            self.dbView.mj_footer = nil;
            self.dbViewDataArray = [[LLDBCarManager sharedManager] searchAllfootmark];
        }
        else
        {
            //热门排行
            //请求数据
            self.isHotlist = YES;
            self.dbViewDataArray= nil;
            [self questFor:0 page:@"1"];
            //给tableview加上刷新控件
            __weak typeof(self) weakSelf = self;
            self.dbView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
                int page = [weakSelf.hotlistManagerModel.pageIndex intValue]+2;
                NSString * pageString = [NSString stringWithFormat:@"%d",page];
                [weakSelf questFor:weakSelf.hotlistManagerModel.number page:pageString];
            }];
        }
        [self.dbView reloadData];
    }];
    redView.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = redView;
}

#pragma mark 网络请求
-(void)questFor:(int)number page:(NSString*)page
{
    NSString * url = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/model/listHot/body_%d_type_6_page_%@",number,page];
    [[WJHttpTool httpTool] get:url params:nil success:^(id result) {
        //封装数据
        WJLog(@"TSBrandCarController网络请求成功");
        NSArray * sxCarModelArray = [result objectForKey:@"items"];
        sxCarModelArray = [TSSXCarModel mj_objectArrayWithKeyValuesArray:sxCarModelArray];
        if ([page integerValue] == 1) {
            self.dbViewDataArray = sxCarModelArray;
        }
        else
        {
            self.dbViewDataArray = [self.dbViewDataArray arrayByAddingObjectsFromArray:sxCarModelArray];
        }
        self.hotlistManagerModel = [TSHotlistManagerModel mj_objectWithKeyValues:result];
        self.hotlistManagerModel.number = number;
        [self.dbView reloadData];
        //停止刷新
        [self.dbView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}

-(void)questForCid:(NSNumber*)cid
{
    NSString * baseUrl = [NSString stringWithFormat:@"http://autoapp.auto.sohu.com/api/model/listByRoot/%@",cid];
    [[WJHttpTool httpTool] get:baseUrl params:nil success:^(id result) {
        WJLog(@"TSBrandCarController网络请求成功");
        NSArray * arrayTmp;
        for (NSString * key in result) {
            arrayTmp = [result objectForKey:key];
        }
        self.dbViewDataArray = [TSSXCarModel mj_objectArrayWithKeyValuesArray:arrayTmp];
        self.isHotlist = YES;
        [self.dbView reloadData];
    } failure:^(NSError *error) {
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableView]) {
        return self.sectionArray.count;
    }
    else
    {
        //是dbview
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        SWSectionModel *swModel = self.sectionArray[section];
        return swModel.citys.count;
    }
    else
    {
        //是dbview
        return self.dbViewDataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        SWSectionModel *swModel = self.sectionArray[indexPath.section];
        TSCarMod *model = swModel.citys[indexPath.row];
        SWCarCell * cell = [SWCarCell carCellWithTableView:tableView];
        cell.model = model;
        return cell;
    }
    else
    {
        //是dbview
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"lldbcell"];
        if (self.isHotlist) {
            TSSXCarModel * model = self.dbViewDataArray[indexPath.row];
            [cell.imageView setNormalImagewithURL:[NSURL URLWithString:model.modelUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //
            }];
            [cell.textLabel setText:model.modelName];
        }
        else
        {
            YUCarDetailModel * model = self.dbViewDataArray[indexPath.row];
            [cell.imageView setNormalImagewithURL:[NSURL URLWithString:model.picFocus] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                //
            }];
            [cell.textLabel setText:model.nameZh];
        }
        return cell;
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        SWSectionModel *swModel = self.sectionArray[section];
        return swModel.initial;
    }
    return nil;
}
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.tableView]) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i<self.sectionArray.count; i++) {
            SWSectionModel *model = self.sectionArray[i];
            [arr addObject:model.initial];
        }
        return arr;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:self.dbView]) {
        //跳转到车详情界面
        NSString * modelId;
        if (self.isHotlist) {
            TSSXCarModel * model = self.dbViewDataArray[indexPath.row];
            modelId = [model.modelId stringValue];
        }
        else
        {
            YUCarDetailModel * model = self.dbViewDataArray[indexPath.row];
            modelId = [NSString stringWithFormat:@"%ld",(long)model.modelId];
        }
        YuSummarizeController * control = [[YuSummarizeController alloc]init];
        control.modelId = modelId;
        [self.navigationController pushViewController:control animated:YES];
    }
    else
    {
        //将dbview footer去掉
        self.dbView.mj_footer = nil;
        //读取CarData数据进行网络请求
        SWSectionModel *swModel = self.sectionArray[indexPath.section];
        TSCarMod *model = swModel.citys[indexPath.row];
        [self questForCid:model.cid];
    }
}

@end
