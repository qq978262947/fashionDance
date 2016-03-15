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
//封装的滚动title数据条倒入
#import "WJContainerView.h"

@interface LLCarTypeDetailController ()
@property(nonatomic,strong)NSString * modelID;

//model
@property(nonatomic,strong)LLCarTypeInfoModel * carInfoModel;
@property(nonatomic,strong)NSArray * carTrimList;
@property(nonatomic,strong)LLCarOffSaleListModel * carOffSaleList;

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

-(void)setupUI
{
    WJContainerView * containerView = [WJContainerView containerView];
    containerView.titles = @[@"综述",@"参数",@"图片",@"口碑",@"二手车",@"文章",@"论坛"];
    containerView.isOpenAnimation = YES;
}

-(void)questInfo
{
    //进行网络请求
    NSDictionary * prama = @{@"modelID":self.modelID};
    __weak typeof(self) weakSelf = self;
    [[WJHttpTool httpTool] get:infoBaseUrl params:prama success:^(id result) {
        //封装数据
        LLCarTypeInfoModel * carInfoModel = [LLCarTypeInfoModel mj_objectWithKeyValues:result];
        weakSelf.carInfoModel = carInfoModel;
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}

-(void)questTrimList
{
    //进行网络请求
    NSDictionary * prama = @{@"modelID":self.modelID};
    __weak typeof(self) weakSelf = self;
    [[WJHttpTool httpTool] get:trimListBaseUrl params:prama success:^(id result) {
        //封装数据
        self.carTrimList = [LLCarTypeVersionModel mj_objectArrayWithKeyValuesArray:result];
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}

-(void)questOffSaleList
{
    //进行网络请求
    NSDictionary * prama = @{@"modelID":self.modelID,@"year":@"2014"};
    __weak typeof(self) weakSelf = self;
    [[WJHttpTool httpTool] get:offSaleBaseUrl params:prama success:^(id result) {
        //封装数据
        self.carOffSaleList = [LLCarOffSaleListModel mj_objectWithKeyValues:result];
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}


@end
