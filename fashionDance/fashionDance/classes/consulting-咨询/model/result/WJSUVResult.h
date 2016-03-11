//
//  WJSUVResult.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WJCarModel;
@interface WJSUVResult : NSObject
@property (nonatomic, strong) NSArray<WJCarModel *> *items;

@property (nonatomic, copy) NSString *pageIndex;

@property (nonatomic, copy) NSString *pageSize;

@property (nonatomic, copy) NSString *itemCount;

@property (nonatomic, copy) NSString *pageCount;
@end



@interface WJCarModel : NSObject

@property (nonatomic, copy) NSString *modelUrl;

@property (nonatomic, copy) NSString *modelId;

@property (nonatomic, copy) NSString *modelName;

@property (nonatomic, copy) NSString *minPrice;

@property (nonatomic, copy) NSString *maxPrice;

@property (assign, nonatomic) CGFloat pictureProgress;

@end

