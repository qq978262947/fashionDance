//
//  WJFindCarResult.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJFindCarResult : NSObject

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger modelId;

@property (nonatomic, assign) NSInteger priceMin;

@property (nonatomic, copy) NSString *pageUrl;

@property (nonatomic, assign) NSInteger priceMax;

@property (nonatomic, assign) long long pubDate;

@property (nonatomic, copy) NSString *modelName;

@end
