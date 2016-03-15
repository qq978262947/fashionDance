//
//  LLCarTypeVersionModel.h
//  __PRODUCTNAME__
//
//  Created by 李璐 on 16/03/11
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LLCarTypeVersionModel : NSObject

@property (nonatomic, assign) NSInteger trimId;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *nameZh;

@property (nonatomic, assign) NSInteger min2scPrice;

@property (nonatomic, copy) NSString *drvType;

@property (nonatomic, assign) CGFloat max2scPrice;

@property (nonatomic, copy) NSString *transType;

@property (nonatomic, assign) CGFloat priceGuide;

@property (nonatomic, copy) NSString *trimTypeName;

//trimList中属性
@property(nonatomic,strong)NSNumber * minDprice;

@property(nonatomic,strong)NSNumber * maxDprice;

@property(nonatomic,strong)NSNumber * year;

@end