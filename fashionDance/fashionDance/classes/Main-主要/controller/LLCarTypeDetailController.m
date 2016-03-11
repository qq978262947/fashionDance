//
//  LLCarTypeDetailController.m
//  fashionDance
//
//  Created by 李璐 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import "LLCarTypeDetailController.h"
#import "LLCarTypeInfoModel.h"

@interface LLCarTypeDetailController ()

@property(nonatomic,strong)NSString * modelID;

@end

@implementation LLCarTypeDetailController

#pragma mark 初始化方法
+(LLCarTypeDetailController *)controllerWithModelId:(NSString *)modelID
{
    LLCarTypeDetailController * contrl = [[LLCarTypeDetailController alloc]init];
    contrl.modelID = modelID;
    return contrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行网络请求
    NSDictionary * prama = @{@"modelID":self.modelID};
    [[WJHttpTool httpTool]get:@"http://autoapp.auto.sohu.com/api/model/info" params:prama success:^(id result) {
        //封装数据
        LLCarTypeInfoModel * carInfoModel = [LLCarTypeInfoModel mj_objectWithKeyValues:result];
    } failure:^(NSError *error) {
        //给出提示
    }];
}

@end
