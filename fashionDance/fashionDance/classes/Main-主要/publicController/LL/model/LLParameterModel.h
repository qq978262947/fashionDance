//
//  LLParameterModel.h
//  fashionDance
//
//  Created by 李璐 on 16/3/18.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLParameterModel : NSObject
#pragma mark 基本参数
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

#pragma mark 车身
//长度
@property(nonatomic,strong)NSString * a117;
//宽度
@property(nonatomic,strong)NSString * a118;
//高度
@property(nonatomic,strong)NSString * a119;
//轴距
@property(nonatomic,strong)NSString * a120;
//前轮距
@property(nonatomic,strong)NSString * a121;
//后轮距
@property(nonatomic,strong)NSString * a122;
//车身结构
@property(nonatomic,strong)NSString * a124;
//车门数
@property(nonatomic,strong)NSString * a125;
//座位数
@property(nonatomic,strong)NSString * a126;
//发动机描述
@property(nonatomic,strong)NSString * a134;
//排量
@property(nonatomic,strong)NSString * a136;
//气缸容积
@property(nonatomic,strong)NSString * a137;
//工作方式
@property(nonatomic,strong)NSString * a138;
//气缸数
@property(nonatomic,strong)NSString * a139;
//气缸排列形式
@property(nonatomic,strong)NSString * a140;
//每缸气门数
@property(nonatomic,strong)NSString * a141;
//气门结构
@property(nonatomic,strong)NSString * a142;
//最大马力
@property(nonatomic,strong)NSString * a297;
//最大功率
@property(nonatomic,strong)NSString * a298;
//最大扭矩
@property(nonatomic,strong)NSString * a299;
//升功率
@property(nonatomic,strong)NSString * a148;
//燃料
@property(nonatomic,strong)NSString * a149;
//供油方式
@property(nonatomic,strong)NSString * a150;
//缸盖材料
@property(nonatomic,strong)NSString * a151;
//缸体材料
@property(nonatomic,strong)NSString * a152;
//排放标准
@property(nonatomic,strong)NSString * a155;
//变速箱简称
@property(nonatomic,strong)NSString * a156;
//档位个数
@property(nonatomic,strong)NSString * a157;
//变速箱类型
@property(nonatomic,strong)NSString * a158;

#pragma mark 底盘／车轮制动
//驱动方式
@property(nonatomic,strong)NSString * a159;
//前悬挂类型
@property(nonatomic,strong)NSString * a160;
//后悬挂类型
@property(nonatomic,strong)NSString * a161;
//底盘结构
@property(nonatomic,strong)NSString * a162;
//前轮胎规格
@property(nonatomic,strong)NSString * a163;
//后轮胎规格
@property(nonatomic,strong)NSString * a164;
//材料
@property(nonatomic,strong)NSString * a165;
//备胎规格
@property(nonatomic,strong)NSString * a166;
//前制动器类型
@property(nonatomic,strong)NSString * a167;
//后制动器类型
@property(nonatomic,strong)NSString * a168;
//驻车制动器类型
@property(nonatomic,strong)NSString * a169;
//分动器类型
@property(nonatomic,strong)NSString * a170;
//转向助力
@property(nonatomic,strong)NSString * a171;
//可调悬挂
@property(nonatomic,strong)NSString * a172;
//空气悬挂
@property(nonatomic,strong)NSString * a173;

//upview组标
@property(nonatomic,strong)NSString * MODELNAME;
@property(nonatomic,strong)NSString * NAME;
@property(nonatomic,strong)NSNumber * YEAR;
@end
