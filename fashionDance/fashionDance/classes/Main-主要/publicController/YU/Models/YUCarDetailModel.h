
//
//  YUCarDetailModel.h
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YUCarDetailModel : NSObject

@property (nonatomic, assign) NSInteger avgScore;

@property (nonatomic, assign) CGFloat minDprice;

@property (nonatomic, copy) NSString *picFocus;

@property (nonatomic, copy) NSString *barId;

@property (nonatomic, copy) NSString *nameZh;

@property (nonatomic, copy) NSString *type1;

@property (nonatomic, copy) NSString *rootBrandNameZh;

@property (nonatomic, assign) CGFloat max;

@property (nonatomic, strong) NSArray *offSaleYearList;

@property (nonatomic, assign) CGFloat maxDprice;

@property (nonatomic, assign) NSInteger countPics;

@property (nonatomic, assign) NSInteger rootBrandId;

@property (nonatomic, copy) NSString *engineSize1;

@property (nonatomic, copy) NSString *engineSize2;

@property (nonatomic, assign) NSInteger modelId;

@property (nonatomic, assign) CGFloat min;

@end
