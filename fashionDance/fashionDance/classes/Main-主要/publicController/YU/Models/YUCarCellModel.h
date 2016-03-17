//
//  YUCarCellModel.h
//  fashionDance
//
//  Created by qianfeng on 16/3/17.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YUCarCellModel : NSObject

@property (nonatomic, assign) NSInteger trimId;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *nameZh;

@property (nonatomic, assign) CGFloat priceGuide;

@property (nonatomic, copy) NSString *drvType;

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) CGFloat maxDprice;

@property (nonatomic, copy) NSString *transType;

@property (nonatomic, assign) CGFloat minDprice;

@property (nonatomic, copy) NSString *trimTypeName;

@end
