//
//  WJConsultingResult.h
//  fashionDance
//
//  Created by 汪俊 on 16/3/11.
//  Copyright © 2016年 汪俊. All rights reserved.
//

#import <Foundation/Foundation.h>


@class WJModelResult,WJList;
@interface WJConsultingResult : NSObject


@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) WJModelResult *result;

@property (nonatomic, assign) NSInteger code;



@end


@interface WJModelResult : NSObject

@property (nonatomic, assign) long long st;

@property (nonatomic, assign) long long et;

@property (nonatomic, strong) NSArray<WJList *> *list;

@end

@interface WJList : NSObject

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, assign) long long pubtime;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger brandId;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger subbrandId;

@property (nonatomic, assign) NSInteger modelId;

@property (nonatomic, copy) NSString *url;

@end

