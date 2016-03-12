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
//@property(nonatomic,strong)LLCarOffSaleListModel * carOffSaleList;
@property(nonatomic,strong)NSArray * carOffSaleListArray;

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

static NSString * const pictureReuseID = @"LLPictureCollectionCell";

static NSString * const textReuseID = @"LLTextCollectionCell";
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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //初始化界面
    [self setupUI];
    
    //网络请求
    [self questInfo];
    [self questTrimList];
    [self questOffSaleList];
    
    //初始化在售button被选中状态
    self.isSale = YES;
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

#pragma mark section1数据配置
-(NSArray *)section1Data
{
    if (self.isSale) {
        _section1Data = self.carTrimList;
    }
    else
    {
        _section1Data = self.carOffSaleListArray;
    }
    return _section1Data;
}

#pragma mark tableview配置
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        LLCollectionViewLayout * layout = [LLCollectionViewLayout layoutWithDataSoure:self.section1Data];
        UICollectionView * view = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WScreenWidth, WScreenHeight) collectionViewLayout:layout];
        [self.view addSubview:view];
        view.dataSource = self;
        view.delegate = self;
        [view registerNib:[UINib nibWithNibName:pictureReuseID bundle:nil] forCellWithReuseIdentifier:pictureReuseID];
        [view registerNib:[UINib nibWithNibName:textReuseID bundle:nil] forCellWithReuseIdentifier:textReuseID];

        _collectionView = view;
    }
    return _collectionView;
}


#pragma mark tableview数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    WJLog(@"请求了Sections数");
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    WJLog(@"请求了items数 section--%ld section1Data.count--%lu",(long)section,(unsigned long)self.section1Data.count);
    //根据自定义的layout，一共两个section
    if (section == 0) {
        return 1;
    }
//    WJLog(@"section1Data -- %lu",(unsigned long)self.section1Data.count);
    return self.section1Data.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    WJLog(@"请求cell %ld -- %ld",(long)indexPath.section,(long)indexPath.item);
    UICollectionViewCell * cell;
    if (indexPath.section == 0) {
        LLPictureCollectionCell * cellTmp = [collectionView dequeueReusableCellWithReuseIdentifier:pictureReuseID forIndexPath:indexPath];
        cellTmp.data = self.carInfoModel;
        [cellTmp setIsSaleDataChangedBlock:^(BOOL isSale)
        {
            self.isSale = isSale;
            [self.collectionView reloadData];
            [self.collectionView scrollsToTop];
        }];
        
        cell = cellTmp;
    }
    else
    {
        LLTextCollectionCell * cellTmp = [collectionView dequeueReusableCellWithReuseIdentifier:textReuseID forIndexPath:indexPath];
        cellTmp.data = self.section1Data[indexPath.item];
        
        cell = cellTmp;
    }
    
    return cell;

}

#pragma mark 网络请求
-(void)questInfo
{
    //进行网络请求
    //拼接网址
    NSString * url = [infoBaseUrl stringByAppendingPathComponent:self.modelID];
    [[WJHttpTool httpTool] get:url params:nil success:^(id result) {
        WJLog(@"LLCarTypeDetailController网络请求成功");
        
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
        WJLog(@"LLCarTypeDetailController网络请求成功");

        //封装数据
        self.carTrimList = [LLCarTypeVersionModel mj_objectArrayWithKeyValuesArray:result];
        [self.carTrimList makeObjectsPerformSelector:@selector(configSale)];
        
        [self.collectionView reloadData];
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
        WJLog(@"LLCarTypeDetailController网络请求成功");

        NSMutableArray * arrayTmp = [NSMutableArray array];
        //封装数据
        for (NSString * year in result) {
            //得到年限key
            NSArray * yearTypeArray = [result objectForKey:year];
            [arrayTmp addObjectsFromArray:[LLCarTypeVersionModel mj_objectArrayWithKeyValuesArray:yearTypeArray]];
            [arrayTmp makeObjectsPerformSelector:@selector(configOffSaleWithYear:) withObject:@([year floatValue])];
        }
        
        self.carOffSaleListArray = arrayTmp;
        
        [self.collectionView reloadData];
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}

@end
