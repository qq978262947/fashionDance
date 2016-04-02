//
//  llParameterController.m
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "llParameterController.h"
#import "LLDownView.h"
#import "LLUpView.h"
#import "LLParameterModel.h"

#import "NSObject+Property.h"
#define left_width 100
#define down_cell_height WJScreenH/12
#define down_up_cell_width 150
#define up_cell_height WJScreenH/6

@interface llParameterController ()

@property(nonatomic,strong)NSArray * dataArray;

@property(nonatomic,weak)LLUpView * upView;

@property(nonatomic,weak)LLDownView * downView;
@end

static NSString * const baseUrl = @"http://autoapp.auto.sohu.com/api/model/para";
@implementation llParameterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    //网络请求
    [self quest];
}

-(NSString *)modelId
{
    if (!_modelId) {
        _modelId = @"4905";
    }
    return _modelId;
}

-(void)quest
{
    NSString * url = [baseUrl stringByAppendingPathComponent:self.modelId];
    [[WJHttpTool httpTool] get:url params:nil success:^(id result) {
        //封装数据
        WJLog(@"llParameterController网络请求成功");
        self.dataArray = [LLParameterModel mj_objectArrayWithKeyValuesArray:result];
//        WJLog(@"%@",[[self.dataArray lastObject] dictionaryValue]);
        //给两个字 view复之
        self.upView.data = self.dataArray;
        self.downView.data = self.dataArray;
    } failure:^(NSError *error) {
        //给出提示
        WJLog(@"LLCarTypeDetailController网络请求失败%@",error);
    }];
}

-(void)setupUI
{
    //加载上 view
    UINib * nib = [UINib nibWithNibName:NSStringFromClass([LLUpView class]) bundle:nil];
    
    LLUpView * upView = [nib instantiateWithOwner:nil options:nil].lastObject;
    [upView setFrame:CGRectMake(0, 0, WJScreenW, up_cell_height)];
    upView.leftWidth = left_width;
    upView.widthCell = down_up_cell_width;
    [self.view addSubview:upView];
    self.upView = upView;
    
    //加载下 view
    LLDownView * downView = [[LLDownView alloc]init];
    [downView setFrame:CGRectMake(0, up_cell_height, WJScreenW, WJScreenH - up_cell_height - 103)];
    downView.leftWidth = left_width;
    downView.cellHeight = down_cell_height;
    downView.cellWidth = down_up_cell_width;
    [self.view addSubview:downView];
    self.downView = downView;
}
/**
 * 一个view（内含tableview左，collection view右），一个view（内含scroll view）组成
 * 上下结构，联动效果
 */

@end
