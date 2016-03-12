//
//  LLCarTypeDetailController.m
//  fashionDance
//
//  Created by 李璐 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLCarTypeDetailController.h"
#import "LLCarTypeInfoModel.h"
#import "LLCarTypeVersionModel.h"
#import "LLCarOffSaleListModel.h"

//collection cell的导入
#import "LLPictureCollectionCell.h"
#import "LLTextCollectionCell.h"

//封装的滚动title数据条倒入
#import "WJContainerView.h"

//自己写的collection布局
#include "LLCollectionViewLayout.h"

@interface LLCarTypeDetailController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSString * modelID;

//model
@property(nonatomic,strong)LLCarTypeInfoModel * carInfoModel;
@property(nonatomic,strong)NSArray * carTrimList;
@property(nonatomic,strong)LLCarOffSaleListModel * carOffSaleList;

//seciton1数据源
@property(nonatomic,strong)NSArray * section1Data;

//section1 section header辅助字典
@property(nonatomic,strong)NSDictionary * section1HeaderDic;

//section1 装载数据指示器－－是在售数据还是停售数据
@property(nonatomic,assign)BOOL isSale;

//view
@property(nonatomic,weak)UICollectionView * collectionView;
@end

@implementation LLCarTypeDetailController

static NSString * const infoBaseUrl = @"http://autoapp.auto.sohu.com/api/model/info";

static NSString * const trimListBaseUrl = @"http://autoapp.auto.sohu.com/api/model/trimList";

static NSString * const offSaleBaseUrl = @"http://autoapp.auto.sohu.com/api/model/offsaleList";
#pragma mark 初始化方法
+(LLCarTypeDetailController *)controllerWithModelId:(NSString *)modelID
{
    LLCarTypeDetailController * contrl = [[LLCarTypeDetailController alloc]init];
    contrl.modelID = modelID;
    return contrl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初始化界面
    [self setupUI];
    
    //网络请求
    [self questInfo];
    [self questTrimList];
    [self questOffSaleList];
}
#pragma mark ui初始化
-(void)setupUI
{
    //滚动条
    WJContainerView * containerView = [WJContainerView containerView];
    containerView.titles = @[@"综述",@"参数",@"图片",@"口碑",@"二手车",@"文章",@"论坛"];
    containerView.selectedTitleColor = [UIColor redColor];
    containerView.isOpenAnimation = YES;
    [self.view addSubview:containerView];
}

#pragma mark tableview配置
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        LLCollectionViewLayout * layout = [[LLCollectionViewLayout alloc]init];
        UICollectionView * view = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight) collectionViewLayout:layout];
        [self.view addSubview:view];
        view.dataSource = self;
        view.delegate = self;
        [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];

        _collectionView = view;
    }
    return _collectionView;
}


#pragma mark tableview数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //根据自定义的layout，一共两个section
    if (section == 0) {
        return 1;
    }
    return self.section1Data.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    [cell setBackgroundColor:WArcColor];
    
    return cell;

}


#pragma mark 网络请求
-(void)questInfo
{
    //进行网络请求
    //拼接网址
    NSString * url = [infoBaseUrl stringByAppendingPathComponent:self.modelID];
    [[WJHttpTool httpTool] get:url params:nil success:^(id result) {
        //封装数据
        LLCarTypeInfoModel * carInfoModel = [LLCarTypeInfoModel mj_objectWithKeyValues:result];
        self.navigationItem.title = [carInfoModel.rootBrandNameZh stringByAppendingString:carInfoModel.nameZh];
        //设置nav title
        self.carInfoModel = carInfoModel;
        
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}

-(void)questTrimList
{
    //进行网络请求
    NSString * url = [trimListBaseUrl stringByAppendingPathComponent:self.modelID];
    [[WJHttpTool httpTool] get:url params:nil success:^(id result) {
        //封装数据
        self.carTrimList = [LLCarTypeVersionModel mj_objectArrayWithKeyValuesArray:result];
        self.carTrimList makeObjectsPerformSelector:<#(nonnull SEL)#>
        
        [self.collectionView reloadData];
        //默认选中trim
        self.isSale = YES;
        self.section1Data = self.carTrimList;
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}

-(void)questOffSaleList
{
    //进行网络请求
    NSString * url = [offSaleBaseUrl stringByAppendingPathComponent:self.modelID];
    url = [url stringByAppendingPathComponent:@"2014"];
    [[WJHttpTool httpTool] get:url params:nil success:^(id result) {
        //封装数据
        self.carOffSaleList = [LLCarOffSaleListModel mj_objectWithKeyValues:result];
        
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}


@end
