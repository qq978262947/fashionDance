//
//  LLParameterModel.h
//  fashionDance
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLParameterModel : NSObject
//厂商指导价
@property(nonatomic,strong)NSString * a102;
//经销商最低报价
@property(nonatomic,strong)NSString * a103;
//车厂
@property(nonatomic,strong)NSString * a104;
//级别
@property(nonatomic,strong)NSString * a105;
//车体结构
@property(nonatomic,strong)NSString * a106;
//发动机
@property(nonatomic,strong)NSString * a107;
//变速箱
@property(nonatomic,strong)NSString * a108;
//工信部油耗
@property(nonatomic,strong)NSString * a294;
//官方0-100加速
@property(nonatomic,strong)NSString * a113;
//保养周期
@property(nonatomic,strong)NSString * a114;
//保养政策
@property(nonatomic,strong)NSString * a115;
//动力类型
@property(nonatomic,strong)NSString * a303;
//长宽高
@property(nonatomic,strong)NSString * a293;

//upview组标
@property(nonatomic,strong)NSString * MODELNAME;
@property(nonatomic,strong)NSString * NAME;
@property(nonatomic,strong)NSNumber * YEAR;
@end
