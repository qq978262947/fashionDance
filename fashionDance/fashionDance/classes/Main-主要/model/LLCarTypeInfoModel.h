//
//  LLCarTypeInfoModel.h
//  SDWebImage
//
//  Created by 李璐 on 16/03/11
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LLCarTypeInfoModel : NSObject

@property (nonatomic, assign) CGFloat avgScore;

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

@property (nonatomic, strong) NSArray *engineSize;

@property (nonatomic, assign) NSInteger modelId;

@property (nonatomic, assign) CGFloat min;

@end