//
//  WJMoreAboutCarModel.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WJMoreAboutCarUser;
@interface WJMoreAboutCarModel : NSObject


@property (nonatomic, copy) NSString *service;

@property (nonatomic, copy) NSString *outside;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *buyPlace;

@property (nonatomic, assign) NSInteger flagStatus;

@property (nonatomic, copy) NSString *inside;

@property (nonatomic, copy) NSString *dissatisfy;

@property (nonatomic, copy) NSString *space;

@property (nonatomic, assign) NSInteger trimId;

@property (nonatomic, copy) NSString *oprate;

@property (nonatomic, assign) NSInteger youhao;

@property (nonatomic, assign) NSInteger fuwu;

@property (nonatomic, assign) NSInteger neishi;

@property (nonatomic, assign) NSInteger buyMonth;

@property (nonatomic, copy) NSString *carName;

@property (nonatomic, strong) WJMoreAboutCarUser *user;

@property (nonatomic, assign) NSInteger buyYear;

@property (nonatomic, copy) NSString *satisfy;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, assign) NSInteger shushi;

@property (nonatomic, copy) NSString *power;

@property (nonatomic, assign) NSInteger dongli;

@property (nonatomic, assign) NSInteger caokong;

@property (nonatomic, assign) NSInteger waiguan;

@property (nonatomic, assign) CGFloat fuel;

@property (nonatomic, copy) NSString *others;

@property (nonatomic, copy) NSString *cost_performance;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *pubTime;

@property (nonatomic, assign) NSInteger modelId;

@property (nonatomic, assign) NSInteger xingjia;

@property (nonatomic, copy) NSString *fuelcost;

@property (nonatomic, copy) NSString *comfort;

@property (nonatomic, copy) NSString *buyAim;

@property (nonatomic, assign) NSInteger kongjian;

@property (nonatomic, copy) NSString *modelNameZh;

@property (nonatomic, strong) NSArray<NSString *> *carPhotoList;

@property (nonatomic, assign) NSInteger avgScore;



@end
@interface WJMoreAboutCarUser : NSObject

@property (nonatomic, copy) NSString *passport;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *nickName;

@end

